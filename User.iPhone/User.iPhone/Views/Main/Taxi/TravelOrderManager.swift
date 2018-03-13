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
import CoreLocation
import RealmSwift
import GoogleMaps

open class TravelOrderManager : NSObject {
    
    open var currentOrder: TravelOrder!
    open var currentTravelDistance: Double?
    open var locationsPoints: [CLLocationCoordinate2D] = []
    
    var checkOrderStatusTimer: Timer? = nil
    
    public override init(){
        
        currentOrder = TravelOrder()
        currentTravelDistance = 0
    }
    
    public convenience init(order: TravelOrder){
        
        self.init()
        
        currentOrder = order
        currentTravelDistance = order.ActDistance
        
    }
    
    
    func invalidate(_ isFirstTime: Bool,orderId: String,updateUI: Bool,completion: (() -> ())?){
        
        ModelController<TravelOrder>.queryServerById(orderId) { (item) in
                if( item != nil){
                    
                    self.currentOrder = item?.copy() as! TravelOrder
                    
                    if(updateUI){
                     
                        AppDelegate.mainWindow?.mainViewCtrl.taxiViewCtrl.invalidateUI(isFirstTime,completion: completion)
                        return
                        
                    }
                    
                }
            
                completion?()
            
        }
        
    }
    
    
    func invalidate(_ isFirstTime: Bool,updateUI: Bool, completion: (() -> ())?){
        
        if(self.currentOrder.id != nil ) {
            
                ModelController<TravelOrder>.queryServerById(self.currentOrder.id!) { (item) in
                    
                        if( item != nil){
                            
                            self.currentOrder = item?.copy() as! TravelOrder
                            
                            if(updateUI){
                                
                                    self.invalidateUI(isFirstTime, completion: completion)
                                    return

                            }
                            
                        }
                    
                        completion?()
                    
                }
        
      }else{
            
                if(updateUI){
                    AppDelegate.mainWindow?.mainViewCtrl.taxiViewCtrl.invalidateUI(isFirstTime, completion: completion)
                }
            
                completion?()
            
        }
        
        
    }
    
    func invalidateUI(_ isFirstTime: Bool, completion: (() -> ())?){
        
        AppDelegate.mainWindow?.mainViewCtrl.taxiViewCtrl.invalidateUI(isFirstTime, completion: completion)
        
        self.startCheckStatusTimer(20)

    }
    
    func reset(_ updateUI: Bool, completion: (() -> ())?){
        
        SCONNECTING.TaxiManager?.locationsPoints.removeAll()
        self.reset(TravelOrder(),updateUI: updateUI){
            AppDelegate.mainWindow?.mainViewCtrl.taxiViewCtrl.mapMarkerManager.hideCars()
            AppDelegate.mainWindow?.mainViewCtrl.taxiViewCtrl.mapView!.updateAndMoveToCurrentLocation(14,isAnimate: false)
            completion?()
        }

    }
    
    func reset(_ order: TravelOrder,updateUI: Bool, completion: (() -> ())?){
        
        if(updateUI && order.IsNewOrder()){
            AppDelegate.mainWindow?.mainViewCtrl.taxiViewCtrl.orderPhase = OrderPhase.chooseLocation
        }
        
        if(self.currentOrder != nil && self.currentOrder!.id != order.id){
            
            self.currentTravelDistance = order.ActDistance
        }
        self.currentOrder = order.copy() as! TravelOrder
        
        self.invalidate(true, updateUI: updateUI){
                completion?()
        }
       
    }
    
    func resetWhenVoidedBeforePickup( _ order: TravelOrder, completion: (() -> ())?){

            if (order.Status == OrderStatus.VoidedBfPickupByDriver || order.Status == OrderStatus.VoidedBfPickupByUser) {
                
                    currentOrder = TravelOrder()
                    currentOrder.Device = order.Device
                    currentOrder.DeviceID = order.DeviceID
                    currentOrder.Status = OrderStatus.Open
                    currentOrder.User = order.User
                    currentOrder.UserName = order.UserName
                    currentOrder.OrderLoc = order.OrderLoc
                    currentOrder.OrderDropLoc = order.OrderDropLoc
                    currentOrder.OrderDistance = order.OrderDistance
                    currentOrder.OrderDropPlace = order.OrderDropPlace
                    currentOrder.OrderDropRestrict = order.OrderDropRestrict
                    currentOrder.OrderDuration = order.OrderDuration
                    currentOrder.OrderOneway = order.OrderOneway
                    currentOrder.OrderPickupCountry = order.OrderPickupCountry
                    currentOrder.OrderPickupLoc = order.OrderPickupLoc
                    currentOrder.OrderPickupPlace = order.OrderPickupPlace
                    currentOrder.OrderPickupTime = order.OrderPickupTime
                    currentOrder.OrderPrice = order.OrderPrice
                    currentOrder.OrderQuality = order.OrderQuality
                    currentOrder.OrderSeater = order.OrderSeater
                    
                    currentTravelDistance = 0.0
                    
                     AppDelegate.mainWindow?.mainViewCtrl.taxiViewCtrl.orderPhase = OrderPhase.chooseDriver;
                    
                    invalidate(true, updateUI: true,completion: completion);

            }else{
                
                completion?()

            }
        
    }

    open func Start(_ completion: (() -> ())?){
        
        ModelController<Company>.getAll(nil, serverHandler: nil)
        ModelController<Team>.getAll(nil, serverHandler: nil)
        
        ModelController<TaxiAveragePrice>.getAll(nil, serverHandler: nil)
        ModelController<TaxiPrice>.getAll(nil, serverHandler: nil)
        ModelController<TaxiDiscount>.getAll(nil, serverHandler: nil)
        
        ModelController<ExchangeRate>.getAll(nil, serverHandler: nil)
        
        SCONNECTING.NotificationManager?.taxiSocket.delegate = self
        SCONNECTING.NotificationManager?.chatSocket.delegate = self
        
        SCONNECTING.NotificationManager?.taxiSocket.connect{
            
            SCONNECTING.NotificationManager?.chatSocket.connect {
                completion?()
            }

        }
    }
    
    
    
    func startCheckStatusTimer(_ seconds : TimeInterval){
        
        if(self.checkOrderStatusTimer != nil){
            self.checkOrderStatusTimer!.invalidate()
        }else{
            self.checkOrderStatusTimer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(TravelOrderManager.runCheckOrderStatusTask), userInfo: nil, repeats: true)
        }
    }
    
    func runCheckOrderStatusTask(){
        
        self.invalidate(false, updateUI: true) {
            
            // if(self.currentOrder!.Status == OrderStatus.DriverAccepted){
            //    self.invalidate(false, updateUI: true,completion : nil)
            // }
        }
        
    }

    
    
    
}
