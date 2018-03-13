//
//  Main.CreateOrder.CustomOrder.Events.swift
//  User.iPhone
//
//  Created by Trung Dao on 6/3/16.
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
import SClientModelControllers

extension TravelMonitoringView {
    
    
    

    
    @IBAction public func btnCollapseProfile_Clicked(_ sender: UIButton) {
        
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        sender.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                        
                                        self.parent.view.bringSubview(toFront: self.pnlDriverProfileArea)
                                        self.parent.view.bringSubview(toFront: self.btnAvatar)
                                        self.parent.view.bringSubview(toFront: self.redCircle)
                                        self.parent.view.bringSubview(toFront: self.lblMessageNo)

                                        
                                        self.isCollapsedProfile = !self.isCollapsedProfile
                                        self.invalidateProfilePanelControls(false){
                                            
                                            if(self.isCollapsedProfile){
                                                self.chattingView!.setReadAll()
                                            }

                                        }                                        
                                        
                                        if( !self.isCollapsedProfile){
                                            
                                            self.isCollapsedOrder = true
                                            self.invalidateOrderPanelControls(false){
                                                
                                            }
                                            
                                        }
                                    }) 
                                    
        })
        
    }

    
    
    
    @IBAction public func btnCollapseOrder_Clicked(_ sender: UIButton) {
        
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        sender.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                        
                                        self.isCollapsedOrder = !self.isCollapsedOrder
                                        
                                        self.invalidateOrderPanelControls(false,completion: nil)
                                        
                                                                                
                                        if( !self.isCollapsedOrder){
                                            
                                            self.isCollapsedProfile = true
                                            self.invalidateProfilePanelControls(false){
                                                
                                            }
                                        }

                                    }) 
                                    
        })
        
    }

    
    @IBAction public func btnAvatar_Clicked(_ sender: UIButton) {
        
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        sender.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                        
                                        if(DriverProfileScreen.instance == nil ||   DriverProfileScreen.instance!.driver == nil ||  DriverProfileScreen.instance!.driver!.id != self.CurrentOrder.Driver! ){
                                            DriverProfileScreen.instance  =  DriverProfileScreen(_driverId: self.CurrentOrder.Driver!)
                                        }
                                        self.parent.hideNavigationBar(false)
                                        self.parent.navigationController?.pushViewController(DriverProfileScreen.instance!, animated:true)
                                        
                                        
                                    }) 
                                    
        })
        
    }

    

    @IBAction public func btnVoid_Clicked(_ sender: UIButton) {
        
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        sender.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                               
                                        let alert = UIAlertController(title: "Bạn muốn hủy hành trình ?  ", message: "Việc hủy chuyến thường xuyên sẽ được ghi nhận vào hồ sơ của bạn. ", preferredStyle: UIAlertControllerStyle.alert)
                                        
                                        alert.addAction(UIAlertAction(title: "Hủy", style: .Default, handler: { (action: UIAlertAction!) in
                                            
                                            SCONNECTING.TaxiManager!.voidTrip(self.CurrentOrder, completion: { (item) in
                                             
                                                if(item!.IsFinishedNotYetPaid()){
                                                    SCONNECTING.TaxiManager!.reset(item!, updateUI: true, completion: nil)
                                                    
                                                }else if(item!.Status == OrderStatus.VoidedBfPickupByUser){                                                    
                                                    SCONNECTING.TaxiManager!.resetWhenVoidedBeforePickup(item!, completion: nil)
                                                }
                                                
                                            })
                                            
                                            
                                        }))
                                        
                                        alert.addAction(UIAlertAction(title: "Không", style: .cancel, handler: { (action: UIAlertAction!) in
                                            
                                            
                                        }))
                                        
                                        AppDelegate.mainWindow?.mainViewCtrl.present(alert, animated: true, completion: nil)
                                        

                                        
                                    }) 
                                    
        })
        
    }
    
    @IBAction public func btnPickupIcon_Clicked(_ sender: UIButton) {
      
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    self.btnPickupIcon.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        self.btnPickupIcon.transform = CGAffineTransform.identity
                                        
                                        if( self.CurrentOrder?.ActPickupLoc != nil){
                                            
                                            self.parent.mapView.gmsMapView.animateToLocation(self.CurrentOrder!.ActPickupLoc!.coordinate())
                                            
                                        }else     if( self.CurrentOrder?.OrderPickupLoc != nil){
                                            
                                            self.parent.mapView.gmsMapView.animateToLocation(self.CurrentOrder!.OrderPickupLoc!.coordinate())
                                        }
                                    })
            }
        )
        
    }
    
    @IBAction public func btnDropIcon_Clicked(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    self.btnDropIcon.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        self.btnDropIcon.transform = CGAffineTransform.identity
                                        
                                        if( self.CurrentOrder?.ActDropLoc != nil){
                                            self.parent.mapView.gmsMapView.animateToLocation(self.CurrentOrder!.ActDropLoc!.coordinate())
                                      
                                        }else
                                            if( self.CurrentOrder?.OrderDropLoc != nil){
                                                self.parent.mapView.gmsMapView.animateToLocation(self.CurrentOrder!.OrderDropLoc!.coordinate())
                                        }
                                    })
            }
        )
        
    }
    
}
