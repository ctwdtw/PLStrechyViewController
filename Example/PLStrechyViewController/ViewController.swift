//
//  ViewController.swift
//  PLStrechyViewController
//
//  Created by ctwdtw on 12/13/2017.
//  Copyright (c) 2017 ctwdtw. All rights reserved.
//

import UIKit
import PLStrechyViewController
/*
class ViewController: UIViewController{
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}*/

class ViewController: PLStrechyViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let image = UIImage(named: "what_is_forgiveness")
    self.feedImage = image
    self.feedText = hardcodeFeedText
    self.navigationItem.title = "聞信息"
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
  }
  
  deinit {
    print("deinit")
  }
}

let hardcodeFeedText = "彼得認為他非常地慷慨，因為他可以一天原諒他的弟兄七次，然而耶穌卻告訴他他必須一天原諒490次。要某人一天得罪你490次是不可能的。耶穌實際上是在說我們的原諒應該是要沒有極限的。\n\n當我們被冒犯或是被傷害的時候，我們總是覺得懷恨在心是正當合理的。在舊約當中的律法這樣寫著：「以牙還牙，以眼還眼」(出埃及記21:33-35)。除非冒犯的代價被償還，我們不想要原諒。藉由將把罪放在完美的救主身上，上帝處理了人們的過犯。這救主代替了在歷史上的每個時刻的罪人受了審判。如果我們要求別人做一些事情來得到我們的原諒，那我們就不像基督了。耶穌為每個人的罪而死，並且當我們還是罪人的時候他就把原諒延伸到我們身上，因此，我們應該像耶穌一樣。\n\n經節中耶穌譬喻的要旨在於，當有人得罪我們時。我們應該記著上帝給予我們的極大的憐憫，並且以寬容的態度回應他。別人欠我們的任何債與我們被上帝所赦免的比較起來，都顯得微不足道。我們應該對別人有著如同基督對我們一樣的憐憫。\n\n如果上帝期待我們原諒一天冒犯我們490次的弟兄(事實上在猶太文化中代表一個無窮次的數字)，那麼肯定地，愛我們的上帝對我們的態度也不會比這更少。\n\n我們從上帝得著的原諒和任何我們被要求對別人的原諒比較起來是無限更多的。彼得認為他非常地慷慨，因為他可以一天原諒他的弟兄七次，然而耶穌卻告訴他他必須一天原諒490次。要某人一天得罪你490次是不可能的。耶穌實際上是在說我們的原諒應該是要沒有極限的。\n\n當我們被冒犯或是被傷害的時候，我們總是覺得懷恨在心是正當合理的。在舊約當中的律法這樣寫著：「以牙還牙，以眼還眼」(出埃及記21:33-35)。除非冒犯的代價被償還，我們不想要原諒。藉由將把罪放在完美的救主身上，上帝處理了人們的過犯。這救主代替了在歷史上的每個時刻的罪人受了審判。如果我們要求別人做一些事情來得到我們的原諒，那我們就不像基督了。耶穌為每個人的罪而死，並且當我們還是罪人的時候他就把原諒延伸到我們身上，因此，我們應該像耶穌一樣。\n\n經節中耶穌譬喻的要旨在於，當有人得罪我們時。我們應該記著上帝給予我們的極大的憐憫，並且以寬容的態度回應他。別人欠我們的任何債與我們被上帝所赦免的比較起來，都顯得微不足道。我們應該對別人有著如同基督對我們一樣的憐憫。\n\n如果上帝期待我們原諒一天冒犯我們490次的弟兄(事實上在猶太文化中代表一個無窮次的數字)，那麼肯定地，愛我們的上帝對我們的態度也不會比這更少。\n\n我們從上帝得著的原諒和任何我們被要求對別人的原諒比較起來是無限更多的。"
