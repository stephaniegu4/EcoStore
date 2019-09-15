//
//  UserVC.swift
//  EcoStore
//
//  Created by Stephanie Gu on 2019-09-14.
//  Copyright © 2019 Stephanie Gu. All rights reserved.
//

import UIKit

class UserVC: CommonViewController {
    
    // MARK:- Variables
    private let topView = UIView()
    
    //private let profileImg: UIImage? = nil
    private let profileImg = UIImage(named: "user-icon")
    private let profileImgView = UIImageView()
    
    private let nameLabel = UILabel()
    private let emailLabel = UILabel()
    
    private let pointsView = UIView()
    private let pointsIcon = UIImage(named: "recycle-points-icon")
    private let pointsIconView = UIImageView()
    private let pointsLabel = UILabel()
    
    private let restoredView = UIView()
    private let restoredLabel = UILabel()
    private let restoredIcon = UIImage(named: "restored-animals-icon")
    private let restoredIconView = UIImageView()
    
    private let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
    private let actions = ["Change Password", "Logout"]
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        topView.backgroundColor = UIColor.fromRGB(71, 174, 163)
        view.addSubview(topView)
        
        profileImgView.image = profileImg
        topView.addSubview(profileImgView)
        
        nameLabel.text = "Temp Name"
        nameLabel.font = UIFont(name: "AvenirNext-Bold", size: 30)
        nameLabel.textAlignment = .center
        topView.addSubview(nameLabel)
        
        emailLabel.text = "stephaniegu7h@gmail.com"
        emailLabel.font = UIFont(name: "AvenirNext-UltraLightItalic", size: 18)
        emailLabel.textAlignment = .center
        topView.addSubview(emailLabel)
        
        pointsIconView.image = pointsIcon
        pointsView.addSubview(pointsIconView)
        
        pointsLabel.text = "35"
        pointsLabel.textAlignment = .center
        pointsLabel.font = UIFont(name: "AvenirNext-Regular", size: 25)
        pointsView.addSubview(pointsLabel)
        
        topView.addSubview(pointsView)
        
        restoredIconView.image = restoredIcon
        restoredView.addSubview(restoredIconView)
        
        restoredLabel.text = "3 animals restored!"
        restoredLabel.font = UIFont(name: "AvenirNext-Regular", size: 25)
        restoredLabel.textAlignment = .center
        restoredView.addSubview(restoredLabel)
        
        topView.addSubview(restoredView)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        topView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.7)
        
        profileImgView.frame = CGRect(x: 0, y: 150, width: 250, height: 250)
        profileImgView.center.x = view.center.x
        
        nameLabel.sizeToFit()
        nameLabel.frame.origin = CGPoint(x: 0, y: profileImgView.frame.maxY + 40)
        nameLabel.center.x = view.center.x
        
        emailLabel.sizeToFit()
        emailLabel.frame.origin = CGPoint(x: 0, y: nameLabel.frame.maxY + 5)
        emailLabel.center.x = view.center.x
        
        pointsIconView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        
        pointsLabel.sizeToFit()
        pointsLabel.frame.origin = CGPoint(x: pointsIconView.frame.maxX + 5, y: 0)
        
        pointsView.frame = CGRect(x: 0, y: emailLabel.frame.maxY + 15, width: pointsIconView.frame.width + pointsLabel.frame.width + 5, height: max(pointsLabel.frame.height, pointsIconView.frame.height))
        pointsView.center.x = view.center.x
        
        pointsIconView.center.y = pointsLabel.center.y
        
        restoredIconView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        
        restoredLabel.sizeToFit()
        restoredLabel.frame.origin = CGPoint(x: restoredIconView.frame.maxX + 10, y: 0)
        
        restoredView.frame = CGRect(x: 0, y: pointsView.frame.maxY, width: restoredIconView.frame.width + restoredLabel.frame.width + 10, height: max(restoredLabel.frame.height, restoredIconView.frame.height))
        restoredView.center.x = view.center.x
        
        restoredIconView.center.y = restoredLabel.center.y
        
    }
}
