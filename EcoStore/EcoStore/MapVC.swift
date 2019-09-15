//
//  MapVC.swift
//  EcoStore
//
//  Created by Stephanie Gu on 2019-09-14.
//  Copyright © 2019 Stephanie Gu. All rights reserved.
//

import UIKit

class MapVC : CommonViewController {
    
    //MARK:- Variables
    private let scrollView = UIScrollView()
    
    private let roadView = UIImageView()
    private let roadImage = UIImage(named:"path1")
    
    private let animals = DMM.animals
    private let restored: [Int]? = AnimalManager.shared.restoredAnimalData
    
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.fromRGB(87, 199, 125)
        
        view.addSubview(scrollView)
        
        roadView.image = roadImage
        scrollView.addSubview(roadView)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var leftAlign = true
        var y: CGFloat = 100
        var totalContentSize = y
        
        for (index, animal) in animals.enumerated() {
            let imageUrl = animal["imgUrl"] as? String
            let button = UIButton(type: .custom)
            button.tag = index
            button.setImage(UIImage(named: imageUrl ?? "turtle-icon"), for: .normal)
            button.addTarget(self, action: #selector(openAnimalModal), for: .touchUpInside)
            button.frame = CGRect(x: 0, y: y, width: 100, height: 100)
            if leftAlign {
                button.center.x = view.frame.width / 4
            } else {
                button.center.x = view.frame.width * (3 / 4)
            }
            leftAlign = !leftAlign
            if let restored = restored?.contains(index), !restored {
                button.alpha = 0.5
            }
            scrollView.addSubview(button)
            y += (button.frame.height + 100)
            totalContentSize += (button.frame.height + 100)
        }
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: totalContentSize)
        scrollView.frame = view.frame
        
        roadView.frame = CGRect(x: 0, y: -20, width: 200, height: totalContentSize + 80)
        roadView.center.x = view.center.x
        
    }
    
    // MARK:- Control Action
    @objc func openAnimalModal(sender: UIButton!) {
        let modalVC = AnimalModalVC(animal: animals[sender.tag])
        modalVC.modalTransitionStyle = .crossDissolve
        modalVC.modalPresentationStyle = .overFullScreen
        self.present(modalVC, animated: true, completion: nil)
    }
}
