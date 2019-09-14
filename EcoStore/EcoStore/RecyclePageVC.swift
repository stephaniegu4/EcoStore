//
//  RecyclePageVC.swift
//  EcoStore
//
//  Created by Stephanie Gu on 2019-09-14.
//  Copyright © 2019 Stephanie Gu. All rights reserved.
//

import UIKit

class RecyclePageVC: CommonViewController {
    
    // MARK:- Variables
    private var topView = UIView()
    
    private var recycleView = UIImageView()
    private var recycleIcon = UIImage(named:"recycle-icon")
    
    private var descriptionText = UILabel()
    
    private var cameraButton = UIButton(type: .custom)
    private var cameraIcon = UIImage(named:"camera2-icon")
    
    private var semiCircleView = UIView()
    
    private var bottomView = UIView()
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(topView)
        
        recycleView.image = recycleIcon
        topView.addSubview(recycleView)
        
        descriptionText.text = "Take a picture of your recyclable item!"
        descriptionText.font = UIFont(name: "AvenirNext-Bold", size: 20)
        descriptionText.textAlignment = .left
        descriptionText.textColor = .darkGray
        descriptionText.numberOfLines = 0
        descriptionText.lineBreakMode = .byWordWrapping
        topView.addSubview(descriptionText)
        
        semiCircleView.backgroundColor = UIColor.fromRGB(88, 185, 121)
        view.addSubview(semiCircleView)
        
        bottomView.backgroundColor = UIColor.fromRGB(88, 185, 121)
        view.addSubview(bottomView)
        
        cameraButton.setImage(cameraIcon, for: .normal)
        cameraButton.addTarget(self, action: #selector(cameraAction), for: .touchUpInside)
        view.addSubview(cameraButton)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        recycleView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        descriptionText.frame = CGRect(x: recycleView.frame.maxX + 10, y: 0, width: view.frame.width - recycleView.frame.maxX - 80, height: recycleView.frame.height)
        descriptionText.center.y = recycleView.center.y
        
        topView.frame = CGRect(x: 0, y: 150, width: recycleView.frame.width + descriptionText.frame.width + 10, height: recycleView.frame.height)
        topView.center.x = view.center.x
        
        semiCircleView.frame = CGRect(x: 0, y: view.frame.height / 2 - 50, width: view.frame.width + 50, height: 300)
        semiCircleView.layer.cornerRadius = semiCircleView.frame.width / 2
        semiCircleView.center.x = view.center.x
        
        bottomView.frame = CGRect(x: 0, y: semiCircleView.center.y, width: view.frame.width, height: view.frame.height - semiCircleView.center.y)
        
        cameraButton.frame = CGRect(x: 0, y: semiCircleView.frame.minY + 100, width: 225, height: 225)
        cameraButton.center.x = view.center.x
    }
    
    // MARK:- Control Actions
    @objc func cameraAction() {
       
    }
}

