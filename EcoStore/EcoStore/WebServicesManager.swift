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
    private var userId: String = "-1"
    
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
                    }
                    completion?(true)
                } else {
                    if let errorMsg = data["msg"] as? String {
                        print(errorMsg)
                        completion?(false)
                    }
                }
            } else {
                print("Empty response.")
                completion?(false)
            }
        }
    }
    
    
}
