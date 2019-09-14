//
//  SplashScreenVC.swift
//  EcoStore
//
//  Created by Stephanie Gu on 2019-09-14.
//  Copyright © 2019 Stephanie Gu. All rights reserved.
//

import UIKit

class SplashScreenVC: CommonViewController {
    
    // MARK:- Variables
    private var logoView = UIView()
    private var logoImage = UIImage(named: "app-logo")
    private var logoImageView = UIImageView()
    private var logoLabel = UILabel()
    
    private var descriptionLabel = UILabel()
    
    // MARK:- Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.fromRGB(71, 174, 163)
        
        view.addSubview(logoView)
        
        logoLabel.text = "ECOSTORE"
        logoLabel.font = UIFont(name: "AvenirNext-Heavy", size: 45)
        logoLabel.textColor = .black
        logoLabel.textAlignment = .center
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        logoView.addSubview(logoLabel)
        
        descriptionLabel.text = "ReSTORE the ECOsystem"
        descriptionLabel.font = UIFont(name: "AvenirNext-UltraLight", size: 20)
        descriptionLabel.textAlignment = .center
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        logoView.addSubview(descriptionLabel)
        
        logoImageView.image = logoImage
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoView.addSubview(logoImageView)
        
        // Constraints
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            logoImageView.widthAnchor.constraint(equalToConstant: 250),
            logoImageView.heightAnchor.constraint(equalToConstant: 250),
            
            logoLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            logoLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100),
            logoLabel.centerXAnchor.constraint(equalTo: logoImageView.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 10),
            descriptionLabel.widthAnchor.constraint(equalTo: logoLabel.widthAnchor),
            descriptionLabel.centerXAnchor.constraint(equalTo: logoImageView.centerXAnchor)
        ])
        
        // Synchronize load of splash screen to login page
        let splashScreenTime = 3.0 // 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + splashScreenTime){
            let loginPage = LoginVC()
            loginPage.modalTransitionStyle = .crossDissolve
            loginPage.modalPresentationStyle = .fullScreen
            self.present(loginPage, animated: true, completion: nil)
        }
    }
    
}
