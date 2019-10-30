//
//  Menu.swift
//  AddMenu
//
//  Created by InKwon Devik Kim on 18/06/2019.
//  Copyright © 2019 InKwon Devik Kim. All rights reserved.
//

public struct Menu {
  let titleName: String
  let didSelect: (() -> Void)?
  
  public init(titleName: String, didSelect: (() -> Void)? = nil) {
    self.titleName = titleName
    self.didSelect = didSelect
  }
}
