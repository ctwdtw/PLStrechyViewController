//
//  ViewController.swift
//  HealthToAllFlesh
//
//  Created by Paul Lee on 18/03/2017.
//  Copyright © 2017 Paul Lee. All rights reserved.
//

import UIKit

open class PLStrechyViewController: UIViewController {
  private let defaultNibName = "PLStrechyViewController"
  private(set) var defaultFeedImage: UIImage? = {
    let bundle = Bundle(for: PLStrechyViewController.self)
    return UIImage(named: "PLStrechyViewController.bundle/defaultStrechyImage",
                   in: bundle, compatibleWith: nil)
  }()
  private(set) var defaultFeedText: String = {
    let text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.\n\n"
    
    return String(repeating: text, count: 7)
  }()
  @IBOutlet private weak var messageTextView: UITextView!
  public var feedText: String? = nil {
    willSet(newValue) {
      guard messageTextView.text != nil else {
        return
      }
      messageTextView.text = newValue
    }
  }
  @IBOutlet private weak var feedImageView: UIImageView!
  public var feedImage: UIImage? = nil {
    willSet(newValue) {
      guard feedImageView != nil else {
        return
      }
      feedImageView.image = newValue
    }
  }
  @IBOutlet weak var strechyViewHeight: NSLayoutConstraint!
  @IBOutlet weak var strechyViewHeadPosition: NSLayoutConstraint!
  @IBOutlet weak var strechyViewControllingViewVerticalSpace: NSLayoutConstraint!
  @IBOutlet var strechyViewAspectRatio: NSLayoutConstraint!
  
  override final public func loadView() {
    let view = viewFromNib()
    self.view = view
  }
  
  func viewFromNib() -> UIView {
    let bundle = Bundle(for: PLStrechyViewController.self)
    let view = bundle.loadNibNamed(defaultNibName, owner: self, options: nil)?.first as! UIView
    return view
  }
  
  override open func viewDidLoad() {
    super.viewDidLoad()
    configureSubviews()
  }
  
  private func configureSubviews() {
    //`messageTextView`
    messageTextView.delegate = self
    messageTextView.isScrollEnabled = false
    feedText = feedText == nil ? defaultFeedText : feedText
    
    //strechy `feedImageView`
    //strechyViewHeight.constant = StrechyViewConst.defaultHeight
    layoutStrechyView()
    feedImage = feedImage == nil ? defaultFeedImage : feedImage
    
    //navigation Bar
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.isTranslucent = true
    self.navigationController?.view.backgroundColor = .clear
  }
  
  override open func viewWillTransition(to size: CGSize,
                                        with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    
    //work around, this could be apple's bug: `viewWillTransition:to size:with coordinate`
    //was called before `viewDidLoad` in as second child vc of an instance of UITabBarController
    //which can cause `messageTextView` become nil therefore cause crash.
    guard let messageTextView = messageTextView else {
      return
    }//end work around
    
    messageTextView.isScrollEnabled = false
    
    self.layoutStrechyView()
    coordinator.animate(alongsideTransition: nil) { (_) in
      //after transition, you can put additional code here
      self.messageTextView.isScrollEnabled = true
    }
  }
  
  private func layoutStrechyView() {
    if UIDevice.current.orientation.isLandscape {
      landscapeLayout()
    } else {
      protraitLayout()
    }
  }
  
  private func landscapeLayout() {
    strechyViewHeight.constant = hasNavigationBar ? StrechyViewConst.defaultHeight : 0
    strechyViewAspectRatio.isActive = false
    strechyViewHeadPosition.constant = 0
    strechyViewControllingViewVerticalSpace.constant = 0
  }
  
  private func protraitLayout() {
    strechyViewHeight.constant = StrechyViewConst.defaultHeight
    strechyViewAspectRatio.isActive = true
  }
  
  //TODO:// can remove this?
  override open func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    messageTextView.isScrollEnabled = true
  }
  
}

extension PLStrechyViewController: UITextViewDelegate {}

// MARK:// UI Business Logic
extension PLStrechyViewController {
  var hasNavigationBar: Bool {
    
    return navigationController?.navigationBar == nil ? false : true
    
  }
  static var statusBarHeight: CGFloat {
    if UIDevice.current.orientation.isPortrait {
      return UIApplication.shared.statusBarFrame.size.height
    } else {
      return 0.0
    }
  
  }
  
  static var navigationBarHeight: CGFloat {
    if UIDevice.current.orientation.isPortrait {
      return 44.0
    } else {
      return 32.0
    }
  }
  
  // MARK: // strechyView Constants
  struct StrechyViewConst {
    static let animationDuration: TimeInterval = 0.3
    static var defaultHeight: CGFloat {
      if UIDevice.current.orientation.isPortrait {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let trueWidht = min(width, height)
        return trueWidht/5*3
      } else if UIDevice.current.orientation.isLandscape {
        return PLStrechyViewController.navigationBarHeight
      } else {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        if width > height {
          return 0
        } else {
          return width/5*3
        }
      }
    }
    static var maxHeight: CGFloat {
      return defaultHeight * 1.5
    }
    static let collapseHeadPosition: CGFloat = -StrechyViewConst.defaultHeight * 1/3
    static let extendHeadPosition: CGFloat = 0
    static var criticalHeadPosition: CGFloat {
      return collapseHeadPosition * 2/3
    }
  }
  
  struct ControllingViewConst {
    static var extendPosition: CGFloat = 0
    static func collapsePosition(_ hasNavigationBar: Bool) -> CGFloat {
      let navigationBarHeigth: CGFloat = hasNavigationBar ? PLStrechyViewController.navigationBarHeight : 0.0
      let returnValue = -StrechyViewConst.defaultHeight
        + abs(StrechyViewConst.collapseHeadPosition)
        + navigationBarHeigth + statusBarHeight
      return returnValue
    }
    
  }
  
  // MARK: // strechyView States
  enum StrechyViewExtendState {
    case strecyViewNotReachHeadPositionYet
    case controllingViewNotReachPostionYet
    case positionOverReached
    
    init(_ strechyViewHeadPosition: CGFloat, _ verticalSpaceToControllingView: CGFloat ) {
      if strechyViewHeadPosition < StrechyViewConst.extendHeadPosition {
        self = .strecyViewNotReachHeadPositionYet
        
      } else if verticalSpaceToControllingView < ControllingViewConst.extendPosition {
        self = .controllingViewNotReachPostionYet
        
      } else {
        self = .positionOverReached
        
      }
    }
  }
  
  enum StrechyViewCollapseState {
    case strechyViewNotReachHeadPositionYet
    case controllingViewNotReachPositonYet
    case positionOverReached
    
    init(_ strechyViewHeadPosition: CGFloat,
         _ verticalSpaceToControllingView: CGFloat,
         _ hasNavigationBar: Bool) {
      
      if strechyViewHeadPosition > StrechyViewConst.collapseHeadPosition {
        self = .strechyViewNotReachHeadPositionYet
        
      } else if verticalSpaceToControllingView > ControllingViewConst.collapsePosition(hasNavigationBar) {
        self = .controllingViewNotReachPositonYet
        
      } else {
        self = .positionOverReached
        
      }
    }
  }
}

extension PLStrechyViewController {
  // MARK: // strechyView Control logic
  fileprivate func extendStrechyView(_ scrollView: UIScrollView, scrolled offsetY: CGFloat) {
    guard strechyViewHeight.constant < StrechyViewConst.maxHeight else {
      scrollView.bounces = false
      return
    }
    
    let extendState = StrechyViewExtendState(strechyViewHeadPosition.constant,
                                             strechyViewControllingViewVerticalSpace.constant)
    
    if extendState == .strecyViewNotReachHeadPositionYet {
      strechyViewHeadPosition.constant += abs(offsetY/2)
      strechyViewControllingViewVerticalSpace.constant += abs(offsetY/2)
      
    } else if extendState == .controllingViewNotReachPostionYet {
      strechyViewHeadPosition.constant = StrechyViewConst.extendHeadPosition
      strechyViewControllingViewVerticalSpace.constant += abs(offsetY)
      
    } else if extendState == .positionOverReached {
      strechyViewHeadPosition.constant = StrechyViewConst.extendHeadPosition
      strechyViewControllingViewVerticalSpace.constant = ControllingViewConst.extendPosition
      strechyViewHeight.constant += abs(offsetY)
      
    }
  }
  
  fileprivate func collapseStrechyView(_ scrollView: UIScrollView, scrolled offsetY: CGFloat) {
    defer {
      strechyViewHeight.constant = StrechyViewConst.defaultHeight
    }
    
    let collapseState = StrechyViewCollapseState(strechyViewHeadPosition.constant,
                                                 strechyViewControllingViewVerticalSpace.constant,
                                                 hasNavigationBar)
    
    if collapseState == .strechyViewNotReachHeadPositionYet {
      scrollView.setContentOffset(CGPoint.zero, animated: false)
      strechyViewHeadPosition.constant -= offsetY/2
      strechyViewControllingViewVerticalSpace.constant -= offsetY/2
      
    } else if collapseState == .controllingViewNotReachPositonYet {
      scrollView.setContentOffset(CGPoint.zero, animated: false)
      strechyViewControllingViewVerticalSpace.constant -= offsetY
      
    } else if collapseState == .positionOverReached {
      strechyViewHeadPosition.constant = StrechyViewConst.collapseHeadPosition
      strechyViewControllingViewVerticalSpace.constant = ControllingViewConst.collapsePosition(hasNavigationBar)
      
    }
  }
  
  // MARK: // magnetEffet Helper
  fileprivate func magnetEffectAnimation() {
    let orientation = UIDevice.current.orientation
    guard orientation == UIDeviceOrientation.portrait else {
      return
    }
    
    if strechyViewHeadPosition.constant > StrechyViewConst.criticalHeadPosition {
      magnetEffectAnimationForExtend()
      
    } else if strechyViewHeadPosition.constant <= StrechyViewConst.criticalHeadPosition {
      magnetEffectAnimationForCollapse()
      
    }
  }
  
  fileprivate func magnetEffectAnimationForExtend() {
    UIView.animate(withDuration: StrechyViewConst.animationDuration) {
      self.strechyViewHeadPosition.constant = StrechyViewConst.extendHeadPosition
      self.strechyViewControllingViewVerticalSpace.constant = ControllingViewConst.extendPosition
      self.strechyViewHeight.constant = StrechyViewConst.defaultHeight
      self.view.layoutIfNeeded()
    }
  }
  
  fileprivate func magnetEffectAnimationForCollapse() {
    UIView.animate(withDuration: StrechyViewConst.animationDuration) {
      self.strechyViewHeadPosition.constant = StrechyViewConst.collapseHeadPosition
      self.strechyViewControllingViewVerticalSpace.constant = ControllingViewConst.collapsePosition(self.hasNavigationBar)
      self.strechyViewHeight.constant = StrechyViewConst.defaultHeight
      self.view.layoutIfNeeded()
    }
  }
  
}

// MARK: // UIScrollViewDelegate
extension PLStrechyViewController: UIScrollViewDelegate {
  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    let orientation = UIDevice.current.orientation
    guard orientation == UIDeviceOrientation.portrait else {
      return
    }
    
    let offsetY = scrollView.contentOffset.y
    
    if offsetY <= 0 { //圖片向下延展
      extendStrechyView(scrollView, scrolled: offsetY)
    } else if offsetY > 0 { //圖片向上收合
      collapseStrechyView(scrollView, scrolled: offsetY)
      
    }
    
    view.layoutIfNeeded()
  }
  
  public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    scrollView.bounces = true
    magnetEffectAnimation()
  }
  
  public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    guard decelerate == false else {
      return
    }
    
    scrollView.bounces = true
    magnetEffectAnimation()
  }
}
