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
import AlamofireImage
import SClientData
import SClientModel
import SClientModelControllers

import CoreLocation
import RealmSwift
import GoogleMaps

private var  MonitoringKey1 : UInt8 = 123

extension TravelOrderScreen {
    
    public var monitoringView: TravelMonitoringView {
        get {return ExHelper.getter(self, key: &MonitoringKey1){ return TravelMonitoringView(parent: self) }}
        set { ExHelper.setter(self, key: &MonitoringKey1, value: newValue) }
    }
    
    
    func initOrderMonitoringControls(_ completion: (() -> ())?){
        
        monitoringView.initControls(completion)
        
    }
    
    func initOrderMonitoringLayout(_ completion: (() -> ())?){
        
        monitoringView.initLayout(completion)
        
    }

    func invalidateOrderMonitoring(_ isFirstTime: Bool,completion: (() -> ())?){
        monitoringView.invalidate(isFirstTime,completion:  completion)
    }
    
}


open class TravelMonitoringView{
    
    var parent: TravelOrderScreen
    
    var CurrentOrder: TravelOrder! {
        
        get {
            return self.parent.CurrentOrder
        }
    }
    
    var driver: Driver?
    var driverStatus: DriverStatus?
    
    //------- Top Driver Profile Area -----------
    var isCollapsedProfile: Bool = true
    var pnlDriverProfileArea: UIView!
    var btnCollapseProfile: UIButton!
    
    var imgAvatar: UIImageView!
    var btnAvatar: UIButton!
    var redCircle : UIImageView!
    var lblMessageNo: UILabel!
    var lblDriverName: UILabel!
    var lblSeaterAndQuality: UILabel!
    var lblLastMessage: UILabel!

    var lblCarNo: UILabel!
    
    
    var imgStar1: UIImageView!
    var imgStar2: UIImageView!
    var imgStar3: UIImageView!
    var imgStar4: UIImageView!
    var imgStar5: UIImageView!
    var lblRateCount: UILabel!
    
    var btnChat: UIButton!
    var btnComment: UIButton!
    var btnHotline: UIButton!
    var btnDirectCall: UIButton!
    var btnSendPicture: UIButton!
    
    var chattingView: TravelChattingView!
    
    //------- Order Area -----------
    var isCollapsedOrder: Bool = false
    var pnlOrderArea: UIView!
    var btnCollapseOrder: UIButton!
    
    var lblStatus: UILabel!
    var lblCurrentPrice: UILabel!
    
    var btnPickupIcon: UIButton!
    var lblPickupLocation: UIButton!
    var imgPickupLocationBG: UIImageView!
    
    var btnDropIcon: UIButton!
    var lblDropLocation: UIButton!
    var imgDropLocationBG: UIImageView!
    
    var lblMoreInfo: UILabel!
    
    //------- Bottom Button Area -----------
    var pnlButtonArea: UIView!
    var btnVoid: UIButton!
    
    public init(parent: TravelOrderScreen){
        
        self.parent = parent
    }
    
    
    
    func invalidate(_ isFirstTime: Bool, completion: (() -> ())?){
        
        if(self.CurrentOrder.Driver != nil && ( self.driver == nil || self.driver!.id != self.CurrentOrder.Driver)){
                 ModelController<Driver>.getById(self.CurrentOrder.Driver!, obj: &self.driver)
                 ModelController<DriverStatus>.getOneByField("Driver", value: self.CurrentOrder.Driver!, isGetNow: true, clientHandler: nil, serverHandler: { (item) in
                   
                    self.driverStatus = item
                    self.invalidateUI(isFirstTime){
                        completion?()
                    }
                    
                 })
            
        }else{
            
            self.invalidateUI(isFirstTime){
                completion?()
            }
        
        }
        
        
        
    }
    
    
    func invalidateUI(_ isFirstTime: Bool, completion: (() -> ())?){
        
        self.invalidateOrderPanel(isFirstTime){
            
            self.invalidateDriverProfilePanel(isFirstTime){
                
                completion?()

            }
        }

    }
    
    
    
    }




