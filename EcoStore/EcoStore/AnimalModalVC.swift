//
//  AnimalModalVC.swift
//  EcoStore
//
//  Created by Stephanie Gu on 2019-09-14.
//  Copyright © 2019 Stephanie Gu. All rights reserved.
//

import UIKit

class AnimalModalVC: CommonViewController {
    
    //MARK:- Variables
    private var animal: [String:Any]
    private let modalView = UIView()
    
    private let cancelIcon = UIImage(named:"cancel-icon")
    private let cancelButton = UIButton(type: .custom)
    
    private let nameLabel = UILabel()
    private var animalIcon: UIImage? = nil
    private let animalView = UIImageView()
    private let descriptionLabel = UILabel()
    
    let pointsView = UIView()
    private let lockPic = UIImage(named: "lock-icon")
    private let lockSymbol = UIImageView()
    private let pointsReqLabel = UILabel()

    //MARK:- Initializer
    init(animal: [String:Any]) {
        self.animal = animal
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        modalView.backgroundColor = .white
        
        cancelButton.setImage(cancelIcon, for: .normal)
        cancelButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        modalView.addSubview(cancelButton)
        
        nameLabel.text = animal["name"] as? String ?? "entity"
        nameLabel.font = UIFont(name: "AvenirNext-Bold", size: 35)
        nameLabel.textAlignment = .center
        modalView.addSubview(nameLabel)
        
        animalIcon = UIImage(named: animal["imgUrl"] as? String ?? "app-logo")
        animalView.image = animalIcon
        modalView.addSubview(animalView)
        
        modalView.addSubview(pointsView)
        
        lockSymbol.image = lockPic
        pointsView.addSubview(lockSymbol)
        
        pointsReqLabel.text = "\(animal["cost"] as? Int ?? 0)"
        pointsReqLabel.textAlignment = .center
        pointsReqLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 30)
        pointsView.addSubview(pointsReqLabel)
        
        //descriptionLabel.text = animal["description"] as? String ?? "sample text"
        descriptionLabel.text = "Lorem dorem ipsum some latin text for placeholder text description loL!"
        descriptionLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.textAlignment = .center
        modalView.addSubview(descriptionLabel)
        
        view.addSubview(modalView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        modalView.frame = CGRect(x: 0, y: 0, width: view.frame.width * (4 / 5), height: view.frame.height * (3 / 5))
        modalView.center = view.center
        modalView.layer.cornerRadius = 20
        
        cancelButton.frame = CGRect(x: modalView.frame.width - 40, y: 10, width: 30, height: 30)
        
        nameLabel.frame = CGRect(x: 0, y: 50, width: modalView.frame.width - 40, height: 40)
        nameLabel.frame.origin.x = modalView.frame.width / 2 - nameLabel.frame.width / 2
        
        animalView.frame = CGRect(x: 0, y: nameLabel.frame.maxY + 50, width: modalView.frame.width / 2, height: modalView.frame.width / 2)
        animalView.frame.origin.x = modalView.frame.width / 2 - animalView.frame.width / 2
        
        lockSymbol.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        pointsReqLabel.frame = CGRect(x: lockSymbol.frame.width + 5, y: 0, width: modalView.frame.width - 100, height: 40)
        pointsReqLabel.frame.size = pointsReqLabel.intrinsicContentSize
        
        pointsView.frame = CGRect(x: 0, y: animalView.frame.maxY + 40, width: lockSymbol.frame.width + pointsReqLabel.frame.width, height: pointsReqLabel.frame.height + 20)
        pointsView.frame.origin.x = modalView.frame.width / 2 - pointsView.frame.width / 2
        
        descriptionLabel.frame.size.width = modalView.frame.width - 40
        descriptionLabel.sizeToFit()
        descriptionLabel.frame.origin = CGPoint(x: modalView.frame.width / 2 - descriptionLabel.frame.width / 2, y: pointsView.frame.maxY + 10)
        
    }
    
    //MARK:- Control Actions
    @objc func dismissAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
