
 //
//  Taxi.Order.ChooseDriver.DriverProfile.swift
//  User.iPhone
//
//  Created by Trung Dao on 5/26/16.
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
import SClientModelControllers


private var  DriverProfileKey1 : UInt8 = 0
private var  DriverProfileKey2: UInt8 = 0


open class DriverProfileScreen: UIViewController, UIScrollViewDelegate {
    
    open static var instance: DriverProfileScreen?
    
    open var isActive: Bool = false
    
    open var travelOrder: TravelOrder?
    open var driverBidding: DriverBidding?
    open var driver: Driver?
    open var driverStatus: DriverStatus?
    
    open var profileView: ProfileInfoView!
    open var commentView: CommentView!
    
    var btnBack: UIBarButtonItem!
    var scrollView: UIScrollView!
    var containerView: UIView!
    
    var btnLoadMore: UIButton!
    
    var lblEstPrice: UILabel!
    var lblStatus: UILabel!
    
    var btnSendRequest: UIButton!
    var btnCancelRequest: UIButton!
    var btnAcceptBidding: UIButton!
    var btnCancelBidding: UIButton!
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        isActive = true
    }

    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        isActive = false
    }
    
    init(_driverId: String){
        
        super.init(nibName: nil, bundle: nil)

        ModelController<Driver>.getById(_driverId, clientHandler: { (item) in
            if(item != nil && self.profileView == nil){
                self.initProfile(item!)
            }
            
        }) { (item) in
            
            if(item != nil && self.profileView == nil){
                self.initProfile(item!)
            }
            

        }
        
    }

    func initProfile(_ _driver: Driver){
        
        self.driver = _driver
        
        self.profileView = ProfileInfoView(parent: self)
        self.commentView = CommentView(parent: self)
        
        self.initControls{
            self.initLayout{
                self.invalidate()
            }
        }
        
    }
    
    
    func setCurrentOrder(_ order: TravelOrder?,bidding: DriverBidding?){
        self.travelOrder = order
        self.driverBidding = bidding
        self.invalidate()
    }

    func invalidate(){
        
        ModelController<DriverStatus>.getOneByField("Driver", value: self.driver!.id!, isGetNow: false,
        clientHandler: { (item) in
            
                    if(item != nil && item!.id != nil ){
                        self.driverStatus = item!
                    }
                    self.invalidate(nil)
            
        }) { (item) in
            
                    if(item != nil && item!.id != nil ){
                        self.driverStatus = item!
                    }
            
                    self.invalidate(nil)
            
        }
    }
    
    func invalidate(_ completion: (() -> ())?){
        
        self.navigationController?.isNavigationBarHidden =  false

        self.profileView.invalidate()
        
        self.commentView.invalidate()
        
        self.invalidateOrder() {
            completion?()
        }

    }
    
}
