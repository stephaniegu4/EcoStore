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
    
    private let imageView = UIImageView()
    
//    private let tempBlob = UIImageView()
//    private let blobImage = UIImage(named:"water")
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.fromRGB(87, 199, 125)
        
        view.addSubview(scrollView)
        
        roadView.image = roadImage
        scrollView.addSubview(roadView)
        
        let imageUrl = animals[0]["imgUrl"] as? String
        imageView.image = UIImage(named: imageUrl ?? "turtle-icon")
        scrollView.addSubview(imageView)
    
        
//        tempBlob.image = blobImage
//        view.addSubview(tempBlob)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var leftAlign = true
        var y: CGFloat = 100
        var totalContentSize = y
        
        for animal in animals {
            let imageUrl = animal["imgUrl"] as? String
            let imageView = UIImageView(image: UIImage(named:imageUrl ?? "turtle-icon"))
            imageView.frame = CGRect(x: 0, y: y, width: 100, height: 100)
            if leftAlign {
                imageView.center.x = view.frame.width / 4
            } else {
                imageView.center.x = view.frame.width * (3 / 4)
            }
            leftAlign = !leftAlign
            scrollView.addSubview(imageView)
            y += (imageView.frame.height + 100)
            totalContentSize += (imageView.frame.height + 100)
        }
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: totalContentSize)
        scrollView.frame = view.frame
        
        roadView.frame = CGRect(x: 0, y: -20, width: 200, height: totalContentSize + 80)
        roadView.center.x = view.center.x
        
    }
}
