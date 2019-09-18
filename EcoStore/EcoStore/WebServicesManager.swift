//
//  WebServicesManager.swift
//  EcoStore
//
//  Created by Stephanie Gu on 2019-09-15.
//  Copyright © 2019 Stephanie Gu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WebServicesManager {
    
    // MARK:- Shared Instance
    static let shared = WebServicesManager()
    
    // API url
    private let url = "https://ecostore.herokuapp.com"
    
    // User Id
    var userId: String = "-1"
    
    var userName: String = "John Doe"
    var userEmail: String = "johndoe@fake.com"
    
    var userPoints: Int? {
        set {
            UserDefaults.standard.set(newValue, forKey: "userPoints")
            let lastIndex = AnimalManager.shared.restoredAnimalData?.last ?? -1
            let animals = DMM.animals
            if lastIndex < animals.count - 1 {
                if let cost = animals[lastIndex + 1]["cost"] as? Int {
                    if let newValue = newValue {
                        if newValue >= cost {
                            AnimalManager.shared.restoreAnimal(index: lastIndex + 1)
                        }
                    }
                }
            }
            //updateLocalData()
        }
        get {
            return UserDefaults.standard.object(forKey: "userPoints") as? Int
        }
    }
    
    var localUserPoints: Int? = nil
    
    private func updateLocalData() {
        localUserPoints = userPoints
    }
    
    // MARK:- Services
    func loginService(loginEmail: String, loginPassword: String, completion: ((Bool)->Void)?) {
        let service = "/LoginUser"
        let responseType:HTTPMethod = .post
        
        let par = ["email":loginEmail, "password":loginPassword]
        //let par = ["email": "joyce6zheng@gmail.com", "password": "recycle"]
        
        Alamofire.request(url + service, method: responseType, parameters: par).responseJSON { responseData in
            if let data = responseData.result.value as? [String:AnyObject] {
                if data["code"] as? Int == 200 {
                    if let userData = data["userData"] as? [String:AnyObject] {
                        AnimalManager.shared.restoredAnimalData = userData["restoredAnimals"] as? [Int]
                        if let userId = userData["_id"] as? String {
                            self.userId = userId
                        }
                        if let userName = userData["name"] as? String {
                            self.userName = userName
                        }
                        if let userEmail = userData["email"] as? String {
                            self.userEmail = userEmail
                        }
                        if let points = userData["points"] as? Int {
                            self.userPoints = points
                        }
                    }
                    completion?(true)
                } else {
                    if let errorMsg = data["msg"] as? String {
                        print(errorMsg)
                    }
                    completion?(false)
                }
            } else {
                print("Empty response.")
                completion?(false)
            }
        }
    }
    
    func incrementPointsService(completion: ((Bool)->Void)?) {
        let service = "/IncrementUserPoints"
        let responseType = HTTPMethod.post
        let par = ["id": self.userId]
        
        Alamofire.request(url + service, method: responseType, parameters: par).responseJSON { responseData in
            if let data = responseData.result.value as? [String:AnyObject] {
                if data["code"] as? Int == 200 {
                    if let points = data["updatedPoints"] as? Int {
                        self.userPoints = points
                        print(points)
                    }
                    completion?(true)
                } else {
                    if let errorMsg = data["msg"] as? String {
                        print(errorMsg)
                    }
                    completion?(false)
                }
            } else {
                print("Empty response.")
                completion?(false)
            }
        }
    }
    
    func addRestoredAnimalsService(index: Int, completion:((Bool)->Void)?) {
        let service = "/AddRestoredAnimals"
        let responseType = HTTPMethod.post
        let par:[String:Any] = ["id": self.userId, "animalID": index]
        
        Alamofire.request(url + service, method: responseType, parameters: par).responseJSON { responseData in
            if let data = responseData.result.value as? [String:AnyObject] {
                if data["code"] as? Int == 200 {
                    completion?(true)
                } else {
                    completion?(false)
                }
            }
        }
    }
    
    
}
