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


open class CustomOrderView {
    
    var parent: TravelOrderScreen
    
    var pnlCustomOrderArea: UIView!
    var pnlGrayOverlay: UIView!
    
    var pnlButtonArea: UIView!
    var btnCancelOrder: UIButton!
    var btnCreateOrder: UIButton!
    
    var btnOneWay: UIButton!
    var btnReturn: UIButton!
    
    var btnAllSeat: UIButton!
    var btn4Seat: UIButton!
    var btn7Seat: UIButton!
    
    var btnPopular: UIButton!
    var btnLuxury: UIButton!
    var btnEconomic: UIButton!
    
    var btnImmediately: UIButton!
    var btnLater: UIButton!
    
    var lblPickupTimeValue: UIButton!
    var btnPickupTime: UIButton!
    var imgPickupTimeBG: UIImageView!
    var lblPickupTime: UILabel!
    

    var icoClock: UIImageView!
    var icoSeat: UIImageView!
    var icoQuality: UIImageView!
    
    var lblClock: UILabel!
    var lblSeat: UILabel!
    var lblQuality: UILabel!
    
    var line1: CAShapeLayer!
    var line2: CAShapeLayer!
    var line3: CAShapeLayer!
    var line4: CAShapeLayer!
    
    
    var CurrentOrder: TravelOrder! {
        
        get {
            return  self.parent.CurrentOrder
        }
    }
        

    
    public init(parent: TravelOrderScreen){
        
        self.parent = parent
    }
           
    
    func showCustomOrderPanel(_ show: Bool,completion: (() -> ())?){
        
        if(show){
            
            if(self.pnlCustomOrderArea.isHidden ){
                UIView.animate(withDuration: 1.0, delay: 0.0,
                                           usingSpringWithDamping: 0.0,
                                           initialSpringVelocity: 0.0,
                                           options: [],
                                           animations: {
                                            self.pnlCustomOrderArea.layer.position.y -= 30.0
                                            self.pnlGrayOverlay.isHidden = false
                                            self.pnlButtonArea.isHidden = false
                    }, completion: { finish in
                        
                        self.pnlCustomOrderArea.isHidden = false
                        self.pnlGrayOverlay.isHidden = false
                        self.pnlButtonArea.isHidden = false
                        self.parent.view.layoutIfNeeded()
                          completion?()
                })
                
            }else{
                completion?()
            }

        }else{
            if(self.pnlCustomOrderArea.isHidden == false){
                
                UIView.animate(withDuration: 1.0, delay: 0.0,
                                           usingSpringWithDamping: 0.0,
                                           initialSpringVelocity: 0.0,
                                           options: [],
                                           animations: {
                                            self.pnlCustomOrderArea.layer.position.y += 5.0
                                            self.pnlGrayOverlay.isHidden = false
                                            self.pnlButtonArea.isHidden = false
                                            
                    }, completion: { finish in
                        
                        self.pnlCustomOrderArea.isHidden = true
                        self.pnlGrayOverlay.isHidden = true
                        self.pnlButtonArea.isHidden = true
                        self.parent.view.layoutIfNeeded()
                          completion?()
                })
                
            }else{
                completion?()
            }

        }
    }
    

    
    func invalidate(_ isFirstTime: Bool,completion: (() -> ())?){
        
        let isShow : Bool = self.CurrentOrder.IsChoosingPickupLocation() == false &&  self.parent.isCustomOrderPhase
        
        if( isShow){
            
                self.parent.view.bringSubview(toFront: self.pnlCustomOrderArea)
                self.parent.view.bringSubview(toFront: self.pnlButtonArea)
                
                btnOneWay.selected = self.CurrentOrder!.OrderOneway
                btnReturn.selected = !self.CurrentOrder!.OrderOneway
                btnPopular.selected = (self.CurrentOrder!.OrderQuality == "Popular")
                btnEconomic.selected = (self.CurrentOrder!.OrderQuality == "Economic")
                btnLuxury.selected = (self.CurrentOrder!.OrderQuality == "Luxury")
                btnAllSeat.selected = (self.CurrentOrder!.OrderSeater == 0)
                btn4Seat.selected = (self.CurrentOrder!.OrderSeater == 4)
                btn7Seat.selected = (self.CurrentOrder!.OrderSeater == 7)
                
                btnImmediately.selected = (self.CurrentOrder!.OrderPickupTime == nil) || (self.CurrentOrder!.OrderPickupTime!.isNow(5))
                btnLater.isSelected = !btnImmediately.isSelected

                redrawButton(btnOneWay)
                redrawButton(btnReturn)
                redrawButton(btnAllSeat)
                redrawButton(btn4Seat)
                redrawButton(btn7Seat)
                redrawButton(btnPopular)
                redrawButton(btnLuxury)
                redrawButton(btnEconomic)
                redrawButton(btnImmediately)
                redrawButton(btnLater)
                
                self.lblPickupTime.isHidden = self.btnImmediately.isSelected
                self.lblPickupTimeValue.isHidden = self.btnImmediately.isSelected
                self.imgPickupTimeBG.isHidden = self.btnImmediately.isSelected
                self.btnPickupTime.isHidden = self.btnImmediately.isSelected
                
                
                var strPickupTime = ""
                if((self.CurrentOrder!.OrderPickupTime == nil) || self.CurrentOrder!.OrderPickupTime!.isNow(5)){
                    strPickupTime = "ngay bây giờ."
                    
                }else{
                    
                    let seconds = self.CurrentOrder!.OrderPickupTime!.timeIntervalSinceDate(Date())
                    
                    if ((seconds > 0) || abs(seconds)<=60){
                        
                        let hours =  Int(seconds / 3600)
                        let minutes =  Int(round((seconds % 3600) / 60))
                        
                      
                        if( hours == 1){
                            strPickupTime =  NSString(format:"sau %d giờ, %d phút", hours, minutes ) as String
                      
                        }else if(hours > 1){
                            let strDate = self.CurrentOrder!.OrderPickupTime!.toString("HH:mm")
                            
                            if(self.CurrentOrder!.OrderPickupTime!.isToday()){
                                strPickupTime = strDate + " hôm nay"
                                
                            }else{
                                let strDate2 = self.CurrentOrder!.OrderPickupTime!.toString("dd/MM/yyyy")
                                strPickupTime = strDate + " - " + strDate2
                            }

                        }else{
                            strPickupTime =  NSString(format:"sau %d phút", minutes ) as String
                            
                        }
                    }

                }
                
                
                self.lblPickupTimeValue.setTitle(strPickupTime, for: UIControlState())
        }
        
        
        self.showCustomOrderPanel(isShow) {
            completion?()
        }

        
    }
    
    func redrawButton(_ button: UIButton){
        if(button.isSelected){
            button.layer.shadowOffset = CGSize(width: 1, height: 1)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 1
        }else{
            button.layer.shadowOpacity = 0
        }
    }
    
}
