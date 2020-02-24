//
//  MenuTitleView.swift
//  TestNavigation
//
//  Created by InKwon Devik Kim on 14/06/2019.
//  Copyright © 2019 InKwon Devik Kim. All rights reserved.
//

import UIKit

public struct MenuConfiguration {
  
  /// NavigationBar's Title
  public var title: String?
  
  /// NavigationBar's Title Font
  public var titleFont = UIFont(name: "HelveticaNeue-Medium", size: 17)
  
  /// NavigationBar's Title Color
  public var titleTextColor = UIColor.black
  
  /// NavigationBar's Tint Color
  public var navigationTintColor = UIColor.black
  
  /// NavigationBar's Bar Tint Color
  public var navigationBarTintColor = UIColor.white
  
  /// NavigationBar's isTranslucent
  public var navigationIsTranslucent = true
  
  ///  MenuView's Background Color
  public var menuViewBackgroundColor = UIColor.white
  
  /// MenuView's Cell Background Color
  public var menuViewCellBackgroundColor = UIColor.white
  
  /// MenuView's Cell Text Font
  public var menuViewCellFont = UIFont(name: "HelveticaNeue-Medium", size: 15)
  
  /// MenuView's Cell Text Color
  public var menuViewCellTextColor = UIColor.black
  
  /// MenuView's Cell Height
  public var menuViewCellHeight: CGFloat = 50
  
  ///  Use Selected Menu's Title as NavigationBar's Title
  public var isUseSelectedMenuTitle = false
  
  public init(){}
}

@available(iOS 10.0, *)
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
        
        titleImageView.tintColor = configuration.titleTextColor
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
    let frameworkBundle = Bundle(for: MenuTitleView.self)
    guard let bundleURL = frameworkBundle.resourceURL?.appendingPathComponent("MenuNavigation.bundle") else {
        return nil
    }
    let resourceBundle = Bundle(url: bundleURL)
    let image = UIImage(named: "down", in: resourceBundle, compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
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
@available(iOS 10.0, *)
extension MenuTitleView: MenuContainerViewDelegate {
  func menuView(_ menuView: MenuContainerView, didSelectMenu menu: Menu) {
    if configuration?.isUseSelectedMenuTitle ?? false {
      titleLabel.text = menu.titleName
    }
    
    hide(duration: 0.0)
  }
}

// MARK: - Other Methods
@available(iOS 10.0, *)
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
        self.titleImageView.tintColor = self.configuration?.titleTextColor ?? .red
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
        self.titleImageView.tintColor = self.configuration?.titleTextColor ?? .black
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
