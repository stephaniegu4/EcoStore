//
//  AnimalManager.swift
//  EcoStore
//
//  Created by Stephanie Gu on 2019-09-14.
//  Copyright © 2019 Stephanie Gu. All rights reserved.
//

import UIKit

class AnimalManager {
    
    static var shared = AnimalManager()
    
    //MARK:- User Default Animal Data
    public var allAnimalData: [String:AnyObject]? {
        set {
            UserDefaults.standard.set(newValue, forKey: "allAnimalData")
            updateLocalData()
        }
        get {
            if let localData = localAllAnimalData, localData.count > 0 {
                return localAllAnimalData
            } else {
                return UserDefaults.standard.object(forKey: "allAnimalData") as? [String:AnyObject]
            }
        }
    }
    
    private var localAllAnimalData: [String:AnyObject]? = nil
    
    private func updateLocalData() {
        localAllAnimalData = allAnimalData
    }
    
}
