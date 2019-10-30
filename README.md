# MenuNavigation
[![CI Status](https://img.shields.io/travis/devikkim@gmail.com/MenuNavigation.svg?style=flat)](https://travis-ci.org/devikkim@gmail.com/MenuNavigation)
[![Version](https://img.shields.io/cocoapods/v/MenuNavigation.svg?style=flat)](https://cocoapods.org/pods/MenuNavigation)
[![License](https://img.shields.io/cocoapods/l/MenuNavigation.svg?style=flat)](https://cocoapods.org/pods/MenuNavigation)
[![Platform](https://img.shields.io/cocoapods/p/MenuNavigation.svg?style=flat)](https://cocoapods.org/pods/MenuNavigation)


This repository is simplest menu navigation. 

(가장 간단히 사용할 수 있는 메뉴 네비게이션 컨트롤러 입니다.)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Just add ```Menu``` model at UINavigationController using ```setMenu```

(단지 ```Menu``` 모델을 UINavigationController의 ```setMenu```를 사용하여 추가하세요.)

```swift
// Menu Model
struct Menu {
  let titleName: String
  let didSelect: (() -> Void)?
}


// Extension of UINavigationController
extension UINavigationController {
  func setMenu(menu: [Menu], configuration: MenuConfiguration? = nil)
}

```

* demo.gif

<img alt="Demo" src="/resources/demo.gif?raw=true" width="290">&nbsp;


## Requirements

MenuNavigation requires iOS 10+ and is compatible with Swift 4.2 projects.

## Installation

MenuNavigation is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MenuNavigation'
```

* sample code

```swift
  private func setMenuInNavigationController() {
    let apple = Menu(titleName: "Apple") { [weak self] in
      guard let `self` = self else {
        return
      }
      self.selectedTitleLabel.text = "Apple"
      self.selectedImageView.image = UIImage(named: "apple")
    }
    
    let banana = Menu(titleName: "Banana") { [weak self] in
      guard let `self` = self else {
        return
      }
      self.selectedTitleLabel.text = "Banana"
      self.selectedImageView.image = UIImage(named: "banana")
    }
    
    let cantaloupe = Menu(titleName: "Cantaloupe") { [weak self] in
      guard let `self` = self else {
        return
      }
      self.selectedTitleLabel.text = "Cantaloupe"
      self.selectedImageView.image = UIImage(named: "cantaloupe")
    }
    
    let durian = Menu(titleName: "Durian") { [weak self] in
      guard let `self` = self else {
        return
      }
      self.selectedTitleLabel.text = "Durian"
      self.selectedImageView.image = UIImage(named: "durian")
    }
    
    let elderberries = Menu(titleName: "Elderberries") { [weak self] in
      guard let `self` = self else {
        return
      }
      self.selectedTitleLabel.text = "Elderberries"
      self.selectedImageView.image = UIImage(named: "elderberries")
    }
    
    
    let configuration: MenuConfiguration = {
      var configure = MenuConfiguration()
      
      configure.title = "Select Fruits"
      configure.isUseSelectedMenuTitle = true
      return configure
    } ()
  
    navigationController?.setMenu(
      menu: [
        apple, banana, cantaloupe, durian, elderberries
      ],
      configuration: configuration
    )
  }
```

* you can edit using ```MenuConfiguration```

(```MenuConfiguration``` 을 사용하여 편집 할 수 있습니다.)

```swift
struct MenuConfiguration {
  
  /// NavigationBar's Title
  var title: String?
  
  /// NavigationBar's Title Font
  var titleFont = UIFont(name: "HelveticaNeue-Medium", size: 17)
  
  /// NavigationBar's Title Color
  var titleTextColor = UIColor.black
  
  /// NavigationBar's Tint Color
  var navigationTintColor = UIColor.black
  
  /// NavigationBar's Bar Tint Color
  var navigationBarTintColor = UIColor.white
  
  /// NavigationBar's isTranslucent
  var navigationIsTranslucent = true
  
  ///  MenuView's Background Color
  var menuViewBackgroundColor = UIColor.white
  
  /// MenuView's Cell Background Color
  var menuViewCellBackgroundColor = UIColor.white
  
  /// MenuView's Cell Text Font
  var menuViewCellFont = UIFont(name: "HelveticaNeue-Medium", size: 15)
  
  /// MenuView's Cell Text Color
  var menuViewCellTextColor = UIColor.black
  
  /// MenuView's Cell Height
  var menuViewCellHeight: CGFloat = 50
  
  ///  Use Selected Menu's Title as NavigationBar's Title
  var isUseSelectedMenuTitle = false
}

```

## Author

devikkim@gmail.com

## License

MenuNavigation is available under the MIT license. See the LICENSE file for more info.

