//
//  Driver.Profile.Events.swift
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

import DTTableViewManager
import DTModelStorage
import AlamofireImage

extension DriverProfileScreen{

    
    func refresh(_ refreshControl: UIRefreshControl) {
        self.invalidate(nil)
        //self.tableView.reloadData()
        refreshControl.endRefreshing()
    }

        
    public func btnBack_Clicked() {
        
        SCONNECTING.TaxiManager?.setOrderStatusToOpen((SCONNECTING.TaxiManager?.currentOrder)!, completion: { (item) in
            SCONNECTING.TaxiManager?.currentOrder = item?.copy() as! TravelOrder
            SCONNECTING.TaxiManager?.invalidate(false, updateUI: false){
                
            }
        })
       
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
                
    }
    
    @IBAction public func btnLoadMore_Clicked(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        sender.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                        
                                        self.commentView.loadMoreComments()
                                        
                                    }) 
                                    
        })
        
    }
    
    
    @IBAction public func btnSendRequest_Clicked(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        sender.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                        
                                        if(self.driverBidding == nil && self.travelOrder != nil ){
                                            
                                            self.invalidateOrder({
                                              
                                                if(self.driverStatus!.IsReady){
                                                    
                                                        SCONNECTING.TaxiManager!.sendRequestToDriver(self.travelOrder!, driverId: self.driver!.id!, completion: { (item) in
                                                            self.travelOrder = item?.copy() as? TravelOrder
                                                            self.invalidateOrderControls(nil)
                                                            
                                                        })
                                                    
                                                }else{
                                                    
                                                        self.invalidateOrderControls(nil)
                                                
                                                }
                                                
                                            })
                                          
                                            
                                        }

                                        
                                    }) 
                                    
        })
        
    }
        
    @IBAction public func btnCancelRequest_Clicked(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        sender.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                        
                                        if(self.driverBidding == nil && self.travelOrder != nil ){
                                            
                                            SCONNECTING.TaxiManager!.cancelRequestToDriver(self.travelOrder!, driverId: self.driver!.id!, completion: { (item) in
                                                self.travelOrder = item?.copy() as? TravelOrder
                                                self.invalidateOrderControls(nil)

                                            })
                                            
                                        }
                                        
                                        
                                    }) 
                                    
        })
        
    }
    


    
    
    @IBAction public func btnAcceptBidding_Clicked(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        sender.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                        if( self.driverBidding != nil && self.travelOrder != nil ){
                                            
                                            SCONNECTING.TaxiManager!.acceptBidding(self.travelOrder!, driverId: self.driver!.id!, completion: { (item) in
                                                self.travelOrder = item?.copy() as? TravelOrder
                                                self.invalidateOrderControls(nil)

                                            })

                                        }
                                    }) 
                                    
        })
        
    }
    
    
    
    @IBAction public func btnCancelBidding_Clicked(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        sender.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                        if( self.driverBidding != nil && self.travelOrder != nil ){
                                            
                                            SCONNECTING.TaxiManager!.cancelBidding(self.travelOrder!, driverId: self.driver!.id!, completion: { (item) in
                                                self.travelOrder = item?.copy() as? TravelOrder
                                                self.invalidateOrderControls(nil)

                                            })
                                            
                                        }
                                    }) 
                                    
        })
        
    }


}
