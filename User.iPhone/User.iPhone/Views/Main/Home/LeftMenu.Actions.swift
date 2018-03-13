//
//  File.swift
//  User.iPhone
//
//  Created by Trung Dao on 5/13/16.
//  Copyright © 2016 SCONNECTING. All rights reserved.
//

import Foundation
//
//  HomeViewController.swift
//  User.iPhone
//
//  Created by Trung Dao on 4/13/16.
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

extension LeftMenuViewController {
    
    func menuItem_Clicked(_ item: MenuItemObject){
        
        if(item.Section == 0 ){
            
            AppDelegate.mainWindow?.mainViewCtrl.selectedIndex = 0
            
            if(item.Index == 0){
                
                SCONNECTING.TaxiManager!.reset(true, completion: nil)
                
            }else if(item.Index == 1){
                
                let instance  =  NotYetPickupScreen()
                
                AppDelegate.mainWindow?.mainViewCtrl.taxiViewCtrl.hideNavigationBar(false)
                AppDelegate.mainWindow?.mainViewCtrl.taxiViewCtrl.navigationController?.pushViewController(instance, animated:true)
                
            }else if(item.Index == 2){
                
                let instance  =  OnTheWayScreen()
                
                AppDelegate.mainWindow?.mainViewCtrl.taxiViewCtrl.hideNavigationBar(false)
                AppDelegate.mainWindow?.mainViewCtrl.taxiViewCtrl.navigationController?.pushViewController(instance, animated:true)
                
                
            }else if(item.Index == 3){
                
                let instance  =  NotYetPaidScreen()
                
                AppDelegate.mainWindow?.mainViewCtrl.taxiViewCtrl.hideNavigationBar(false)
                AppDelegate.mainWindow?.mainViewCtrl.taxiViewCtrl.navigationController?.pushViewController(instance, animated:true)
                
                
            }else if(item.Index == 4){
                
                let instance  =  TravelHistoryScreen()
                
                AppDelegate.mainWindow?.mainViewCtrl.taxiViewCtrl.hideNavigationBar(false)
                AppDelegate.mainWindow?.mainViewCtrl.taxiViewCtrl.navigationController?.pushViewController(instance, animated:true)
                
                
            }
            
        }else if(item.Section == 1 ){
            
            AppDelegate.mainWindow?.mainViewCtrl.selectedIndex = 1
        }
        
        AppDelegate.mainWindow?.mainViewCtrl.slideMenuController()?.closeLeft()
    }
    
    
    
    
}
