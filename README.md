# PLStrechyViewController

[![CI Status](http://img.shields.io/travis/ctwdtw/PLStrechyViewController.svg?style=flat)](https://travis-ci.org/ctwdtw/PLStrechyViewController)
[![Version](https://img.shields.io/cocoapods/v/PLStrechyViewController.svg?style=flat)](http://cocoapods.org/pods/PLStrechyViewController)
[![License](https://img.shields.io/cocoapods/l/PLStrechyViewController.svg?style=flat)](http://cocoapods.org/pods/PLStrechyViewController)
[![Platform](https://img.shields.io/cocoapods/p/PLStrechyViewController.svg?style=flat)](http://cocoapods.org/pods/PLStrechyViewController)

## Description
PLStrechyVieController is A simple view controller which contains a strechy UIView and a UITextField. The strechy effect is a autolayout based animation and it support both portrait and landscape orientation.

## Demo

![Alt text](/Example/PLStrechyVC.gif?raw=true "PLStrechyVC Demo")

## Usage

Just subclass the widget and assign the text and image in the `viewDidLoad` method:
```Swift
class MYViewController: PLStrechyViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let image = UIImage(named: "your awesome image")
    self.feedImage = image
    self.feedText = "your awesome text"
    
    //if you use your view controller inside a navigation controller, 
    //you may want to assign the title of navigation item also
    self.navigationItem.title = "your awesome navigation item title"
  }
}
``` 
then assign your ViewController's `Class` field in Storyboard as `MYViewController`, that's it.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* Swift 3.0 +
* iOS 9.0 +

## Installation

PLStrechyViewController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PLStrechyViewController'
```

## Author

ctwdtw, ctwdtw@gmail.com

## License

PLStrechyViewController is available under the MIT license. See the LICENSE file for more info.
