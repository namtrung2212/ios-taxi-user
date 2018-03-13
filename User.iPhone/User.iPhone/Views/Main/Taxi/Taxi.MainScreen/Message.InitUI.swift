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



extension TravelChattingView{
    
    
    func initControls(_ completion: (() -> ())?){
        
        let scrRect = UIScreen.main.bounds
        
        
        pnlContentArea = UIView()
        pnlContentArea.backgroundColor = UIColor.clear
        pnlContentArea.translatesAutoresizingMaskIntoConstraints = false
        pnlContentArea.alpha = 1.0
        pnlContentArea.isHidden = true
        pnlContentArea.isUserInteractionEnabled = true
        
        chattingTable = TravelChattingTable(parent: self)
        
        
        chattingInputVIew = ChattingInputView(parent: self)
        chattingInputVIew.initControls(completion)
        
    }
    
    func initLayout(_ completion: (() -> ())?){
        
        let scrRect = UIScreen.main.bounds
        
        self.parent.monitoringView.pnlDriverProfileArea.addSubview(pnlContentArea)
        pnlContentArea.centerXAnchor.constraint(equalTo: self.parent.monitoringView.pnlDriverProfileArea.centerXAnchor, constant: 0).isActive = true
        pnlContentArea.widthAnchor.constraint(equalTo: self.parent.monitoringView.pnlDriverProfileArea.widthAnchor, constant: -2).isActive = true
        pnlContentArea.topAnchor.constraint(equalTo: self.parent.monitoringView.pnlDriverProfileArea.topAnchor, constant: 55).isActive = true
        self.contentBottom = pnlContentArea.bottomAnchor.constraint(equalTo: self.parent.monitoringView.pnlDriverProfileArea.bottomAnchor, constant: -30)
        
        self.contentBottom.isActive = true
        chattingInputVIew.initLayout{
            self.chattingTable.initLayout(completion)
            self.parent.view.layoutIfNeeded()
        }
    }
    
}
