//
//  BOOKTAXIswift
//  BOOKTAXI
//
//  Created by Trung Dao on 4/13/16.
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

extension TravelOrderManager{
        
    
    public func createLateOrderIfNeeded(_ completion:(() -> ())?){
        
        if(self.currentOrder.isNew() && self.currentOrder.IsPickupNow() == false){
            
            self.createLateOrder{
                completion?()
            }
        
        }else{
             completion?()
        }
        
    }

    public func createLateOrder(_ completion:(() -> ())?){
        
        self.currentOrder.User = (SCONNECTING.UserManager!.CurrentUser != nil) ? SCONNECTING.UserManager!.CurrentUser!.id : nil
        self.currentOrder.UserName = (SCONNECTING.UserManager!.CurrentUser != nil) ? SCONNECTING.UserManager!.CurrentUser!.Name : nil
        self.currentOrder.OrderLoc = LocationObject(latitude: SCLocationManager.latitude!, longitude: SCLocationManager.longitude!)
        self.currentOrder.Device = UIDevice.currentDevice().model
        self.currentOrder.DeviceID = UIDevice.currentDevice().identifierForVendor!.UUIDString
        self.currentOrder.Status = OrderStatus.Open
        
         ModelController<TravelOrder>.create(self.currentOrder) { (success, item) in
               self.currentOrder = item?.copy() as! TravelOrder
              completion?()
        }
        
    }
    
    
    public func getOpenningOrder(_ completion:(( _ item: TravelOrder?) -> ())?){
        
        if(SCONNECTING.UserManager!.CurrentUser != nil){
        
            TravelOrderController.GetLastOpenningOrderByUser((SCONNECTING.UserManager!.CurrentUser?.id)!) { (order) in
                     completion?(item: order)
            }
        
        }else{
             completion?(item: nil)
        }
        
    }

    
    
    public func cancelOrder(_ order: TravelOrder,completion:(() -> ())?){
     
        ModelController<TravelOrder>.delete(order) {
             completion?()
        }
        
    }
    
    
    
    public func setOrderStatusToOpen(_ order: TravelOrder,completion:((_ item: TravelOrder?) -> ())?){
        
        if(order.Status == OrderStatus.DriverRejected){
            
            order.Status = OrderStatus.Open
           
            ModelController<TravelOrder>.update(order) { (success, item) in
                completion?(item: item)
            }
        }else{
             completion?(item: order)
        }
        
    }
    


    
    
    public func viewDriverProfile(_ order: TravelOrder, driverId: String){
        
        SCONNECTING.NotificationManager!.taxiSocket.viewDriverProfile(order,driverId :driverId)
        
    }
    
    public func sendRequestToDriver(_ order: TravelOrder, driverId: String,completion:(( _ item: TravelOrder?) -> ())?){
        
        
        TravelOrderController.CalculateOrderPrice(driverId, distance: order.OrderDistance , currency: order.Currency, serverHandler: { (result) in
            
            if(result != nil){
                
                    order.OrderPrice = result!
                
                    order.User = (SCONNECTING.UserManager!.CurrentUser != nil) ? SCONNECTING.UserManager!.CurrentUser!.id : nil
                    order.UserName = (SCONNECTING.UserManager!.CurrentUser != nil) ? SCONNECTING.UserManager!.CurrentUser!.Name : nil
                    order.OrderLoc = LocationObject(latitude: SCLocationManager.latitude!, longitude: SCLocationManager.longitude!)
                    order.Device = UIDevice.currentDevice().model
                    order.DeviceID = UIDevice.currentDevice().identifierForVendor!.UUIDString
                    
                    order.Driver = driverId
                    order.Status = OrderStatus.Requested
                    
                    if(order.isNew()){
                        
                        ModelController<TravelOrder>.create(order) { (success, item) in
                            if(item != nil){
                                SCONNECTING.NotificationManager!.taxiSocket.requestTaxi(item!,driverId :driverId)
                                self.currentOrder = item?.copy() as! TravelOrder
                            }                            
                            completion?(item: item)

                        }
                        
                    }else{
                        
                        ModelController<TravelOrder>.update(order) { (success, item) in
                            if(item != nil){
                                SCONNECTING.NotificationManager!.taxiSocket.requestTaxi(item!,driverId :driverId)
                                self.currentOrder = item?.copy() as! TravelOrder
                            }
                            completion?(item: item)
                        }
                    }
            }
        })
    }
    
    public func cancelRequestToDriver(_ order: TravelOrder, driverId: String,completion:(( _ item: TravelOrder?) -> ())?){
        
        order.Device = UIDevice.currentDevice().model
        order.DeviceID = UIDevice.currentDevice().identifierForVendor!.UUIDString
        
        order.Driver = nil
        order.OrderPrice = 0
        order.Status = OrderStatus.Open
        
        ModelController<TravelOrder>.update(order) { (success, item) in
                if(item != nil){
                    SCONNECTING.NotificationManager!.taxiSocket.cancelRequest(item!,driverId :driverId)
                    self.currentOrder = item?.copy() as! TravelOrder
                }
                completion?(item: item)
        }
        
        
    }
    
    
    
    public func acceptBidding(_ order: TravelOrder, driverId: String,completion:(( _ item: TravelOrder?) -> ())?){

        
        TravelOrderController.CalculateOrderPrice(driverId, distance: order.OrderDistance , currency: order.Currency, serverHandler: { (result) in
          
            if(result != nil){
                    order.OrderPrice = result!
                    
                    order.Device = UIDevice.currentDevice().model
                    order.DeviceID = UIDevice.currentDevice().identifierForVendor!.UUIDString
                    
                    order.Driver = driverId
                    order.Status = OrderStatus.BiddingAccepted
                    
                    ModelController<TravelOrder>.update(order) { (success, item) in
                        if(item != nil){
                            SCONNECTING.NotificationManager!.taxiSocket.acceptBidding(item!,driverId :driverId)
                            self.currentOrder = item?.copy() as! TravelOrder

                        }
                        completion?(item: item)
                    }
            }
            
        })
        
    }
    
    public func cancelBidding(_ order: TravelOrder, driverId: String,completion:(( _ item: TravelOrder?) -> ())?){
        
        order.Device = UIDevice.currentDevice().model
        order.DeviceID = UIDevice.currentDevice().identifierForVendor!.UUIDString
        
        order.Driver = nil
        order.OrderPrice = 0
        order.Status = OrderStatus.Open
        
        ModelController<TravelOrder>.update(order) { (success, item) in
            if(item != nil){
                SCONNECTING.NotificationManager!.taxiSocket.cancelBidding(item!,driverId :driverId)
                self.currentOrder = item?.copy() as! TravelOrder
            }
            completion?(item: item)
        }
        
        
    }

    
    public func voidTrip(_ order: TravelOrder,completion:(( _ item: TravelOrder?) -> ())?){
        
        if(order.id != nil && (order.Status == OrderStatus.Open || order.Status == OrderStatus.DriverRejected)){
            
            TravelOrderController.delete(order, completion: {
                completion?(item: order)
            })
            return;
            
        }
        
        if(order.Status !=  OrderStatus.DriverAccepted && order.Status !=  OrderStatus.TripStarted){
            completion?(item: order)
            return;
        }
        
        order.Device = UIDevice.currentDevice().model
        order.DeviceID = UIDevice.currentDevice().identifierForVendor!.UUIDString
        
        order.Status =  (order.Status == OrderStatus.DriverAccepted) ?  OrderStatus.VoidedBfPickupByUser :OrderStatus.VoidedAfPickupByUser
        
        ModelController<TravelOrder>.update(order) { (success, item) in
            
            self.currentOrder = item?.copy() as! TravelOrder
            if(item != nil){
                if(item!.Status == OrderStatus.VoidedBfPickupByUser ){
                    SCONNECTING.NotificationManager!.taxiSocket.voidBeforePickup(item!)
                    
                }else  if(item!.Status == OrderStatus.VoidedAfPickupByUser ){
                    SCONNECTING.NotificationManager!.taxiSocket.voidAfterPickup(item!)
                }
            }
            
            completion?(item: item)
        }
        
        
    }
    
    
    public func paid(_ orderToPay: TravelOrder,userpaycard: UserPayCard,completion:(( _ item: TravelOrder?) -> ())?){
        
        if(orderToPay.IsFinishedNotYetPaid() == false ){
            completion?(item: orderToPay)
            return;
        }
        
        ModelController<TravelOrder>.queryServerById(orderToPay.id!) { (order) in
            
            order!.PayMethod = "UserPayCard"
            order!.UserPayCard = userpaycard.id!
            order!.PayAmount = order!.ActPrice
            order!.PayCurrency = userpaycard.Currency
            order!.PayTransDate = NSDate()
            order!.IsVerified = true
            order!.IsPayTransSucceed = true
            order!.IsPaid = true
            
            ModelController<TravelOrder>.update(order!, completion: { (success, newitem) in
                if(success && newitem != nil && newitem!.PayAmount >= 0){
                    SCONNECTING.NotificationManager!.taxiSocket.paid(order!)
                }
                completion?(item: newitem)
            })
            
        }
        
        
    }
    
    
    public func paid(_ orderToPay: TravelOrder,businessCard: BusinessCardBudget,completion:(( _ item: TravelOrder?) -> ())?){
        
        if(orderToPay.IsFinishedNotYetPaid() == false ){
            completion?(item: orderToPay)
            return;
        }
        
        ModelController<TravelOrder>.queryServerById(orderToPay.id!) { (order) in
            
            order!.PayMethod = "UserPayCard"
            order!.BusinessCard = businessCard.Card
            order!.PayAmount = order!.ActPrice
            order!.PayCurrency = businessCard.Currency
            order!.PayTransDate = NSDate()
            order!.IsVerified = true
            order!.IsPayTransSucceed = true
            order!.IsPaid = true
            
            ModelController<TravelOrder>.update(order!, completion: { (success, newitem) in
                if(success && newitem != nil && newitem!.PayAmount >= 0){
                    SCONNECTING.NotificationManager!.taxiSocket.paid(order!)
                }
                completion?(item: newitem)
            })
            
        }
        
        
    }


    
    
    func travelDistanceFromBaseLocation() -> Double{
        
        var preLocation: CLLocationCoordinate2D? = nil
        var distance: Double = 0
        
        self.locationsPoints.forEach { (location) in
            if(preLocation != nil){
                
                let locationSource = CLLocation(latitude: preLocation!.latitude , longitude: preLocation!.longitude)
                let locationDestiny = CLLocation(latitude: location.latitude , longitude: location.longitude)
                distance += (locationSource.distance(from: locationDestiny))
                
            }
            preLocation = location
        }
        
        return distance
    }

    
    
    public func chat(_ order: TravelOrder,message: TravelOrderChatting,completion:(() -> ())?){
        
         SCONNECTING.NotificationManager!.chatSocket.chat(order, message: message)
         completion?()
    }

    
}
