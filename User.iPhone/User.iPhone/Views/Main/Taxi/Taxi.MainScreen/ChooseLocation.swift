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
import SClientData
import SClientModel
import CoreLocation
import RealmSwift
import GoogleMaps


open class ChooseLocationView{
    
    var parent: TravelOrderScreen
    
    var CurrentOrder: TravelOrder! {
        
        get {
            return self.parent.CurrentOrder
        }
    }
    
    var centerLocation: UIImageView!
    
    open var pnlOrderArea: UIView!
    
    var btnPickupIcon: UIButton!
    var lblPickupLocation: UIButton!
    var imgPickupLocationBG: UIImageView!
    var btnPickupCancel: UIButton!
    
    var btnDropIcon: UIButton!
    var lblDropLocation: UIButton!
    var imgDropLocationBG: UIImageView!
    var btnDropCancel: UIButton!
    
    var btnPathStatisticIcon: UIButton!
    var lblPathStatistic: UILabel!
    var imgPathStatisticBG: UIImageView!
    
    var pnlButtonArea: UIView!
    var btnQuickOrder: UIButton!
    var btnCustomOrder: UIButton!
    
    var btnPickupHere: UIButton!
    var btnDropHere: UIButton!
        
    var heightAnchorButtonArea : NSLayoutConstraint?
    var bottomAnchorOrderArea : NSLayoutConstraint?
    var topAnchorOrderArea : NSLayoutConstraint?
    
    public init(parent: TravelOrderScreen){
        
        self.parent = parent
    }
    
    
    
    func showOrderPanel(_ show: Bool,completion: (() -> ())?){
        
        if(show){
            
            if(self.pnlOrderArea.hidden && CurrentOrder != nil && (( CurrentOrder!.OrderPickupLoc != nil ) ||  ( CurrentOrder!.OrderDropLoc != nil ))){
                UIView.animate(withDuration: 1.0, delay: 0.0,
                                           usingSpringWithDamping: 0.0,
                                           initialSpringVelocity: 0.0,
                                           options: [],
                                           animations: {
                                            self.pnlOrderArea.layer.position.y -= 30.0
                                            self.pnlOrderArea.isHidden = false
                                            self.pnlButtonArea.showControl = self.parent.isChoosingLocationPhase && self.CurrentOrder!.OrderPickupLoc != nil
                    }, completion: { finish in
                        
                        self.pnlOrderArea.isHidden = false
                        self.pnlButtonArea.showControl = self.parent.isChoosingLocationPhase && self.CurrentOrder!.OrderPickupLoc != nil
                        self.parent.view.layoutIfNeeded()
                         completion?()
                        
                })
            }else{
                   completion?()
            }
        }else{
            if(self.pnlOrderArea.isHidden == false){
                
                UIView.animate(withDuration: 1.0, delay: 0.0,
                                           usingSpringWithDamping: 0.0,
                                           initialSpringVelocity: 0.0,
                                           options: [],
                                           animations: {
                                            self.pnlOrderArea.layer.position.y += 5.0
                                            self.pnlButtonArea.showControl = self.parent.isChoosingLocationPhase && self.CurrentOrder!.OrderPickupLoc != nil
                                            self.pnlButtonArea.isHidden = false
                                            
                    }, completion: { finish in
                        
                        self.pnlOrderArea.isHidden = true
                         self.pnlButtonArea.showControl = self.parent.isChoosingLocationPhase && self.CurrentOrder!.OrderPickupLoc != nil
                        self.parent.view.layoutIfNeeded()
                         completion?()
                })
                
            }else{
                completion?()
            }

        }
    }

    func invalidate(_ isFirstTime: Bool, completion: (() -> ())?){
        
        self.centerLocation.hidden =  !(self.parent.isChoosingLocationPhase && self.CurrentOrder.IsNewOrder() &&  self.CurrentOrder.IsChoosingLocation())
        self.btnPickupHere.hidden = !(self.parent.isChoosingLocationPhase && self.CurrentOrder.IsNewOrder() && self.CurrentOrder.IsChoosingPickupLocation())
        self.btnDropHere.hidden = !(self.parent.isChoosingLocationPhase && self.CurrentOrder.IsNewOrder() && self.CurrentOrder.IsChoosingDropLocation())
                
        self.parent.placeSearcher.showSearchBar(self.parent.isChoosingLocationPhase)
        
        self.invalidateOrderPanel(isFirstTime) {
            completion?()
        }

    }
        
    func invalidateOrderPanel(_ isFirstTime: Bool, completion: (() -> ())?){
        
        let isShow : Bool = self.CurrentOrder.IsNewOrder()  &&  ( (self.parent.isChoosingLocationPhase && (self.CurrentOrder.OrderPickupLoc != nil || self.CurrentOrder.OrderDropLoc != nil ) )  || self.parent.isCustomOrderPhase )
                
        if(isShow){
            
                self.pnlOrderArea.isUserInteractionEnabled = self.parent.isChoosingLocationPhase
                self.parent.view.bringSubview(toFront: self.pnlOrderArea)
            
                self.bottomAnchorOrderArea?.isActive = self.parent.isChoosingLocationPhase
                self.topAnchorOrderArea?.isActive = self.parent.isCustomOrderPhase
                
                self.btnPickupCancel.hidden = self.parent.isCustomOrderPhase || (self.CurrentOrder.OrderPickupLoc == nil)
                self.btnDropCancel.hidden =  self.parent.isCustomOrderPhase || (self.CurrentOrder.OrderDropLoc == nil)
                
                self.lblPickupLocation.setTitle((self.CurrentOrder.OrderPickupLoc != nil ) ?  self.CurrentOrder.OrderPickupPlace : "", for: .Normal)
                self.lblDropLocation.setTitle((self.CurrentOrder.OrderDropLoc != nil ) ?  self.CurrentOrder.OrderDropPlace : "", for: .Normal)
                
                self.lblPathStatistic.hidden = ( self.CurrentOrder.OrderDropLoc == nil ) || ( self.CurrentOrder.OrderPickupLoc == nil )
                if(self.lblPathStatistic.isHidden){
                    self.lblPathStatistic.text = ""
                }
            
                self.pnlButtonArea.showControl = self.parent.isChoosingLocationPhase && self.CurrentOrder!.OrderPickupLoc != nil
            
        }
        
        self.showOrderPanel(isShow) {
            completion?()
        }

    }
    
    
    
    
    func invalidateTravelPath(_ isFirstTime: Bool, completion: (() -> ())?){
        
        if( self.CurrentOrder == nil ){
                return
        }
        
        UIView.animate(withDuration: 1, animations: {
            self.lblPathStatistic.text = ""
            self.lblPathStatistic.isHidden = true
            
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
                
                if((self.CurrentOrder!.OrderPickupCountry) != nil){
                    
                        ModelController<TaxiAveragePrice>.getByField("Country", value: self.CurrentOrder!.OrderPickupCountry!, isGetNow: false,
                             clientHandler: { (items) in
                                
                                        var strPrice : String? = ""
                                        if(items != nil && items?.count > 0){
                                            let price : Double = round((items![0].AverageUnitPrice * self.CurrentOrder!.OrderDistance/1000)/1000)*1000
                                            strPrice = price.toCurrency(nil, country:self.CurrentOrder!.OrderPickupCountry!)
                                        }
                                
                                        var strInfo =  strDistance + " - " + strDuration
                                        if(strPrice != nil && strPrice != ""){
                                            strInfo = strInfo  + " - " + strPrice!
                                        }
                                        self.lblPathStatistic.text = strInfo
                                        self.lblPathStatistic.hidden = false
                                
                                
                            }, serverHandler: { (items) in
                                
                                
                        })
                
                }
                
            }
            
            completion?()
        }) 
    }

}
