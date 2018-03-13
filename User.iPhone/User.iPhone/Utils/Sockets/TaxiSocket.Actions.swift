//
//  TaxiSocket.Actions.swift
//  User.iPhone
//
//  Created by Trung Dao on 6/19/16.
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
import  SocketIOClientSwift

extension TaxiSocket{
    
    
    
    public func loggin(){
        socket.emit("UserLogin", ["UserID": SCONNECTING.UserManager!.CurrentUser!.id!])
    }
    
    public func viewDriverProfile(_ order: TravelOrder,driverId: String){
        
        socket.emit("UserViewDriverProfile", ["UserID": SCONNECTING.UserManager!.CurrentUser!.id! , "DriverID" : driverId , "OrderID" : order.id!])
        
    }

    
    public func requestTaxi(_ order: TravelOrder,driverId: String){
        
        socket.emit("UserRequestTaxi", ["UserID": SCONNECTING.UserManager!.CurrentUser!.id! , "DriverID" : driverId , "OrderID" : order.id!])
        
    }
    
    public func cancelRequest(_ order: TravelOrder,driverId: String){
        
        socket.emit("UserCancelRequest", ["UserID": SCONNECTING.UserManager!.CurrentUser!.id! , "DriverID" : driverId , "OrderID" : order.id!])
        
    }

    
    public func acceptBidding(_ order: TravelOrder,driverId: String){
        
        socket.emit("UserAcceptBidding", ["UserID": SCONNECTING.UserManager!.CurrentUser!.id! , "DriverID" : driverId , "OrderID" : order.id!])
        
    }
    
    public func cancelBidding(_ order: TravelOrder,driverId: String){
        
        socket.emit("UserCancelBidding", ["UserID": SCONNECTING.UserManager!.CurrentUser!.id! , "DriverID" : driverId , "OrderID" : order.id!])
        
    }


    
    public func voidBeforePickup(_ order: TravelOrder){
        
        socket.emit("UserVoidedBfPickup", ["UserID": SCONNECTING.UserManager!.CurrentUser!.id! , "DriverID" : order.Driver! , "OrderID" : order.id!])
        
    }
        
    
    public func voidAfterPickup(_ order: TravelOrder){
        
        socket.emit("UserVoidedAfPickup", ["UserID": SCONNECTING.UserManager!.CurrentUser!.id! , "DriverID" : order.Driver! , "OrderID" : order.id!])
        
    }
    
    public func paid(_ order: TravelOrder){
        
        socket.emit("UserPaid", ["UserID": SCONNECTING.UserManager!.CurrentUser!.id! , "DriverID" : order.Driver! , "OrderID" : order.id!])
        
    }

        

}
