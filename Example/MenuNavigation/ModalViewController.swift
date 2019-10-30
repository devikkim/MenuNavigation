//
//  ModalViewController.swift
//  MenuNavigation_Example
//
//  Created by InKwon James Kim on 2019/10/30.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import MenuNavigation

class ModalViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let menu1 = Menu(titleName: "Menu 1") {}
    let menu2 = Menu(titleName: "Menu 2") {}
    
    let configuration: MenuConfiguration = {
      var configure = MenuConfiguration()
      
      configure.title = "Modal Custom Menu"
      configure.titleTextColor = .red
      
      configure.navigationTintColor = .brown
      configure.navigationBarTintColor = .white
      configure.navigationIsTranslucent = false
      
      configure.menuViewBackgroundColor = .red
      configure.menuViewCellBackgroundColor = .red
      configure.menuViewCellTextColor = .white
      return configure
    } ()
    
    navigationController?.setMenu(menu: [menu1, menu2], configuration: configuration)
  }
  
  @IBAction func touchClose(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true, completion: nil)
  }
}
