//
//  ChooseDriver.UI.swift
//  User.iPhone
//
//  Created by Trung Dao on 6/23/16.
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



extension ChoosePaymentMethodView{
    
    func initControls(_ completion: (() -> ())?){
        
        let scrRect = UIScreen.main.bounds
        
        // pnlMethodListArea
        
        pnlMethodListArea = UIView()
        pnlMethodListArea.backgroundColor = UIColor(red: CGFloat(125/255.0), green: CGFloat(187/255.0), blue: CGFloat(233/255.0), alpha: 1.0)
        pnlMethodListArea.layer.cornerRadius = 6.0
        pnlMethodListArea.layer.borderColor = UIColor.gray.cgColor
        pnlMethodListArea.layer.borderWidth = 0.5
        pnlMethodListArea.layer.shadowOffset = CGSize(width: 2, height: 3)
        pnlMethodListArea.layer.shadowOpacity = 0.5
        pnlMethodListArea.layer.shadowRadius = 3
        pnlMethodListArea.translatesAutoresizingMaskIntoConstraints = false
        pnlMethodListArea.alpha = 1.0
        pnlMethodListArea.isHidden = true
        pnlMethodListArea.isUserInteractionEnabled = true
        
        lblMethodList = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblMethodList.font = UIFont(name: "HelveticaNeue-Bold", size: 13)
        lblMethodList.text = "THANH TOÁN CƯỚC"
        lblMethodList.textColor = UIColor.white
        lblMethodList.textAlignment = NSTextAlignment.center
        lblMethodList.translatesAutoresizingMaskIntoConstraints = false
        
        methodTable = ChoosePaymentMethodTable(parent: self)
        completion?()
        
    }
    
    func initLayout(_ completion: (() -> ())?){
        
        let scrRect = UIScreen.main.bounds
        
        
        self.parent.view.addSubview(pnlMethodListArea)
        pnlMethodListArea.centerXAnchor.constraint(equalTo: self.parent.view.centerXAnchor, constant: 0).isActive = true
        pnlMethodListArea.topAnchor.constraint(equalTo: self.parent.view.topAnchor , constant: 130.0).isActive = true
        pnlMethodListArea.widthAnchor.constraint(equalToConstant: scrRect.width-18.0).isActive = true
        
       // let bottom: CGFloat = (self.parent.tabBarController?.tabBar.hidden)! == false ? 0 : (self.parent.tabBarController?.tabBar.frame.size.height)!
        pnlMethodListArea.heightAnchor.constraint(equalToConstant: scrRect.height - 330).isActive = true
        
        pnlMethodListArea.addSubview(lblMethodList)
        lblMethodList.widthAnchor.constraint(equalTo: pnlMethodListArea.widthAnchor, constant : -20.0).isActive = true
        lblMethodList.centerXAnchor.constraint(equalTo: pnlMethodListArea.centerXAnchor, constant: 0).isActive = true
        lblMethodList.topAnchor.constraint(equalTo: pnlMethodListArea.topAnchor, constant : 10.0).isActive = true
        lblMethodList.heightAnchor.constraint(equalToConstant: 50)
        
        methodTable.initLayout{
            self.parent.view.layoutIfNeeded()
            completion?()
        }
    }
    
}
