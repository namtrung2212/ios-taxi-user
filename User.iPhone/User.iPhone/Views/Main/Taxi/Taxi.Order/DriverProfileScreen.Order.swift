//
//  DriverProfileScreen.Order.swift
//  User.iPhone
//
//  Created by Trung Dao on 8/10/16.
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

import DTTableViewManager
import DTModelStorage
import AlamofireImage
import SClientModelControllers

extension DriverProfileScreen {
    
    
    public func invalidateOrder(_ completion: (() -> ())?){
        
        
        ModelController<DriverStatus>.getOneByField("Driver", value: self.driver!.id!, isGetNow: true, clientHandler: nil, serverHandler: { (item) in
            
            if(item != nil && item!.id != nil ){
                self.driverStatus = item!.copy() as! DriverStatus
                
            }
            
            if(self.travelOrder != nil && self.travelOrder!.isNew() == false){
                
                ModelController<TravelOrder>.queryServerById((self.travelOrder?.id!)!, serverHandler: { (item) in
                    self.travelOrder = item?.copy() as? TravelOrder
                    self.invalidateOrderControls{
                        completion?()
                    }
                })
                
            }else{
                self.invalidateOrderControls{
                    completion?()
                }
            }
            
        })
        
    }
    
    func invalidateOrderControls(_ completion: (() -> ())?){
        
        if(self.travelOrder != nil){
            
            TravelOrderController.CalculateOrderPrice(self.driver!.id!, distance: self.travelOrder!.OrderDistance, currency: self.travelOrder!.Currency, serverHandler: { (result: Double?) in
                
                self.lblEstPrice.text = (result != nil) ? result!.toCurrency(nil, country:self.driverStatus!.Country!) : ""
                self.lblEstPrice.showControl =  !(result == nil || result! <= 0)
                
                self.view.layoutSubviews()
                
            })
        }
        
        self.lblEstPrice.showControl = (self.driverBidding != nil || (self.travelOrder != nil && self.travelOrder!.OrderDistance > 0) )
        
        self.btnSendRequest.showControl = (self.driverStatus!.IsReady &&  self.driverBidding == nil && self.travelOrder != nil && self.travelOrder!.IsPickupNow() && self.travelOrder!.Status == OrderStatus.Open)
        self.btnCancelRequest.showControl = (self.driverBidding == nil && self.travelOrder != nil && self.travelOrder!.Status == OrderStatus.Requested)
        
        self.btnAcceptBidding.showControl = (self.driverBidding != nil && self.travelOrder != nil && self.travelOrder!.Status == OrderStatus.Open)
        self.btnCancelBidding.showControl = (self.driverBidding != nil && self.travelOrder != nil && self.travelOrder!.Status == OrderStatus.BiddingAccepted)
        self.lblStatus.showControl = false
        
        self.navigationItem.leftBarButtonItem?.enabled = !(self.travelOrder != nil && (self.travelOrder?.Status == OrderStatus.Requested || self.travelOrder?.Status == OrderStatus.BiddingAccepted))
        
        self.invalidateOrderStatus(self.travelOrder?.Status)
        
        self.view.layoutSubviews()
        completion?()
    }
    
    func invalidateOrderStatus(_ status: String?){
        
        self.lblStatus.showControl = (status != nil) && (status != "")
       
        if(self.driverStatus!.IsReady == false){
            self.lblStatus.text = "Tài xế đang bận."
            self.lblStatus.showControl = true
            
        }else{
            
            self.lblStatus.showControl = (status != nil) && (status != "")
            
            if(status != nil){
                
                if(status == OrderStatus.Requested || status == OrderStatus.BiddingAccepted){
                    self.lblStatus.text = "Chờ phản hồi từ tài xế . . ."
                    
                }else if(status == OrderStatus.DriverAccepted){
                    self.lblStatus.text = "Tài xế sẵn sàng phục vụ. Vui lòng chờ."
                    
                }else if(status == OrderStatus.DriverRejected){
                    self.lblStatus.text = "Tài xế từ chối phục vụ."
                }else{
                    self.lblStatus.text = ""
                    self.lblStatus.showControl = false
                }
            }
        }
    }
    

}
