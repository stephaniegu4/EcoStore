//
//  DataModelManager.swift
//  EcoStore
//
//  Created by Stephanie Gu on 2019-09-14.
//  Copyright © 2019 Stephanie Gu. All rights reserved.
//

import UIKit

// MARK:- Shared
var DMM = DataModelManager()

class DataModelManager {
    
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
    var animals: [[String:Any]] = [["name":"bear", "imgUrl":"bear-icon", "description":"", "cost":2], ["name":"deer", "imgUrl":"deer-icon", "description":"", "cost":5], ["name":"owl", "imgUrl":"owl-icon", "description":"", "cost":10], ["name":"ladybug", "imgUrl":"ladybug-icon", "description":"", "cost":15], ["name":"lion", "imgUrl":"lion-icon", "description":"", "cost":25], ["name":"zebra", "imgUrl":"zebra-icon", "description":"", "cost":40], ["name":"llama", "imgUrl":"llama-icon", "description":"", "cost":60], ["name":"walrus", "imgUrl":"walrus-icon", "description":"", "cost":85], ["name":"penguin", "imgUrl":"penguin-icon", "description":"", "cost":115], ["name":"tiger", "imgUrl":"tiger-icon", "description":"", "cost":150], ["name":"monkey", "imgUrl":"monkey-icon", "description":"", "cost":190], ["name":"crab", "imgUrl":"crab-icon", "description":"", "cost":230], ["name":"elephant", "imgUrl":"elephant-icon", "description":"", "cost":270], ["name":"bat", "imgUrl":"bat-icon", "description":"", "cost":310], ["name":"jellyfish", "imgUrl":"jellyfish-icon", "description":"", "cost":350], ["name":"koala", "imgUrl":"koala-icon", "description":"", "cost":390], ["name":"giraffe", "imgUrl":"giraffe-icon", "description":"", "cost":430], ["name":"gorilla", "imgUrl":"gorilla-icon", "description":"", "cost":470], ["name":"squid", "imgUrl":"squid-icon", "description":"", "cost":510], ["name":"panda", "imgUrl":"panda-icon", "description":"", "cost":550], ["name":"turtle", "imgUrl":"turtle-icon", "description":"", "cost":590], ["name":"bee", "imgUrl":"bee-icon", "description":"", "cost":630], ["name":"unicorn", "imgUrl":"unicorn-icon", "description":"", "cost":700]]
}
