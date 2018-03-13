//
//  Map.swift
//  User.iPhone
//
//  Created by Trung Dao on 8/3/16.
//  Copyright © 2016 SCONNECTING. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper
import SClientData
import SClientModel
import CoreLocation
import RealmSwift
import SwiftyJSON
import GoogleMaps


extension TravelOrderScreen {
    
    func initMapControls(_ completion: (() -> ())?){
        
        mapView.initControls(completion)
    }
    
    func initMapLayout(_ completion: (() -> ())?){
        
        mapView.initLayout(completion)
        
    }
    
    func invalidateMapView(_ isFirstTime: Bool,completion: (() -> ())?){
        
        mapView.invalidate (isFirstTime,completion:  completion)
    }
    
}
