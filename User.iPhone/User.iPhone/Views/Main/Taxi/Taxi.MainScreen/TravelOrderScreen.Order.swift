//
//  TravelOrderScreen.Order.swift
//  User.iPhone
//
//  Created by Trung Dao on 8/3/16.
//  Copyright © 2016 SCONNECTING. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper
import AlamofireObjectMapper
import SClientData
import SClientModel
import SClientModelControllers
import CoreLocation
import RealmSwift
import GoogleMaps

extension TravelOrderScreen{
    
    var CurrentOrder: TravelOrder! {
        
        get {
            return SCONNECTING.TaxiManager!.currentOrder
        }
    }
    
    
    public var isChoosingLocationPhase : Bool{
        get{
            return self.CurrentOrder.IsNewOrder() && orderPhase == OrderPhase.ChooseLocation
        }
    }
    
    
    public var isCustomOrderPhase : Bool{
        
        get{
            return self.CurrentOrder.IsNewOrder() && orderPhase == OrderPhase.CustomOrder
        }
    }
    
    public var isChoosingDriverPhase : Bool{
        get{
            return (self.CurrentOrder.IsNewOrder() && orderPhase == OrderPhase.ChooseDriver ) || (!self.CurrentOrder.IsNewOrder() && self.CurrentOrder.IsNotYetChooseDriver())
        }
    }
    
    public var isMonitoringPhase : Bool{
        get{
            return !self.CurrentOrder.IsNewOrder() && self.CurrentOrder.IsMonitoring()
        }
    }
    
    public var isPaymentPhase : Bool{
        get{
            return !self.CurrentOrder.IsNewOrder() && self.CurrentOrder.IsFinishedNotYetPaid()
        }
    }
    
    public var isRatingPhase : Bool{
        get{
            return !self.CurrentOrder.IsNewOrder() &&  self.CurrentOrder.IsFinishedAndPaid()
        }
    }
    
    
    
    


}