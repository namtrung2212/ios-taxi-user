//
//  TaxiManager.Events.swift
//  User.iPhone
//
//  Created by Trung Dao on 6/20/16.
//  Copyright © 2016 SCONNECTING. All rights reserved.
//

import Foundation
import SClientData
import SClientModel
import SClientModelControllers

extension TravelOrderManager: TaxiSocketDelegate,ChatSocketDelegate{
    
    
    public func onTaxiSocketLogged(_ data : [AnyObject]){
        
    }
    
    public func onChatSocketLogged(_ data : [AnyObject]){
        
    }

    
    public func onDriverBidding(_ data : [AnyObject]){
        
    }
    
    public func onDriverAccepted(_ data : [AnyObject]){
        
        let arrData = data[0] as! [String: AnyObject]
        
        let userId = arrData["UserID"] as! String
        let driverId = arrData["DriverID"] as! String
        let orderId = arrData["OrderID"] as! String
        
        if(self.currentOrder.id == orderId){

            self.invalidate(true, orderId: orderId, updateUI: true) {
                
                if(self.currentOrder.Status == OrderStatus.DriverAccepted){
                    
                    AppDelegate.mainWindow?.mainViewCtrl.taxiViewCtrl.orderPhase = OrderPhase.monitoring
                    
                    if(DriverProfileScreen.instance == nil ||   DriverProfileScreen.instance!.driver == nil ||  DriverProfileScreen.instance!.driver!.id != driverId ){
                        DriverProfileScreen.instance  =  DriverProfileScreen(_driverId: driverId)
                    }
                    
                    if(DriverProfileScreen.instance!.travelOrder == nil || DriverProfileScreen.instance?.travelOrder!.id != orderId){
                        
                        DriverProfileScreen.instance!.setCurrentOrder(self.currentOrder, bidding: nil)
                        
                        AppDelegate.mainWindow?.mainViewCtrl.taxiViewCtrl.navigationController?.popToRootViewController(animated: true)
                        AppDelegate.mainWindow?.mainViewCtrl.taxiViewCtrl.navigationController?.pushViewController(DriverProfileScreen.instance!, animated:true)
                        
                    }
                    
                    DriverProfileScreen.instance?.invalidateOrderStatus(OrderStatus.DriverAccepted)
                    DriverProfileScreen.instance?.invalidateOrder{
                        DriverProfileScreen.instance?.navigationController?.popToRootViewController(animated: true)
                        
                    }
                    
                }else{
                    
                }
                
            }

        }else{
            
        }
    }
    
    public func onDriverRejected(_ data : [AnyObject]){
        
        
        let arrData = data[0] as! [String: AnyObject]
        
        let userId = arrData["UserID"] as! String
        let driverId = arrData["DriverID"] as! String
        let orderId = arrData["OrderID"] as! String
        
        if(self.currentOrder.id == orderId){

            self.invalidate(true, orderId: orderId, updateUI: false) {
                    
                    if(self.currentOrder.Status == OrderStatus.DriverRejected){
                        
                            if(DriverProfileScreen.instance == nil ||   DriverProfileScreen.instance!.driver == nil ||  DriverProfileScreen.instance!.driver!.id != driverId ){
                                DriverProfileScreen.instance  =  DriverProfileScreen(_driverId: driverId)
                            }

                            if(DriverProfileScreen.instance!.travelOrder == nil || DriverProfileScreen.instance?.travelOrder!.id != orderId){
                                
                                DriverProfileScreen.instance!.setCurrentOrder(self.currentOrder, bidding: nil)
                                
                                AppDelegate.mainWindow?.mainViewCtrl.taxiViewCtrl.navigationController?.popToRootViewController(animated: true)
                                AppDelegate.mainWindow?.mainViewCtrl.taxiViewCtrl.navigationController?.pushViewController(DriverProfileScreen.instance!, animated:true)
                                
                                AppDelegate.mainWindow?.mainViewCtrl.taxiViewCtrl.orderPhase = OrderPhase.chooseDriver

                            }
                            
                            DriverProfileScreen.instance?.invalidateOrderStatus(OrderStatus.DriverRejected)
                            DriverProfileScreen.instance?.invalidateOrder(nil)
                    }
                    
            }
        }
    }
    
    public func onCarUpdateLocation(_ data : [AnyObject]){
        
        let arrData = data[0] as! [String: AnyObject]
        
        let userId = arrData["UserID"] as! String
        let driverId = arrData["DriverID"] as! String
        let orderId = arrData["OrderID"] as! String
        
        let latitude = arrData["latitude"] as! Double
        let longitude = arrData["longitude"] as! Double
        let degree = arrData["degree"] as! Double
        let distance = arrData["distance"] as! Double
        
        if(self.currentOrder.id == orderId){
        
                    AppDelegate.mainWindow?.mainViewCtrl.taxiViewCtrl.mapMarkerManager.invalidateCar(driverId, latitude: latitude, longitude: longitude, degree: degree,hideOther: true)
                    AppDelegate.mainWindow?.mainViewCtrl.taxiViewCtrl.mapMarkerManager.currentCar?.moveToCarLocation()
            
                    if(self.currentOrder.IsMonitoring()){
                        
                        self.locationsPoints.append(CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
                        self.currentTravelDistance = distance
                        self.invalidateUI(false, completion: nil)
                    
                        AppDelegate.mainWindow?.mainViewCtrl.taxiViewCtrl.orderPhase = OrderPhase.monitoring
                    }
        }
 
        
        
    }
    
    public func onDriverVoidedBfPickup(_ data : [AnyObject]){
        
        let arrData = data[0] as! [String: AnyObject]
        
        let userId = arrData["UserID"] as! String
        let driverId = arrData["DriverID"] as! String
        let orderId = arrData["OrderID"] as! String
        
            ModelController<TravelOrder>.queryServerById(orderId) { (item) in
                if(item != nil && item!.Status ==  OrderStatus.VoidedBfPickupByDriver){
                    
                    let alert = UIAlertController(title: "Tài xế hủy đón", message: "Tài xế hủy đón tại địa chỉ : \r\n \n \((item?.OrderPickupPlace)!)", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .Default, handler: { (action: UIAlertAction!) in
                        if(self.currentOrder.id == orderId){
                            self.resetWhenVoidedBeforePickup(item!, completion: nil)                        }

                    }))
                    
                    AppDelegate.mainWindow?.mainViewCtrl.presentViewController(alert, animated: true, completion: nil)
                    
                    
                }
            }
            
        

    }
    
    
    public func onDriverStartedTrip(_ data : [AnyObject]){
        
        let arrData = data[0] as! [String: AnyObject]
        
        let userId = arrData["UserID"] as! String
        let driverId = arrData["DriverID"] as! String
        let orderId = arrData["OrderID"] as! String
        
            
                ModelController<TravelOrder>.queryServerById(orderId) { (item) in
                    if(item != nil && item!.Status ==  OrderStatus.TripStarted){
                        
                        if(self.currentOrder.id == orderId){
                            
                            self.reset(item!, updateUI: true, completion: {
                                
                            })
                            
                            if(DriverProfileScreen.instance != nil){
                                DriverProfileScreen.instance?.invalidateOrderStatus(OrderStatus.TripStarted)
                                DriverProfileScreen.instance?.invalidateOrder{
                                    DriverProfileScreen.instance?.navigationController?.popToRootViewControllerAnimated(true)
                                }
                            }
                        }
                        
                        let alert = UIAlertController(title: "Bắt đầu hành trình", message: "Tài xế đã đón khách địa chỉ : \r\n \n \(item?.ActPickupPlace == nil ? "" : (item?.ActPickupPlace)!)", preferredStyle: UIAlertControllerStyle.Alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .Default, handler: { (action: UIAlertAction!) in
                            
                          
                        }))
                        
                        AppDelegate.mainWindow?.mainViewCtrl.presentViewController(alert, animated: true, completion: nil)

                    }
                }
                
        
    }
    
    
    public func onDriverVoidedAfPickup(_ data : [AnyObject]){
        
        let arrData = data[0] as! [String: AnyObject]
        
        let userId = arrData["UserID"] as! String
        let driverId = arrData["DriverID"] as! String
        let orderId = arrData["OrderID"] as! String
        
                ModelController<TravelOrder>.queryServerById(orderId) { (item) in
                    if(item != nil && ( item!.Status ==  OrderStatus.VoidedAfPickupByDriver || item!.Status ==  OrderStatus.VoidedAfPickupByUser)){
                        
                            if(self.currentOrder.id == orderId){

                                self.reset(item!, updateUI: true, completion: {
                                    
                                })
                                
                                if(DriverProfileScreen.instance != nil){
                                    DriverProfileScreen.instance?.invalidateOrderStatus(OrderStatus.VoidedAfPickupByUser)
                                    DriverProfileScreen.instance?.invalidateOrder{
                                        DriverProfileScreen.instance?.navigationController?.popToRootViewControllerAnimated(true)
                                    }
                                }
                            }

                        
                        self.isShouldPayByCash(item!, completion: { (shouldCash) in
                            var alert: UIAlertController
                            
                            if(item!.Status ==  OrderStatus.VoidedAfPickupByDriver){
                                    alert  = UIAlertController(title: "Tài xế hủy giữa hành trình ", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                            }else{
                                    alert  = UIAlertController(title: "Bạn đã hủy giữa hành trình ", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                            }
                            
                            if(shouldCash){
                                alert.message =  "\(item?.ActDropPlace == nil ? "" : (item!.ActDropPlace!)) \r \n Xác nhận và thanh toán cước: \r \n \(item!.ActPrice.toCurrency(item!.Currency, country: nil)!) bằng tiền mặt"
                            }else{
                                alert.message =  "\(item?.ActDropPlace == nil ? "" : (item!.ActDropPlace!)) \r \n Xác nhận và thanh toán cước: \r \n \(item!.ActPrice.toCurrency(item!.Currency, country: nil)!)"
                            }
                            
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .Default, handler: { (action: UIAlertAction!) in
                                
                                
                            }))
                            
                            AppDelegate.mainWindow?.mainViewCtrl.presentViewController(alert, animated: true, completion: nil)
                        })
                        
                    }
                }
        
    }
    
    
    public func onDriverFinished(_ data : [AnyObject]){
        
        let arrData = data[0] as! [String: AnyObject]
        
        let userId = arrData["UserID"] as! String
        let driverId = arrData["DriverID"] as! String
        let orderId = arrData["OrderID"] as! String
        
        
            
                    ModelController<TravelOrder>.queryServerById(orderId) { (item) in
                        if(item != nil && item!.Status ==  OrderStatus.Finished){
                            
                            if(self.currentOrder.id == orderId){
                                
                                self.reset(item!, updateUI: true, completion: {
                                    
                                })
                                
                                if(DriverProfileScreen.instance != nil){
                                    DriverProfileScreen.instance?.invalidateOrderStatus(OrderStatus.Finished)
                                    DriverProfileScreen.instance?.invalidateOrder{
                                        DriverProfileScreen.instance?.navigationController?.popToRootViewControllerAnimated(true)
                                    }
                                }
                            }
                            
                            self.isShouldPayByCash(item!, completion: { (shouldCash) in
                                
                                let alert  = UIAlertController(title: "Đã đến nơi", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                                
                                if(shouldCash){
                                    alert.message =  "\(item?.ActDropPlace == nil ? "" : (item!.ActDropPlace!)) \r \n Xác nhận và thanh toán cước: \r \n \(item!.ActPrice.toCurrency(item!.Currency, country: nil)!) bằng tiền mặt"
                                }else{
                                    alert.message =  "\(item?.ActDropPlace == nil ? "" : (item!.ActDropPlace!)) \r \n Xác nhận và thanh toán cước: \r \n \(item!.ActPrice.toCurrency(item!.Currency, country: nil)!)"
                                }
                                
                                alert.addAction(UIAlertAction(title: "Đồng ý", style: .Default, handler: { (action: UIAlertAction!) in
                                    
                                    
                                }))
                                
                                AppDelegate.mainWindow?.mainViewCtrl.presentViewController(alert, animated: true, completion: nil)
                            })
                            
                        }
                    }

    }
    
    func isShouldPayByCash(_ order: TravelOrder,completion: ((_ shouldCash: Bool ) -> ())?) {
     
            let query = "User=\(order.User!)&Currency=\(order.Currency)&IsVerified=1&IsExpired=0&IsLocked=0"
            DataManager<UserPayCard>.queryServerForDoubleResponse("count", filter: query) { (cards) in
                
                if(cards > 0){
                    completion?(shouldCash: false)
                }else{
                        let query2 = "AssignedUser=\(order.User!)&Currency=\(order.Currency)&IsOverBudget=0&IsActivated=1&IsExpired=0&IsLocked=0"
                        DataManager<BusinessCardBudget>.queryServerForDoubleResponse("count", filter: query2) { (cards2) in
                            completion?(shouldCash: cards2 == 0)
                        }
                }
                
            }
        
    }
    
    
    public func onDriverCashPaid(_ data : [AnyObject]){
        
        let arrData = data[0] as! [String: AnyObject]
        
        let userId = arrData["UserID"] as! String
        let driverId = arrData["DriverID"] as! String
        let orderId = arrData["OrderID"] as! String
        
            
            ModelController<TravelOrder>.queryServerById(orderId) { (item) in
                if(item != nil && item!.IsFinishedAndPaid()){
                    
                            if(self.currentOrder.id == orderId){
                                
                                if(DriverProfileScreen.instance != nil){
                                    DriverProfileScreen.instance?.invalidateOrderStatus(OrderStatus.Finished)
                                    DriverProfileScreen.instance?.invalidateOrder{
                                        DriverProfileScreen.instance?.navigationController?.popToRootViewControllerAnimated(true)
                                    }
                                }
                            }
                    
                            if(item!.PayAmount > 0){
                                
                                    let alert = UIAlertController(title: "Tài xế đã nhận tiền mặt", message: "Bạn vừa thanh toán \(item!.PayAmount.toCurrency(item!.PayCurrency!, country: nil)!) tiền mặt. \r\n Cảm ơn đã sử dụng dịch vụ. \r\n Chúc bạn một ngày vui vẻ!", preferredStyle: UIAlertControllerStyle.Alert)
                                    
                                    alert.addAction(UIAlertAction(title: "Xác nhận", style: .Default, handler: { (action: UIAlertAction!) in
                                        if((self.currentOrder != nil) && (item!.id == self.currentOrder!.id)){
                                            self.reset( true, completion: {
                                                
                                            })
                                        }
                                    }))
                                    
                                    
                                    AppDelegate.mainWindow?.mainViewCtrl.presentViewController(alert, animated: true, completion: nil)
                         }
                }
            }
        
    }
    

    
    public func onDriverChat(_ data : [AnyObject]){
        
        let arrData = data[0] as! [String: AnyObject]
        
        let userId = arrData["UserID"] as! String
        let driverId = arrData["DriverID"] as! String
        let orderId = arrData["OrderID"] as! String
        let contentId = arrData["ContentID"] as! String
        let content = arrData["Content"] as! String

        
        if(self.currentOrder.id == orderId){
            
            AppDelegate.mainWindow?.mainViewCtrl.taxiViewCtrl.monitoringView.increaseMessageNo(1){ number in
                
                AppDelegate.mainWindow?.mainViewCtrl.taxiViewCtrl.monitoringView.invalidateLastMessage(false,message: content){
                    
                    
                    AppDelegate.mainWindow?.mainViewCtrl.taxiViewCtrl.monitoringView.chattingView!.chattingTable!.addItemFromDriver(contentId, content : content) {
                        
                    }
                    
                    AppDelegate.mainWindow?.mainViewCtrl.taxiViewCtrl.monitoringView.chattingView!.chattingTable!.loadNewItems({
                        
                        
                    })
                
                }
            }
            
        
            
        }
    }
    

}
