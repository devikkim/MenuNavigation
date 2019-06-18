# MenuNavigation
This repository is simplest menu navigation. 

Just add ```Menu``` model at UINavigationController using ```setMenu```

```swift
// Menu Model
struct Menu {
  let titleName: String
  let didSelect: () -> ()
}


// Extension of UINavigationController
extension UINavigationController {
  func setMenu(menu: [Menu], configuration: MenuConfiguration? = nil)
}

```

* demo.gif

<img alt="Demo" src="/resources/demo.gif?raw=true" width="290">&nbsp;

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
  
  ///  NavigationBar right image
  var rightImage = UIImage(named: "down")
  
  ///  Use Selected Menu's Title as NavigationBar's Title
  var isUseSelectedMenuTitle = false
}

```
## Author

devikkim@gmail.com
