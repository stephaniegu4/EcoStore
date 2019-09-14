//
//  LoginVC.swift
//  EcoStore
//
//  Created by Stephanie Gu on 2019-09-14.
//  Copyright © 2019 Stephanie Gu. All rights reserved.
//

import UIKit

class LoginVC : CommonViewController {
    
    //MARK:- Variables
    private var appLogoView = UIImageView()
    private var appLogo = UIImage(named: "app-logo")
    private var appTitle = UILabel()
    
    private var userField = UITextField()
    private var passwordField = UITextField()
    
    private var loginButton = UIButton()
    
    //MARK:- Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.fromRGB(71, 174, 163)
        
        appLogoView.image = appLogo
        view.addSubview(appLogoView)
        
        appTitle.text = "ECOSTORE"
        appTitle.textColor = .white
        appTitle.font = UIFont(name: "AvenirNext-Heavy", size: 40)
        appTitle.textAlignment = .center
        view.addSubview(appTitle)
        
        userField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        userField.borderStyle = .roundedRect
        userField.autocapitalizationType = .none
        userField.autocorrectionType = .no
        view.addSubview(userField)
        
        passwordField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        passwordField.borderStyle = .roundedRect
        passwordField.isSecureTextEntry = true
        view.addSubview(passwordField)
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = UIColor.fromRGB(10, 83, 139)
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        view.addSubview(loginButton)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        appLogoView.frame.size = CGSize(width: 150, height: 150)
        appLogoView.center.x = view.center.x
        appLogoView.center.y = view.center.y - appLogoView.frame.size.height - 50
        
        appTitle.frame = CGRect(x: 0, y: appLogoView.frame.maxY + 10, width: view.frame.width, height: 100)
        appTitle.frame.size.height = appTitle.intrinsicContentSize.height
        
        userField.frame = CGRect(x: 0, y: appTitle.frame.maxY + 30, width: view.frame.width * 0.75, height: 50)
        userField.center.x = view.center.x
        
        passwordField.frame = CGRect(x: 0, y: userField.frame.maxY + 20, width: view.frame.width * 0.75, height: 50)
        passwordField.center.x = view.center.x
        
        loginButton.frame = CGRect(x: 0, y: passwordField.frame.maxY + 50, width: 200, height: 40)
        loginButton.center.x = view.center.x
        loginButton.layer.cornerRadius = loginButton.frame.width / 10
        
    }
    
    //MARK:- Control Actions
    @objc func loginAction() {
        
    }
}
