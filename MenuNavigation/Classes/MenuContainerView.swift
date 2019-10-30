//
//  TableView.swift
//  TestNavigation
//
//  Created by InKwon Devik Kim on 12/06/2019.
//  Copyright © 2019 InKwon Devik Kim. All rights reserved.
//

import UIKit

protocol MenuContainerViewDelegate {
  func menuView(_ menuView: MenuContainerView, didSelectMenu menu: Menu)
}

class MenuContainerView: UIView {
  var tableView: UITableView = {
    let tableView = UITableView()
    
    tableView.separatorStyle = .none
    tableView.backgroundColor = .white
    
    return tableView
  }()
  
  var isSelected = false
  
  var delegate: MenuContainerViewDelegate?
  
  var isTranslucent = true {
    didSet {
      update()
    }
  }
  
  var cellHeight: CGFloat = 50.0 {
    didSet{
      tableView.reloadData()
    }
  }
  
  var cellBackgroundColor = UIColor.white {
    didSet {
      tableView.reloadData()
    }
  }
  
  var cellFont = UIFont(name: "HelveticaNeue-Medium", size: 17) {
    didSet{
      tableView.reloadData()
    }
  }
  
  var cellTextColor = UIColor.black {
    didSet{
      tableView.reloadData()
    }
  }
  
  var menu = [Menu]() {
    didSet {
      tableView.reloadData()
      update()
    }
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  override init(frame: CGRect) {
    let customFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    super.init(frame: customFrame)
    commonInit()
  }
  
  private func commonInit(){
    tableView.frame = frame
    tableView.delegate = self
    tableView.dataSource = self
    
    addSubview(tableView)
    
    backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.4)
    
  }

  override open func layoutSubviews() {
    frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    
    update()
    
    super.layoutSubviews()
  }
  
  private func update() {
    let y: CGFloat
    
    switch UIDevice.current.orientation {
    case .landscapeLeft, .landscapeRight:
      y = 32 + UIApplication.shared.statusBarFrame.height
    default:
      y = 44 + UIApplication.shared.statusBarFrame.height
    }
    
    if isSelected {
      tableView.frame = CGRect(
        x: 0,
        y: isTranslucent ? y : 0,
        width: UIScreen.main.bounds.width,
        height: cellHeight * CGFloat(menu.count)
      )
    }
  }
}

// MARK: - UITableViewDelegate
extension MenuContainerView: UITableViewDelegate {
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    menu[indexPath.row].didSelect?()
    delegate?.menuView(self, didSelectMenu: menu[indexPath.row])
  }
}

// MARK: - UITableViewDataSource
extension MenuContainerView: UITableViewDataSource {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return menu.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    
    cell.textLabel?.text = menu[indexPath.row].titleName
    cell.textLabel?.textAlignment = .center
    
    cell.selectionStyle = .none
    cell.backgroundColor = cellBackgroundColor
    
    cell.textLabel?.font = cellFont
    cell.textLabel?.textColor = cellTextColor
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return cellHeight
  }
}
