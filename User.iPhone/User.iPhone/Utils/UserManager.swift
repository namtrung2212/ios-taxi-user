//
//  UserManager.swift
//  User.iPhone
//
//  Created by Trung Dao on 6/15/16.
//  Copyright © 2016 SCONNECTING. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper
import AlamofireObjectMapper
import SClientData
import SClientModel
import CoreLocation
import RealmSwift
import GoogleMaps
import Alamofire
import SwiftyJSON


open class SCUserManager : NSObject {
    
    
    open var CurrentUser : User?
    open var CurrentUserSetting : UserSetting?
    open var CurrentUserStatus : UserStatus?
    open var CurrentLongtitude : Double?
    open var CurrentLatitude : Double?

    
    open static  var Token: String?{
        
        get {
            return UserDefaults.standard.string(forKey: "Token")
        }
    }
    
    
    open static  var DefaultUserID: String?{
        
        get {
            return UserDefaults.standard.string(forKey: "DefaultUserID")
        }
    }


    
    
    open func login(_ userId : String,completion: ((_ success: Bool) -> ())?){
        
        self.registerNewDevice(userId) { (success) in
            
            if(success){
                    
                    self.initCurrentUser { isValidUser in
                        completion?(isValidUser)
                    }
                
            }else{
                completion?(false)
            }
            
        }
        
    }
    
    
    open func updateUserName(_ userName : String,userId : String,completion: (() -> ())?){
        
        ModelController<User>.queryServerById(userId) { (item) in
            
            let newItem = item?.copy() as! User
            newItem.Name = userName
            ModelController<User>.update(newItem, completion: { (updatedItem) in
                completion?()
            })
        }
            
    }
     
    
    
    open func registerNewDevice(_ userId : String,completion: ((_ success: Bool) -> ())?){
        
            SCUserManager.requestNewToken(userId) { (success, token) in
               
                if(!success){
                    completion?(false)
                    return
                }
                
                ModelController<UserSetting>.getOneByField("User", value: userId, isGetNow: true, clientHandler: { (item) in
                    
                }, serverHandler: { (item) in
                    
                    let newItem = item?.copy() as! UserSetting
                    newItem.Device = UIDevice.currentDevice().model
                    newItem.DeviceID = UIDevice.currentDevice().identifierForVendor!.UUIDString
                    
                    ModelController<UserSetting>.update(newItem, completion: { (success, updatedItem) in
                        if(success){
                            self.CurrentUserSetting = updatedItem?.copy() as? UserSetting
                            NSUserDefaults.standardUserDefaults().setValue(userId, forKey: "DefaultUserID")                            

                        }
                        completion?(success: success)
                    })
                    
                })
            }
        
    }
    
    
    
    open static func isValidDevice(_ completion: ((Bool) -> ())?){
        
            let userId = DefaultUserID
            
            if userId == nil{
                completion?(false)
                return
            }
            
            getToken({ (token) in
                
                ModelController<UserSetting>.getOneByField("User", value: userId, isGetNow: true, clientHandler: { (item) in
                    
                    }, serverHandler: { (item) in
                        
                        if(item == nil){
                            
                            completion?(false)
                            
                        }else{

                            #if (arch(i386) || arch(x86_64)) && os(iOS)
                                
                                let isValid = true
                                
                            #else
                                
                                let isValid = (item!.Device == UIDevice.currentDevice().model) && ( item!.DeviceID == UIDevice.currentDevice().identifierForVendor!.UUIDString )
                                
                            #endif
                            
                            
                            completion?(isValid)
                        }
                        
                })

            })
    }
    
    
    
    open static func getToken(_ completion: ((String?) -> ())?){
        
        if let userId = DefaultUserID{
            
            requestNewToken(userId, completion: { (success,newToken) in
                if(success){
                    completion?(newToken)
                }else{
                    
                    completion?(nil)
                }
            })
        
        }else{
             completion?(nil)
        }
    }
    
    open static func requestNewToken(_ userId: String, completion: ((Bool,String?) -> ())?){
        
                let url = SClientData.ServerURL + "/authenticate/user"
                let headers = ["Content-Type": "text/plain"]
                let parameters = ["id": userId]
        
                Alamofire.request(.POST, url, parameters: parameters, headers: headers, encoding : .JSON)
                            .responseJSON { response in
                                
                                switch response.result {
                                    
                                case .Success(let data):
                                    
                                    let json = JSON(data)
                                    let success = json["success"].boolValue
                                    
                                    if (success == true){
                                        
                                        let token = json["token"].stringValue
                                        NSUserDefaults.standardUserDefaults().setValue(token, forKey: "Token")
                                        completion?(true,token)
                                        
                                    }else{
                                        completion?(false,nil)
                                    }
                                    
                                case .Failure( _):
                                    
                                    completion?( false,nil)
                                }
                }
    }
    
    
    open static func isValidToken(_ userId: String, completion: ((Bool) -> ())?){
        
                let token = Token
                if  token == nil{
                    completion?( false)
                    return
                 }
        
                let url = SClientData.ServerURL + "/authenticate/user/checktoken"
                let headers = ["Content-Type": "application/x-www-form-urlencoded"]
                let parameters = ["id": userId,"token": token!]
                
                Alamofire.request(.POST, url, parameters: parameters, headers: headers, encoding: .URLEncodedInURL)
                    .responseJSON { response in
                        
                        switch response.result {
                            
                        case .Success(let data):
                            
                            let json = JSON(data)
                            let success = json["success"]
                            
                            completion?((success == true))
                            
                        case .Failure( _):
                            
                            completion?( false)
                        }
                }
        
    }


    
    
    
    open func initCurrentUser(_ completion: ((_ validUser : Bool ) -> ())?){
        
            let userId = SCUserManager.DefaultUserID
            if(userId == nil){
                completion?(false)
                return
            }
        
            ModelController<User>.getById(userId!, clientHandler: { (item) in
                
                    if(item == nil){
                        completion?(validUser : false)
                        return
                    }
                
                    self.CurrentUser = item?.copy() as? User
                
                    ModelController<UserSetting>.getOneByField("User", value: userId, obj: &self.CurrentUserSetting)
                    ModelController<UserStatus>.getOneByField("User", value: userId, obj: &self.CurrentUserStatus)
                
                    completion?(validUser: true)               
                
            }, serverHandler: { (item) in
                
                    self.CurrentUser = item?.copy() as? User
                    
                    if(item == nil){
                        completion?(validUser : false)
                        return
                    }
                    ModelController<UserSetting>.getOneByField("User", value: userId, obj: &self.CurrentUserSetting)
                    ModelController<UserStatus>.getOneByField("User", value: userId, obj: &self.CurrentUserStatus)
                
                    completion?(validUser: true)
                
            })
        
        
    }

    
}
