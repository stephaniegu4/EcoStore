//
//  TabBarController.swift
//  EcoStore
//
//  Created by Stephanie Gu on 2019-09-14.
//  Copyright © 2019 Stephanie Gu. All rights reserved.
//

import UIKit

class TabBarController : UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.backgroundColor = .white
        
        let mapVC = MapVC()
        mapVC.tabBarItem = UITabBarItem(title: "World", image: UIImage(named:"tab-bar-earth")?.withRenderingMode(.alwaysOriginal), tag: 0)
        mapVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red:0.11, green:0.28, blue:0.43, alpha:1.0)], for: .selected)
        
        let animalsVC = AnimalsVC()
        animalsVC.tabBarItem = UITabBarItem(title: "Animals", image: UIImage(named:"tab-bar-animal")?.withRenderingMode(.alwaysOriginal), tag: 0)
        animalsVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red:0.11, green:0.28, blue:0.43, alpha:1.0)], for: .selected)
        
        let cameraVC = RecyclePageVC()
        cameraVC.tabBarItem = UITabBarItem(title: "Recycle", image: UIImage(named:"tab-bar-camera")?.withRenderingMode(.alwaysOriginal), tag: 0)
        cameraVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red:0.11, green:0.28, blue:0.43, alpha:1.0)], for: .selected)
        
        let userVC = UserVC()
        userVC.tabBarItem = UITabBarItem(title: "Me", image: UIImage(named:"tab-bar-user")?.withRenderingMode(.alwaysOriginal), tag: 0)
        userVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red:0.11, green:0.28, blue:0.43, alpha:1.0)], for: .selected)
        
        self.viewControllers = [mapVC, animalsVC, cameraVC, userVC]
    }
}
