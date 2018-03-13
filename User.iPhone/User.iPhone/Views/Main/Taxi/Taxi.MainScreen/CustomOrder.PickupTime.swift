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


extension CustomOrderView : PopupDatePickerDelegate{
    
    
    func showChoosePickupTime(){
        
        let datePicker = PopupDatePicker.show()
        datePicker.delegate = self
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.setDate(self.CurrentOrder!.OrderPickupTime!)
        datePicker.setTitle("Chọn thời điểm xuất phát : ")
        self.parent.view.addSubview(datePicker)
        
        datePicker.widthAnchor.constraint(equalTo: self.parent.view.widthAnchor, constant: 0).isActive = true
        datePicker.heightAnchor.constraint(equalTo: self.parent.view.heightAnchor, constant: 0).isActive = true
        datePicker.centerXAnchor.constraint(equalTo: self.parent.view.centerXAnchor, constant: 0.0).isActive = true
        datePicker.centerYAnchor.constraint(equalTo: self.parent.view.centerYAnchor, constant: 0.0).isActive = true
        
        
    }
    
    func didChooseDateTime(_ sender: PopupDatePicker) {
        
        if(sender.isCancel == false){
            
            self.CurrentOrder!.OrderPickupTime = sender.dateValue
            
            self.invalidate(false,completion:  nil)
            
        }
        
    }
}
