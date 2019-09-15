//
//  AnimalsVC.swift
//  EcoStore
//
//  Created by Stephanie Gu on 2019-09-14.
//  Copyright © 2019 Stephanie Gu. All rights reserved.
//

import UIKit

protocol PresentModalDelegate {
    func presentModal(animal: [String:Any])
}


class AnimalsVC: CommonViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PresentModalDelegate {

    //MARK:- Variables
    private let animals = DMM.animals
    private let restored: [Int]? = AnimalManager.shared.restoredAnimalData

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        collectionView.register(AnimalCell.self, forCellWithReuseIdentifier: "cell")
        
        self.view.addSubview(collectionView)
    }

    // MARK:- Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animals.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AnimalCell
        cell.animal = animals[indexPath.row]
        if let restored = restored?.contains(indexPath.row), restored {
            cell.restored = true
        } else {
            cell.restored = false
        }
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    // MARK:- Present Modal Protocol
    func presentModal(animal: [String : Any]) {
        let modalVC = AnimalModalVC(animal: animal)
        modalVC.modalTransitionStyle = .crossDissolve
        modalVC.modalPresentationStyle = .overFullScreen
        self.present(modalVC, animated: true, completion: nil)
    }

}

// MARK:- Collection View Cell
class AnimalCell: UICollectionViewCell {
    
    private let animalIconView = UIButton(type: .custom)
    private var animalIcon: UIImage? = nil
    
    fileprivate var animal: [String:Any]? {
        didSet {
            guard let animal = animal else { return }
            
            if let imgUrl = animal["imgUrl"] as? String {
                animalIcon = UIImage(named: imgUrl)
                animalIconView.setImage(animalIcon, for: .normal)
            }
        }
    }
    
    fileprivate var restored = false {
        didSet {
            if restored {
                animalIconView.alpha = 1
            } else {
                animalIconView.alpha = 0.5
            }
        }
    }
    
    fileprivate var delegate: PresentModalDelegate?

    // MARK:- Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        animalIconView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        animalIconView.addTarget(self, action: #selector(openModal), for: .touchUpInside)
        contentView.addSubview(animalIconView)
    }
    
    // MARK:- Control Actions
    @objc func openModal() {
        guard let animal = self.animal else { return }
        delegate?.presentModal(animal: animal)
    }
}
