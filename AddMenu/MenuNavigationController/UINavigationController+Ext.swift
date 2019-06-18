//
//  UINavigationController+Ext.swift
//  TestNavigation
//
//  Created by InKwon Devik Kim on 13/06/2019.
//  Copyright © 2019 InKwon Devik Kim. All rights reserved.
//

import UIKit

extension UINavigationController {
  func setMenu(menu: [Menu], configuration: MenuConfiguration? = nil) {
    
    let menuTitleView = MenuTitleView(target: self, menu: menu, configuration: configuration)
    
    let childVC = viewControllers.first
    childVC?.navigationItem.titleView = menuTitleView
  }
}
