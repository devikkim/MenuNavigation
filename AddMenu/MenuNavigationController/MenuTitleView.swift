//
//  MenuTitleView.swift
//  TestNavigation
//
//  Created by InKwon Devik Kim on 14/06/2019.
//  Copyright © 2019 InKwon Devik Kim. All rights reserved.
//

import UIKit

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

class MenuTitleView: UIStackView {
  
  // MARK: - Properties
  
  private var configuration: MenuConfiguration? {
    didSet {
      guard let configuration = configuration else {
        return
      }
      
      titleLabel.text = configuration.title
      titleLabel.textColor = configuration.titleTextColor
      titleLabel.font = configuration.titleFont
      
      childViewController?.navigationController?.navigationBar.barTintColor = configuration.navigationBarTintColor
      childViewController?.navigationController?.navigationBar.tintColor = configuration.navigationTintColor
      childViewController?.navigationController?.navigationBar.isTranslucent = configuration.navigationIsTranslucent
      
      menuContainerView.isTranslucent = configuration.navigationIsTranslucent
      menuContainerView.tableView.backgroundColor = configuration.menuViewBackgroundColor
      
      menuContainerView.cellBackgroundColor = configuration.menuViewCellBackgroundColor
      menuContainerView.cellFont = configuration.menuViewCellFont
      menuContainerView.cellTextColor = configuration.menuViewCellTextColor
      menuContainerView.cellHeight = configuration.menuViewCellHeight
      
      titleImageView.image = configuration.rightImage
    }
  }
  
  private var target: UINavigationController? {
    didSet {
      childViewController = target?.viewControllers.first
    }
  }
  
  private var childViewController: UIViewController? {
    didSet {
      titleLabel.text = childViewController?.title
      titleLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
    }
  }
  
  // MARK: - UI Components
  
  /// Menu Container View
  private lazy var menuContainerView = MenuContainerView()
  
  /// NavigationBar's Title Label
  private lazy var titleLabel = UILabel()
  
  /// NavigationBar's Title Image ( Right)
  private lazy var titleImage: UIImage? = {
    let image = UIImage(named: "down")
    return image
  }()
  
  /// NavigationBar's Title ImageView ( Right )
  private lazy var titleImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
    imageView.widthAnchor.constraint(equalToConstant: 22).isActive = true
    return imageView
  }()
  
  /// NavigationBar's Title Blacnk View ( Left )
  private lazy var blankView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.heightAnchor.constraint(equalToConstant: 32).isActive = true
    view.widthAnchor.constraint(equalToConstant: 22).isActive = true
    return view
  }()
  
  // MARK: - Initialize
  
  required init(coder: NSCoder) {
    super.init(coder: coder)
    let menu = [Menu]()
    internalInit(nil, menu)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    let menu = [Menu]()
    internalInit(nil, menu)
  }
  
  required init(
    target: UINavigationController,
    menu: [Menu],
    configuration: MenuConfiguration? = nil
  ) {
    super.init(frame: CGRect())
    internalInit(target, menu, configuration)
  }
  
  private func internalInit(
    _ target: UINavigationController? = nil,
    _ menu: [Menu],
    _ configuration: MenuConfiguration? = nil
  ){
    self.target = target
    menuContainerView.menu = menu
    
    menuContainerView.delegate = self
    titleImageView.image = titleImage
    
    axis = .horizontal
    
    addArrangedSubview(blankView)
    addArrangedSubview(titleLabel)
    addArrangedSubview(titleImageView)
    
    let recognizer = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
    isUserInteractionEnabled = true
    addGestureRecognizer(recognizer)
    
    guard let configuration = configuration else {
      return
    }
    
    self.configuration = configuration
  }
}

// MARK: - MenuContainerViewDelegate
extension MenuTitleView: MenuContainerViewDelegate {
  func menuView(_ menuView: MenuContainerView, didSelectMenu menu: Menu) {
    if configuration?.isUseSelectedMenuTitle ?? false {
      titleLabel.text = menu.titleName
    }
    
    hide(duration: 0.0)
  }
}

// MARK: - Other Methods
extension MenuTitleView {
  private func show(duration: Double) {
    menuContainerView.isSelected = true
    
    childViewController?.view.addSubview(menuContainerView)
    menuContainerView.tableView.transform = CGAffineTransform(
      translationX: 0,
      y: -menuContainerView.tableView.frame.height
    )
    
    let animator = UIViewPropertyAnimator(
      duration: duration,
      curve: .easeInOut
    ){
      let transform = CGAffineTransform(translationX: 0, y: 0)
      self.menuContainerView.tableView.transform = transform
      self.titleImageView.transform = CGAffineTransform(rotationAngle: .pi)
      self.titleImageView.tintColor = .red
    }
    
    animator.startAnimation()
  }
  
  private func hide(duration: Double) {
    menuContainerView.isSelected = false
    
    let animator = UIViewPropertyAnimator(
      duration: duration,
      curve: .easeInOut
    ){
      let transform = CGAffineTransform(
        translationX: 0,
        y: -self.menuContainerView.tableView.frame.height
      )
      
      self.menuContainerView.tableView.transform = transform
      self.titleImageView.transform = CGAffineTransform(rotationAngle: (.pi) * 2 )
      self.titleImageView.tintColor = .black
    }
    animator.addCompletion { _ in
      self.menuContainerView.removeFromSuperview()
    }
    
    animator.startAnimation()
  }
  
  @objc private func tap(_ sender: UITapGestureRecognizer) {
    menuContainerView.isSelected ? hide(duration: 0.3) : show(duration: 0.3)
  }
}
