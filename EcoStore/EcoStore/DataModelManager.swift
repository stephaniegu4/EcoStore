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
     }
 **/
    var animals: [[String:Any]] = [["name":"bear", "imgUrl":"bear-icon", "description":"Hi, I am Bear! Six of the eight bear species are currently threatened with extinction. ", "cost":2], ["name":"deer", "imgUrl":"deer-icon", "description":"Hi, I am the Key Deer species. The Key deer is listed as endangered by the Endangered Species Act. Currently fewer than 1,000 Key deer survive, and their future remains precarious. ", "cost":5], ["name":"owl", "imgUrl":"owl-icon", "description":"Hi, I am the owl species. There are some owl species that may not be able to survive for much longer primarily due to loss of habitat and hunting.", "cost":10], ["name":"ladybug", "imgUrl":"ladybug-icon", "description":"Hi, I am the ladybug. Native ladybugs have been in serious decline since the mid-1970s.", "cost":15], ["name":"lion", "imgUrl":"lion-icon", "description":"Hi, I am the African Lion. African lion numbers have plummeted by over 40% in the last three generations, due to loss of living space and conﬂict with people.", "cost":25], ["name":"zebra", "imgUrl":"zebra-icon", "description":"Hi, I am the Zebra, over the past three generations there was a population reduction of 54% from an estimated population of 5,800 in the 1980s.", "cost":40], ["name":"llama", "imgUrl":"llama-icon", "description":"Hi, I am the Llama. Llamas are not endangered, keep protecting us!", "cost":60], ["name":"walrus", "imgUrl":"walrus-icon", "description":"Hi, I am the Walrus. I am at an increasing threat of extinction due in part to global warming since I depend on sea ice for survival", "cost":85], ["name":"penguin", "imgUrl":"penguin-icon", "description":"Hi, I am the Penguin. 10 of the world’s 18 species of penguin are threatened with extinction. ", "cost":115], ["name":"tiger", "imgUrl":"tiger-icon", "description":"Hi, I am the Tiger. After a century of decline, overall my population numbers are on the rise. However much more work is needed to protect my species.", "cost":150], ["name":"monkey", "imgUrl":"monkey-icon", "description":"Hi, I am the Monkey. Half the 262 species of monkeys in the world are threatened with extinction. ", "cost":190], ["name":"crab", "imgUrl":"crab-icon", "description":"Hi, I am the Crab. Crabs are currently not endangered, let’s protecting us!", "cost":230], ["name":"elephant", "imgUrl":"elephant-icon", "description":"Hi, I am the Elephant. Elephant numbers were severely depleted during the 20th century, largely due to the massive ivory trade.", "cost":270], ["name":"bat", "imgUrl":"bat-icon", "description":"Hi, I am the bat. Currently 24 bat species are Critically Endangered", "cost":310], ["name":"jellyfish", "imgUrl":"jellyfish-icon", "description":"Hi, I am the Jellyfish. The Jellyfish are not endangered, let’s keep up the great work!", "cost":350], ["name":"koala", "imgUrl":"koala-icon", "description":"Hi, I am the Koala. The Koala is not endangered, let’s keep it up!", "cost":390], ["name":"giraffe", "imgUrl":"giraffe-icon", "description":"Hi, I am the Giraffe. My species is currently listed as critically endangered", "cost":430], ["name":"gorilla", "imgUrl":"gorilla-icon", "description":"Hi, I am the Gorilla. My population has endured years of war, hunting, habitat destruction and disease—threats so severe that it was once thought my species might be extinct by the end of the twentieth century.", "cost":470], ["name":"squid", "imgUrl":"squid-icon", "description":"Hi, I am the Squid. I am not endangered, keep up the great work!", "cost":510], ["name":"panda", "imgUrl":"panda-icon", "description":"Hi, I am the Panda. Severe threats from humans have left just over 1,800 pandas in the wild.", "cost":550], ["name":"turtle", "imgUrl":"turtle-icon", "description":"Hi, I am the Turtle. Nearly all species of sea turtle are classified as Endangered. ", "cost":590], ["name":"bee", "imgUrl":"bee-icon", "description":"Hi, I am the Bee. In recent years, bee populations have been declining globally. ", "cost":630], ["name":"unicorn", "imgUrl":"unicorn-icon", "description":"Hi, I am the Unicorn. I only appear to those who love the environment the most.", "cost":700]]

    
    // MARK:- Remove User Defaults
    func removeUserDefaults() {
        UserDefaults.standard.removeObject(forKey: "restoredAnimalData")
        UserDefaults.standard.removeObject(forKey: "userPoints")
    }
}
