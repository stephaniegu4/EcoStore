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
    public var restoredAnimalData: [Int]? {
        set {
            UserDefaults.standard.set(newValue, forKey: "restoredAnimalData")
            updateLocalData()
        }
        get {
            if let localData = localRestoredAnimalData, localData.count > 0 {
                return localRestoredAnimalData
            } else {
                return UserDefaults.standard.object(forKey: "restoredAnimalData") as? [Int]
            }
        }
    }
    
    private var localRestoredAnimalData: [Int]? = nil
    
    private func updateLocalData() {
        localRestoredAnimalData = restoredAnimalData
    }
    
}
