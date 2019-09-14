//
//  DataModelManager.swift
//  EcoStore
//
//  Created by Stephanie Gu on 2019-09-14.
//  Copyright © 2019 Stephanie Gu. All rights reserved.
//

import UIKit

class DataModelManager {
    
    // MARK:- Shared
    public var DMM = DataModelManager()
    
    // MARK:- Supported Animals
    /**
     animals = {
     name: String
     imgUrl: String
     description: String
     cost: Int
     // restored is for animalmanager
     restored: Bool // default false -- when this data is retrieved at the launch of the app change these
     }
 **/
    private var animals: [[String:Any]] = [["name":"bear", "imgUrl":"bear-icon", "description":"", "cost":2], ["name":"penguin", "imgUrl":"penguin-icon", "description":"", "cost":5], ["name":"turtle", "imgUrl":"turtle-icon", "description":"", "cost":10], ["name":"turtle", "imgUrl":"turtle-icon", "description":"", "cost":2], ["name":"turtle", "imgUrl":"turtle-icon", "description":"", "cost":2], ["name":"turtle", "imgUrl":"turtle-icon", "description":"", "cost":2], ["name":"bee", "imgUrl":"turtle-icon", "description":"", "cost":100], ["name":"turtle", "imgUrl":"turtle-icon", "description":"", "cost":2], ["name":"turtle", "imgUrl":"turtle-icon", "description":"", "cost":2]]
}
