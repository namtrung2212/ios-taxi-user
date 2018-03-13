//
//  TripMateViewController.swift
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

open class TripMateViewController: UIViewController {
    
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.initControls{
            
        }
    }
    
    
    func initControls(_ completion: (() -> ())?){
        
        let btnHome = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(TripMateViewController.btnHome_Clicked))
        btnHome.setFAIcon(FAType.faBars, iconSize : 24)
        btnHome.setTitlePositionAdjustment(UIOffsetMake(0, -5), for: .default)
        
        // btnHome.imageInsets = UIEdgeInsetsMake(12, 0, -12, 0);
        
        self.navigationItem.leftBarButtonItem = btnHome
        self.navigationItem.title = "NHÓM ĐI CHUNG"
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController!.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
        
        completion?()
        
    }
    
    
    open func btnHome_Clicked() {
        
        AppDelegate.mainWindow?.leftViewCtrl.invalidate()
        AppDelegate.mainWindow?.mainViewCtrl.slideMenuController()?.openLeft()
        
        
    }
    
}
