//
//  Main.CreateOrder.ChooseLocation.Events.swift
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



extension ChooseLocationView {

    
    
    @IBAction public func btnPickupHere_Clicked(_ sender: UIButton) {
        
        
        self.CurrentOrder.initOrderPickupLoc( self.parent.mapView.gmsMapView.camera.target)
        
        self.invalidateTravelPath(false){
            
        }
        
        self.parent.mapMarkerManager.loadCars(self.parent.mapView.gmsMapView.camera.target)
        
        GoogleMapUtil.getAddress(self.parent.mapView.gmsMapView.camera.target) { (address, country) in
            
            UIView.animate(withDuration: 0.1 ,
                                       animations: {
                                        self.btnPickupHere.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                },
                                       completion: { finish in
                                        UIView.animate(withDuration: 0.1, animations: {
                                            self.btnPickupHere.transform = CGAffineTransform.identity
                                        })
                                        UIView.animate(withDuration: 0.25, animations: {
                                            self.parent.placeSearcher.searchController.searchBar.placeholder = address
                                            self.CurrentOrder.initOrderPickupPlace(address, country: country)
                                            
                                            self.parent.orderPhase = OrderPhase.chooseLocation
                                            self.parent.invalidateUI(false, completion: nil)
                                        }) 
                                        
                }
            )

        }
                
    }
    
    @IBAction public func btnDropHere_Clicked(_ sender: UIButton) {
        
        self.CurrentOrder.initOrderDropLoc(self.parent.mapView.gmsMapView.camera.target)
        
        self.invalidateTravelPath(false){
            
        }
        
        GoogleMapUtil.getAddress(self.parent.mapView.gmsMapView.camera.target) { (address, country) in
            
                UIView.animate(withDuration: 0.1 ,
                                           animations: {
                                            self.btnDropHere.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                    },
                                           completion: { finish in
                                            UIView.animate(withDuration: 0.1, animations: {
                                                self.btnDropHere.transform = CGAffineTransform.identity
                                            })
                                            UIView.animate(withDuration: 0.25, animations: {
                                                self.parent.placeSearcher.searchController.searchBar.placeholder = address
                                                self.CurrentOrder.initOrderDropPlace(address)
                                                
                                                self.parent.orderPhase = OrderPhase.chooseLocation

                                                self.parent.invalidateUI(false, completion: nil)
                                            }) 
                                            
                    }
                )
                
        }
        
    }
    
    @IBAction public func btnPickupIcon_Clicked(_ sender: UIButton) {
        if( self.CurrentOrder?.OrderPickupLoc != nil){
        
            self.parent.mapView.gmsMapView.animateToLocation(self.CurrentOrder!.OrderPickupLoc!.coordinate())
        }
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    self.btnPickupIcon.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        self.btnPickupIcon.transform = CGAffineTransform.identity
                                    })
            }
        )
        
    }
    
    @IBAction public func btnDropIcon_Clicked(_ sender: UIButton) {
        
        if( self.CurrentOrder?.OrderDropLoc != nil){
            self.parent.mapView.gmsMapView.animateToLocation(self.CurrentOrder!.OrderDropLoc!.coordinate())
        }
        
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    self.btnDropIcon.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        self.btnDropIcon.transform = CGAffineTransform.identity
                                    })
            }
        )
        
    }
    
    @IBAction public func btnPickupCancel_Clicked(_ sender: UIButton) {
        
        if( self.CurrentOrder?.OrderPickupLoc != nil){
            
            self.CurrentOrder.clearOrderPickupLoc()
            
            UIView.animate(withDuration: 0.25, animations: {
                self.btnPickupIcon.setTitle("", for: UIControlState())
                
                self.invalidateTravelPath(false){
                    
                }
                self.invalidate(false,completion:  nil)
                self.parent.mapView.invalidate(false,completion:  nil)
                
            }) 
            
        }
    }
    
    @IBAction public func btnDropCancel_Clicked(_ sender: UIButton) {
        if( self.CurrentOrder?.OrderDropLoc != nil){
            
            self.CurrentOrder.clearOrderDropLoc()
            
            self.invalidateTravelPath(false){
                
            }
            
            UIView.animate(withDuration: 0.25, animations: {
                self.btnDropIcon.setTitle("", for: UIControlState())
                self.invalidate(false,completion:  nil)
                self.parent.mapView.invalidate(false,completion:  nil)

                
            }) 
            
        }
    }
    
    @IBAction public func btnQuickOrder_Clicked(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    self.btnQuickOrder.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        self.btnQuickOrder.transform = CGAffineTransform.identity
                                    })
                                    
                                    self.parent.orderPhase = OrderPhase.chooseDriver
                                    SCONNECTING.TaxiManager!.invalidate(false, updateUI: true){
                                     
                                            
                                    }
        })
        
        
        
    }
    
    @IBAction public func btnCustomOrder_Clicked(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    self.btnCustomOrder.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        self.btnCustomOrder.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {

                                        self.CurrentOrder.OrderPickupTime = Date()
                                        
                                        self.parent.orderPhase = OrderPhase.customOrder
                                        SCONNECTING.TaxiManager!.invalidate(false, updateUI: true){
                                            
                                        }

                                        
                                    }) 
                                    
        })
        
        
        
    }
    


}
