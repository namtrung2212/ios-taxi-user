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
import DTTableViewManager
import DTModelStorage
import SClientModelControllers
import AlamofireImage
import RealmSwift


open class ChooseDriverView{
    
    var parent: TravelOrderScreen!
    var driverTable : ChooseDriverTable!
    
    var invalidateTimer: Timer = Timer()
    
    var pnlGrayOverlay: UIView!
    var lblPickupTime: UILabel!

    var lblDriverList: UILabel!
    var pnlDriverListArea: UIView!
    var  pnlOrderArea : UIView!
    
    var btnPickupIcon: UIButton!
    var lblPickupLocation: UILabel!
    var imgPickupLocationBG: UIImageView!
    
    var btnDropIcon: UIButton!
    var lblDropLocation: UILabel!
    var imgDropLocationBG: UIImageView!
    
    var btnCancelOrder: UIButton!
    
    var CurrentOrder: TravelOrder! {
        
        get {
            return self.parent.CurrentOrder
        }
    }
    
    
    public init(parent: TravelOrderScreen){
        
        self.parent = parent
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func showChooseDriverPanel(_ show: Bool,completionShow: (() -> ())?){
        
        if(show){
            
            let scrRect = UIScreen.main.bounds
            
            if(self.pnlDriverListArea.isHidden ){
                
                self.pnlDriverListArea.layer.position.y = scrRect.height + 300.0
                self.pnlOrderArea.layer.position.y = -300.0
                self.btnCancelOrder.layer.position.y = scrRect.height + 300.0 + self.pnlDriverListArea.layer.frame.height
                
                UIView.animate(withDuration: 0.5, delay: 0.0,
                                           usingSpringWithDamping: 0.0,
                                           initialSpringVelocity: 0.0,
                                           options: [],
                                           animations: {
                                            self.pnlDriverListArea.layer.position.y -= 30.0
                                            self.pnlOrderArea.layer.position.y -= 30.0
                                            self.btnCancelOrder.layer.position.y += 30.0

                                            self.pnlGrayOverlay.isHidden = true
                                            self.pnlOrderArea.isHidden = false
                                            self.btnCancelOrder.isHidden = false
                    }, completion: { finish in
                        
                        self.pnlDriverListArea.isHidden = false
                        self.pnlGrayOverlay.isHidden = false
                        self.pnlOrderArea.isHidden = false
                        self.btnCancelOrder.isHidden = false
                        
                        self.parent.view.bringSubview(toFront: self.pnlDriverListArea)
                        self.parent.view.bringSubview(toFront: self.pnlOrderArea)
                        self.parent.view.bringSubview(toFront: self.btnCancelOrder)
                        
                        self.parent.view.layoutIfNeeded()
                        completionShow?()
                })
                
            }else{
                completionShow?()
            }

        }else{
            if(self.pnlDriverListArea.isHidden == false){
                
                UIView.animate(withDuration: 1.0, delay: 0.0,
                                           usingSpringWithDamping: 0.0,
                                           initialSpringVelocity: 0.0,
                                           options: [],
                                           animations: {
                                            self.pnlDriverListArea.layer.position.y += 5.0
                                            self.pnlGrayOverlay.isHidden = false
                                            self.pnlOrderArea.isHidden = false
                                            self.btnCancelOrder.isHidden = false
                                            
                    }, completion: { finish in
                        
                        self.pnlDriverListArea.isHidden = true
                        self.pnlGrayOverlay.isHidden = true
                        self.pnlOrderArea.isHidden = true
                        self.btnCancelOrder.isHidden = true
                        self.parent.view.layoutIfNeeded()
                        completionShow?()
                })
                
            }else{
                completionShow?()
            }

        }
    }
    
    
    
    
    func startInvalidateTimer(){
        
        if(self.parent.isChoosingDriverPhase){
            self.invalidateTimer.invalidate()
            self.invalidateTimer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(ChooseDriverView.invalidateTimer_Tick), userInfo: nil, repeats: true)
        }
    }
    
    @objc func invalidateTimer_Tick(){
        if(self.parent.isChoosingDriverPhase){
            self.refreshData()
        }
    }
    

    func invalidate(_ isFirstTime: Bool,completion: (() -> ())?){
        
        let isShow : Bool = self.parent.isChoosingDriverPhase
        
        self.showChooseDriverPanel(isShow) {
            
            if( isShow){
                
                SCONNECTING.TaxiManager!.createLateOrderIfNeeded{
                    self.refreshData()
                    self.startInvalidateTimer()
                }
            }

            completion?()
        }
        
    }
    
    func refreshData(){
        
        self.lblPickupLocation.text = self.CurrentOrder!.OrderPickupPlace
        self.lblDropLocation.text =  self.CurrentOrder!.OrderDropPlace
        self.invalidatePickupTime()
        self.driverTable.refreshDriverList()
        
    }
    
    
    func invalidatePickupTime(){
        
        var date : Date?
      
        if(self.CurrentOrder!.OrderPickupTime != nil){
            
            date = self.CurrentOrder!.OrderPickupTime
            
        }else{
            
            date = self.CurrentOrder!.createdAt
            
        }
     
        var strPickupTime = ""
        if(date == nil || date!.isNow(5)){
            
            strPickupTime = "Khởi hành ngay bây giờ."
            
        }else{
            
            let seconds = date!.timeIntervalSince(Date())
            
            if (seconds > 0){
                
                let hours =  Int(seconds / 3600)
                let minutes =  Int(round((seconds.truncatingRemainder(dividingBy: 3600)) / 60))
                
                if( hours >= 1){
                    let strDate = date!.toString("HH:mm")
                    
                    if(date!.isToday()){
                        strPickupTime = "Khởi hành lúc " + strDate + " hôm nay"
                        
                    }else{
                        let strDate2 = date!.toString("dd/MM")
                        strPickupTime = "Khởi hành lúc " + strDate + " ngày " + strDate2
                    }
                    
                }else if( hours == 1){
                    strPickupTime =  NSString(format:"Khởi hành sau %d giờ, %d phút", hours, minutes ) as String
                }else{
                    strPickupTime =  NSString(format:"Khởi hành sau %d phút", minutes ) as String
                }
                
            }else{
              strPickupTime = "Đã hết hạn".uppercased()
            }
        }
        
        self.lblPickupTime.text = strPickupTime
    }

    @IBAction open func btnCancelOrder_Clicked(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        sender.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                        
                                        SCONNECTING.TaxiManager!.voidTrip(self.CurrentOrder, completion: nil)
                                         SCONNECTING.TaxiManager!.reset(true, completion: nil)
                                        

                                    }) 
                                    
        })
        
    }    
    
}


