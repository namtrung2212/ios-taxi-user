//
//  Travel.Order.ChooseLocation.swift
//  User.iPhone
//
//  Created by Trung Dao on 5/25/16.
//  Copyright © 2016 SCONNECTING. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper
import AlamofireObjectMapper
import AlamofireImage
import SClientData
import SClientModel
import SClientModelControllers

import CoreLocation
import RealmSwift
import GoogleMaps


extension TravelMonitoringView{
    
    
    func shouldShowOrderPanel() -> Bool{
        
        let isShow : Bool = (self.CurrentOrder != nil && self.CurrentOrder!.User == SCONNECTING.UserManager?.CurrentUser!.id &&
            (  self.CurrentOrder!.IsMonitoring() ||  self.CurrentOrder.IsStopped()))
        
        return isShow
    }
    
    
    func showOrderPanel(_ show: Bool,completion: (() -> ())?){
        
        if(show){
            
                if(self.pnlOrderArea.hidden && CurrentOrder != nil && (CurrentOrder.IsMonitoring() ||  self.CurrentOrder.IsStopped() || self.CurrentOrder.IsPaid == false ) ){
                    
                            self.pnlOrderArea.isHidden = false
                            self.pnlButtonArea.isHidden = false
                            self.parent.view.layoutIfNeeded()
                }
                completion?()
            
            
        }else{
            
                if(self.pnlOrderArea.isHidden == false){
                    
                            self.pnlOrderArea.isHidden = true
                            self.pnlButtonArea.isHidden = true
                            self.parent.view.layoutIfNeeded()
                                            
                }
            
            completion?()
            
            
            
        }
    }
    
    
    func invalidateOrderPanel(_ isFirstTime: Bool, completion: (() -> ())?){
        
        let isShow : Bool = (  self.CurrentOrder!.IsMonitoring() ||  self.CurrentOrder.IsStopped())
        if(isShow){
            
            self.pnlOrderArea.isHidden = false
            self.pnlButtonArea.isHidden = false
            self.invalidateOrderPanelControls(isFirstTime) {
                
                    self.showOrderPanel(true){
                       
                            self.parent.view.layoutIfNeeded()
                            completion?()
                    }
                
            }
            
        }else{
            self.showOrderPanel(false) {
                self.pnlOrderArea.ConstraintState = self.isCollapsedOrder ? 2 : 1
                self.parent.view.layoutIfNeeded()
                completion?()
            }
        }
        
    }
    
    func invalidateOrderPanelControls( _ isFirstTime: Bool, completion: (() -> ())?){
        
        self.pnlOrderArea.ConstraintState = self.isCollapsedOrder ? 2 : (self.CurrentOrder.IsStopped() ? 3 : 1)
        self.btnCollapseOrder.setGMDIcon(self.isCollapsedOrder ? GMDType.gmdExpandLess : GMDType.gmdExpandMore, forState: UIControlState())
        
        self.invalidateStatus(isFirstTime){
            self.invalidatePickupDropLocation(isFirstTime){
                    self.invalidateMoreInfo(isFirstTime){
                        self.invalidateButtonArea(isFirstTime){
                            self.invalidateActualPrice(isFirstTime){

                                self.parent.view.layoutIfNeeded()
                                completion?()
                        }
                    }
                }
            }
        }
        
    }
    
    func invalidateStatus(_ isFirstTime: Bool, completion: (() -> ())?){
        
        var strStatus : String = ""
        
        if(self.CurrentOrder.IsWaitingForDriver()){
            strStatus = "Đang chờ tài xế."
            
            
            if( self.parent.mapMarkerManager.currentCar?.driverId == self.CurrentOrder.Driver && self.CurrentOrder.OrderPickupLoc != nil){
                
                let distance = self.parent.mapMarkerManager.currentCar?.distanceFromLocation(self.CurrentOrder.OrderPickupLoc!)
                if(distance >= 1000){
                    strStatus = NSString(format:"Khoảng cách %.1f Km", distance!/1000 ) as String
                    strStatus = "Đang chờ tài xế. \(strStatus)"
                    
                }else if(distance > 50) {
                    strStatus = NSString(format:"Khoảng cách %.0f m", distance! ) as String
                    strStatus = "Đang chờ tài xế. \(strStatus)"
                    
                }else{
                    strStatus = "Tài xế đã đến điểm hẹn."
                    if( strStatus.uppercased() != self.lblStatus.text){
                        
                        let alert = UIAlertController(title: "Tài xế đã đến điểm hẹn.", message: "Chúc quý khách 1 chuyến đi vui vẻ.", preferredStyle: UIAlertControllerStyle.alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .default, handler: { (action: UIAlertAction!) in
                            
                            if(DriverProfileScreen.instance != nil){
                                DriverProfileScreen.instance?.invalidateOrderStatus(OrderStatus.DriverAccepted)
                                DriverProfileScreen.instance?.invalidateOrder{
                                    DriverProfileScreen.instance?.navigationController?.popToRootViewController(animated: true)
                                }
                            }
                            
                        }))
                        
                        AppDelegate.mainWindow?.mainViewCtrl.present(alert, animated: true, completion: nil)
                        
                    }
                }
                
            }
            
        }else if(self.CurrentOrder.IsOnTheWay()){
            
            strStatus = "Đang trong hành trình. "
            
        }else if(self.CurrentOrder.IsVoidedByDriver()){
            
            strStatus = "Tài xế đã huỷ hành trình. "
            
        }else if(self.CurrentOrder.IsVoidedByUser()){
            
            strStatus = "Bạn đã huỷ hành trình. "
            
        }else if(self.CurrentOrder.IsFinishedNotYetPaid()){
            
            strStatus = "Đã đến nơi. Chưa thanh toán."
            
        }else if(self.CurrentOrder.IsFinishedAndPaid()){
            
            strStatus = "Đã thanh toán"
            
        }
        
        self.lblStatus.text = strStatus.uppercased()
        completion?()
        
    }
    
    func invalidateActualPrice(_ isFirstTime: Bool, completion: (() -> ())?){
        
        var distance : Double? = nil
        
        if(self.CurrentOrder!.IsOnTheWay()  && self.CurrentOrder!.ActPickupLoc != nil){
            distance = SCONNECTING.TaxiManager!.currentTravelDistance
        }
        
        
        self.updatePriceText(distance){
            
            self.lblCurrentPrice.ConstraintState = self.isCollapsedOrder ? 2 : 1
            completion?()
        }
    }
    
    func updatePriceText(_ distance: Double?,completion: (() -> ())?){
        
        
        if(self.CurrentOrder!.IsStopped() || self.CurrentOrder!.IsOnTheWay()){
            
            if(distance != nil && distance! >= 0 && abs(distance! - self.CurrentOrder!.ActDistance ) > 50 && self.CurrentOrder!.IsOnTheWay()){
                
                TravelOrderController.CalculateOrderPrice(self.CurrentOrder!.Driver!, distance: distance! , currency: self.CurrentOrder!.Currency, serverHandler: { (price) in
                    self.lblCurrentPrice.text = (price != nil && price! >= 0) ? price!.toCurrency(self.CurrentOrder!.Currency, country: nil) :  self.lblCurrentPrice.text
                    self.lblCurrentPrice.hidden = false
                    
                    self.CurrentOrder!.ActDistance = distance!
                    self.CurrentOrder!.ActPrice = (price != nil && price! > 0) ? price! : 0
                    
                    completion?()
                })
                
            }else if(self.CurrentOrder!.IsStopped()){
                
                self.lblCurrentPrice.text = (self.CurrentOrder!.ActPrice >= 0) ? self.CurrentOrder!.ActPrice.toCurrency(self.CurrentOrder!.Currency, country: nil) :  self.lblCurrentPrice.text
                self.lblCurrentPrice.isHidden = false
                completion?()
            
            }else{
                 completion?()
            }
            
        }else{
            
            self.lblCurrentPrice.text = ""
            self.lblCurrentPrice.isHidden = true
            completion?()
            
        }
        
    }
    
    func invalidateMoreInfo(_ isFirstTime: Bool, completion: (() -> ())?){
        
        if(self.CurrentOrder.IsWaitingForDriver()){
            
                self.lblMoreInfo.hidden = ( self.CurrentOrder.OrderDropLoc == nil ) || ( self.CurrentOrder.OrderPickupLoc == nil )
                
                if(self.lblMoreInfo.isHidden == false){
                    
                    var strPlanning: String?
                    
                    if(self.CurrentOrder!.OrderDistance > 0 && self.CurrentOrder!.OrderDuration > 0){
                        
                        let strDistance = NSString(format:"%.1f Km", self.CurrentOrder!.OrderDistance/1000 ) as String
                        let hours =  Int(self.CurrentOrder!.OrderDuration / 3600)
                        let minutes =  Int(round((self.CurrentOrder!.OrderDuration % 3600) / 60))
                        var strDuration = ""
                        if( hours > 0){
                            strDuration =  NSString(format:"%d giờ %d phút", hours, minutes ) as String
                        }else{
                            strDuration =  NSString(format:"%d phút", minutes ) as String
                            
                        }
                        strPlanning = strDistance + " - " + strDuration
                    }
                    
                    if(self.CurrentOrder!.OrderPrice > 0){
                        let strPrice = self.CurrentOrder!.OrderPrice.toCurrency(self.CurrentOrder!.Currency, country: nil)
                        if(strPrice != nil){
                            strPlanning = (strPlanning == nil) ? strPrice : (strPlanning! + " - " + strPrice!)
                        }
                    }
                
                    
                    if(strPlanning != nil){
                        strPlanning = "Dự kiến : \(strPlanning!)"
                    }else{
                        strPlanning = "\(self.CurrentOrder.CompanyName!.uppercaseString) hân hạnh phục vụ quý khách."
                    }
                    self.lblMoreInfo.text = strPlanning
                    
                }
            
        }else if(self.CurrentOrder != nil &&  self.CurrentOrder!.IsStopped()){
            
            
            self.lblMoreInfo.isHidden = false
            
            var strActual: String?
            
            if(self.CurrentOrder!.ActPickupLoc != nil && self.CurrentOrder!.ActDropLoc != nil){
                
                let actPickupLoc = CLLocation(latitude: self.CurrentOrder!.ActPickupLoc!.lat , longitude: self.CurrentOrder!.ActPickupLoc!.long)
                let actDropLoc = CLLocation(latitude: self.CurrentOrder!.ActDropLoc!.lat , longitude: self.CurrentOrder!.ActDropLoc!.long)
                let distance = self.CurrentOrder!.ActDistance > 0 ? self.CurrentOrder!.ActDistance : actDropLoc.distanceFromLocation(actPickupLoc)
                
                let strDistance = NSString(format:"%.1f Km", distance/1000 ) as String
                let timeInterval = self.CurrentOrder!.ActDropTime!.timeIntervalSinceDate(self.CurrentOrder!.ActPickupTime!)
                let hours =  Int(timeInterval / 3600)
                let minutes =  Int(round((timeInterval % 3600) / 60))
                
                var strDuration = ""
                if( hours > 0){
                    strDuration =  NSString(format:"%d giờ %d phút", hours, minutes ) as String
                }else{
                    strDuration =  NSString(format:"%d phút", minutes ) as String
                    
                }
                strActual = strDistance + " - " + strDuration
                
            }
            
            
            if(strActual != nil){
                strActual = "Thực tế : \(strActual!)"
            }else{
                strActual = ""
            }
            self.lblMoreInfo.text = strActual
            
            
        }else if(self.CurrentOrder != nil &&  self.CurrentOrder!.IsOnTheWay()){
            
            self.lblMoreInfo.text = ""
            
        }
        
        
        self.lblMoreInfo.showControl = !self.isCollapsedOrder && self.lblMoreInfo.text != ""
        completion?()
        
    }
    
    func invalidatePickupDropLocation(_ isFirstTime: Bool, completion: (() -> ())?){
        
        self.btnPickupIcon.showControl = !self.isCollapsedOrder
        self.lblPickupLocation.showControl = !self.isCollapsedOrder
        self.imgPickupLocationBG.showControl = !self.isCollapsedOrder
        if(self.CurrentOrder.OrderPickupLoc != nil && self.CurrentOrder.OrderPickupPlace != nil){
            self.lblPickupLocation.setTitle(self.CurrentOrder.OrderPickupPlace, for: .Normal)
            
        }else if(self.CurrentOrder.ActPickupLoc != nil && self.CurrentOrder.ActPickupPlace != nil){
            self.lblPickupLocation.setTitle(self.CurrentOrder.ActPickupPlace, for: .Normal)
            
        }
        
        self.btnDropIcon.showControl = !self.isCollapsedOrder
        self.lblDropLocation.showControl = !self.isCollapsedOrder
        self.imgDropLocationBG.showControl = !self.isCollapsedOrder
        if(self.CurrentOrder.OrderDropLoc != nil && self.CurrentOrder.OrderDropPlace != nil){
            self.lblDropLocation.setTitle(self.CurrentOrder.OrderDropPlace, for: .Normal)
            
        }else if(self.CurrentOrder.ActDropLoc != nil && self.CurrentOrder.ActDropPlace != nil){
            self.lblDropLocation.setTitle(self.CurrentOrder.ActDropPlace, for: .Normal)
            
        }
        completion?()
    }
    
    func invalidateButtonArea(_ isFirstTime: Bool, completion: (() -> ())?){
        
        self.pnlButtonArea.showControl = !self.isCollapsedOrder && self.CurrentOrder!.IsMonitoring()
        self.btnVoid.hidden = !self.CurrentOrder!.IsMonitoring()
        completion?()
    }
}




