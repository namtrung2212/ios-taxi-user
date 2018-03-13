//
//  Driver.swift
//  BOOKTAXI
//
//  Created by Trung Dao on 4/7/16.
//  Copyright © 2016 SCONNECTING. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

open class TaxiDiscount: BaseModel {
    
    open dynamic var Company : String?
    open dynamic var Team : String?
    open dynamic var QualityService : String?
    open dynamic var Priority : Int = 0
    open dynamic var IsActive : Bool = false
    open dynamic var FromDateTime : Date = Date()
    open dynamic var ToDateTime : Date?
    open dynamic var FromKm : Double = 0
    open dynamic var DiscountPct : Double = 0
    open dynamic var FixedDiscount : Double = 0
    open dynamic var Currency : String?
 
    
    required convenience public init?(_ map: Map) {
        self.init()
    }
    
    open override func mapping(_ map: Map) {
        
        super.mapping(map);
        
        Company <- map["Company"]
        Team <- map["Team"]
        QualityService    <- map["QualityService"]
        Priority <- map["Priority"]
        IsActive <- map["IsActive"]
        FromDateTime <- (map["FromDateTime"], MongoDateTransform())
        ToDateTime    <- (map["ToDateTime"], MongoDateTransform())
        FromKm <- map["FromKm"]
        DiscountPct <- map["DiscountPct"]
        FixedDiscount <- map["FixedDiscount"]
        Currency <- map["Currency"]
        
    }
  }
