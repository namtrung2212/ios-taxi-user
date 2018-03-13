//
//  CashManager.swift
//  User.iPhone
//
//  Created by Trung Dao on 7/4/16.
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

open class CashManager : NSObject {
    
    
    open var CurrentBusiness : Business?
    open var BusinessAccounts : [BusinessAccount] = []
    open var BusinessCards :  [BusinessCard] = []

    open static func activate(_ userId: String){
        
        DataManager<BusinessAccount>.queryServer("selectall", filter: "Manager=\(userId)") { (items) in
            
            
        }
        
    }
}
