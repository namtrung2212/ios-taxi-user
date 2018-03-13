//
//  MapMarker.swift
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

private var  OrderKey1 : UInt8 = 1
private var  OrderKey2 : UInt8 = 2
private var  OrderKey3 : UInt8 = 3
private var  OrderKey4 : UInt8 = 4
private var  OrderKey5 : UInt8 = 5
private var  OrderKey6 : UInt8 = 6
private var  OrderKey7 : UInt8 = 7
private var  OrderKey8 : UInt8 = 8





extension TravelOrderScreen {
        

    public var chooseLocationView: ChooseLocationView {
        get {return ExHelper.getter(self, key: &OrderKey2){ return ChooseLocationView(parent: self) }}
        set { ExHelper.setter(self, key: &OrderKey2, value: newValue) }
    }
    
    
    public var customOrderView: CustomOrderView {
        get {return ExHelper.getter(self, key: &OrderKey3){ return CustomOrderView(parent: self) }}
        set { ExHelper.setter(self, key: &OrderKey3, value: newValue) }
    }
    
    public var chooseDriverView: ChooseDriverView {
        get {return ExHelper.getter(self, key: &OrderKey4){ return ChooseDriverView(parent: self) }}
        set { ExHelper.setter(self, key: &OrderKey4, value: newValue) }
    }
    
    func initOrderCreationControls(_ completion: (() -> ())?){
        
        chooseLocationView.initControls{
            self.customOrderView.initControls{
                    self.chooseDriverView.initControls(completion)
            }
        }

    }
    
    func initOrderCreationLayout(_ completion: (() -> ())?){
        
        chooseLocationView.initLayout{
            self.customOrderView.initLayout{
                    self.chooseDriverView.initLayout(completion)
            }
        }
        
    }
    
    
    func invalidateOrderCreation(_ isFirstTime: Bool, completion: (() -> ())?){
        
        chooseLocationView.invalidate(isFirstTime){
            self.customOrderView.invalidate(isFirstTime) {
                self.chooseDriverView.invalidate(isFirstTime,completion : completion)
            }
        }

        
    }

    
}
