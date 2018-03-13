//
//  TravelOrderScreen.swift
//  User.iPhone
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

public enum OrderPhase{
    case chooseLocation, customOrder, chooseDriver, monitoring, payment, rating
}

open class TravelOrderScreen: UIViewController {
    
    var orderPhase: OrderPhase = OrderPhase.chooseLocation
    
    var mapView: MapView!
    var mapLocation: MapLocation!
    var mapMarkerManager: MapMarkerManager!
    
    var placeSearcher: PlaceSearcher!

    var lblUserName: UILabel!
    open var isActive: Bool = false
    var invalidateTimer: Timer = Timer()
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MapView(parent: self)
        mapLocation = MapLocation(parent: self)
        mapMarkerManager = MapMarkerManager(parent: self)
        placeSearcher = PlaceSearcher(parent: self)
        
        self.initControls{
            self.initLayouts{
                
                    SCONNECTING.TaxiManager!.getOpenningOrder { (item) in
                        
                            if(item != nil){
                                SCONNECTING.TaxiManager!.reset(item!.copy() as! TravelOrder, updateUI: true){
                                }
                                
                            }
                            
                             SCONNECTING.LocationManager!.startUpdatingLocation()
                    }
               // self.startInvalidateTimer()
            }
        }
        
        

    }
    
    func initControls(_ completion: (() -> ())?){
        
        self.initMapControls{
            self.initSearchControl{
        
                self.initOrderCreationControls{
                    self.initOrderMonitoringControls{
                        self.initOrderPaymentControls{
                                self.initOtherControls(completion)
                        }
                    }
                }
            }
        }
        
        
    }
    
    func initLayouts(_ completion: (() -> ())?){
        
        self.initMapLayout{
            self.initOrderCreationLayout{
                self.initOrderMonitoringLayout{
                        self.initOrderPaymentLayout(completion)
                }
            }
        }
        
    }
    
    
    
    func getPhase() -> OrderPhase{
        
        if(CurrentOrder.IsNewOrder()){
            return self.orderPhase
        }
        
        if(CurrentOrder.Status == OrderStatus.DriverAccepted){
            return OrderPhase.monitoring
            
        }else if(CurrentOrder.IsFinishedNotYetPaid()){
            return OrderPhase.payment
            
        }else if(CurrentOrder.IsFinishedAndPaid()){
            return OrderPhase.rating
            
        }else if(CurrentOrder.Status == OrderStatus.Requested
            ||  CurrentOrder.Status == OrderStatus.BiddingAccepted
            ||  CurrentOrder.Status == OrderStatus.Open
            ||  CurrentOrder.Status == OrderStatus.DriverRejected){
            return OrderPhase.chooseDriver
            
        }
        
        return self.orderPhase
    }

    
    open func invalidateUI(_ isFirstTime: Bool, completion: (() -> ())?){
       
        let oldPhase = self.orderPhase
        self.orderPhase = getPhase()

        if(isFirstTime){
            
            self.invalidateOrderCreation(true) {
                self.invalidateOrderMonitoring(true) {
                    self.invalidateOrderPayment(true) {
                        self.invalidateMapView(true,completion: completion)
                    }
                }
            }
            
            return

        }
        
        if(oldPhase == OrderPhase.chooseLocation || oldPhase == OrderPhase.customOrder || oldPhase == OrderPhase.chooseDriver){
            
            if( self.orderPhase  == OrderPhase.chooseLocation ||  self.orderPhase  == OrderPhase.customOrder ||  self.orderPhase  == OrderPhase.chooseDriver){
                
                self.invalidateOrderCreation(oldPhase ==  self.orderPhase){
                    self.invalidateMapView(oldPhase ==  self.orderPhase,completion:  completion)
                }
                
                return
                
            }else  if( self.orderPhase  == OrderPhase.monitoring){
                
                self.invalidateOrderCreation(false){
                    self.invalidateOrderMonitoring(true){
                         self.invalidateMapView(false,completion:  completion)
                    }
                }
                
                return
            }
        }
        
        if(oldPhase == OrderPhase.monitoring){
            
            if ( self.orderPhase  == OrderPhase.monitoring){
                
                self.invalidateOrderMonitoring(false){
                    self.invalidateMapView(false, completion:  completion)
                }
                
                return
                
            }else if ( self.orderPhase  == OrderPhase.payment){
                
                self.invalidateOrderMonitoring(false){
                    self.invalidateOrderPayment(true){
                        self.invalidateMapView(false, completion:  completion)
                    }
                }
                
                return
            }
        }

        
        if(oldPhase == OrderPhase.payment){
            
            if ( self.orderPhase  == OrderPhase.payment){
                
                self.invalidateOrderPayment(false){
                    self.invalidateMapView(false, completion:  completion)
                }
                
                return
                
            }else if ( self.orderPhase  == OrderPhase.rating){
                
                self.invalidateOrderPayment(false){
                    self.invalidateMapView(false, completion:  completion)
                }
                
                return
                
            }
        }

       // self.hideNavigationBar(!(self.isChoosingLocationPhase))
        
    }
    
    
    func initOtherControls(_ completion: (() -> ())?){
        
        let btnHome = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(TravelOrderScreen.btnHome_Clicked))
        btnHome.setFAIcon(FAType.faBars, iconSize : 24)
        btnHome.setTitlePositionAdjustment(UIOffsetMake(0, -5), for: .default)
        
        // btnHome.imageInsets = UIEdgeInsetsMake(12, 0, -12, 0);
        
        self.navigationItem.leftBarButtonItem = btnHome
        
        self.lblUserName = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        self.lblUserName.font = self.lblUserName.font.withSize(15)
        self.lblUserName.text = SCONNECTING.UserManager!.CurrentUser!.Name
        self.lblUserName.textColor = UIColor.white
        self.lblUserName.textAlignment = NSTextAlignment.center
        self.lblUserName.backgroundColor = UIColor.gray
        
        self.lblUserName.layer.cornerRadius = 2.0
        self.lblUserName.layer.borderColor = UIColor.darkGray.cgColor
        self.lblUserName.layer.borderWidth = 0.5
        self.lblUserName.layer.shadowOffset = CGSize(width: 2, height: 3)
        self.lblUserName.layer.shadowOpacity = 0.5
        self.lblUserName.layer.shadowRadius = 3
        self.lblUserName.alpha = 0.6
        self.lblUserName.translatesAutoresizingMaskIntoConstraints = false
      /*
        self.view.addSubview(lblUserName)
        lblUserName.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor, constant: 0.0).active = true
        lblUserName.topAnchor.constraintEqualToAnchor(self.view.topAnchor, constant: 68.0).active = true
        lblUserName.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.9).active = true
        lblUserName.heightAnchor.constraintEqualToConstant(25).active = true
        */
        completion?()
    }
    
    
    func startInvalidateTimer(){
        
        self.invalidateTimer.invalidate()
        self.invalidateTimer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(TravelOrderScreen.invalidateTimer_Tick), userInfo: nil, repeats: true)
        
    }
    
    func invalidateTimer_Tick(){
        
        SCONNECTING.TaxiManager?.invalidate(true, updateUI: true, completion: {
            
        })
    }
    

}
