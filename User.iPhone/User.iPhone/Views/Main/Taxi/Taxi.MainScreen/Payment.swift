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

private var  PaymentKey1 : UInt8 = 163

extension TravelOrderScreen {
    
    public var paymentView: ChoosePaymentMethodView {
        get {return ExHelper.getter(self, key: &PaymentKey1){ return ChoosePaymentMethodView(parent: self) }}
        set { ExHelper.setter(self, key: &PaymentKey1, value: newValue) }
    }
    
    
    func initOrderPaymentControls(_ completion: (() -> ())?){
        
        paymentView.initControls(completion)
        
    }
    
    func initOrderPaymentLayout(_ completion: (() -> ())?){
        
        paymentView.initLayout(completion)
        
    }
    
    func invalidateOrderPayment(_ isFirstTime: Bool,completion: (() -> ())?){
        paymentView.invalidate(isFirstTime,completion:  completion)
    }
    
}

open class ChoosePaymentMethodView{
    
    var parent: TravelOrderScreen!
    var methodTable : ChoosePaymentMethodTable!
    
    var lblMethodList: UILabel!
    var pnlMethodListArea: UIView!
    
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
    
    func showChooseMethodPanel(_ show: Bool,completionShow: (() -> ())?){
        
        if(show){
            
                if(self.pnlMethodListArea.isHidden ){
                            self.pnlMethodListArea.isHidden = false
                            self.parent.view.bringSubview(toFront: self.pnlMethodListArea)
                            self.parent.view.layoutIfNeeded()
                }
                
                completionShow?()
            
        }else{
            
                if(self.pnlMethodListArea.isHidden == false){
                            self.pnlMethodListArea.isHidden = true
                            self.parent.view.layoutIfNeeded()
                }
            
                completionShow?()            
        }
    }
    
    
    
    func invalidate(_ isFirstTime: Bool,completion: (() -> ())?){
        
        if(self.CurrentOrder.IsFinishedNotYetPaid()){
            
            SCONNECTING.TaxiManager!.isShouldPayByCash(self.CurrentOrder!, completion: { (shouldCash) in
                
                let isShow : Bool =  !shouldCash

                self.showChooseMethodPanel(isShow) {
                    
                    if( isShow){
                            
                            self.methodTable.refreshMethodList()
                    }
                    
                    completion?()
                }

            })
            
        }else{
            
            self.showChooseMethodPanel(false) {
                        completion?()
            }

        }
        
    }

    
}


