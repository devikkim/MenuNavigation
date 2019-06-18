# MenuNavigation
This repository is simplest menu navigation.

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


## Author

devikkim@gmail.com
