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

extension TravelMonitoringView{
    
    func showDriverProfilePanel(_ show: Bool,completion: ((_ changed : Bool) -> ())?){
        
        if(show){
            
                if(self.pnlDriverProfileArea.isHidden ){
             
                            
                            self.pnlDriverProfileArea.isHidden = false
                            self.invalidateAvatar(true){
                            }
                    
                            self.parent.view.layoutIfNeeded()
                    
                        completion?(true)
                }else{
                    
                        completion?(false)
                }
            
        }else{
            
                if(self.pnlDriverProfileArea.isHidden == false){
                  
                            self.pnlDriverProfileArea.isHidden = true
                            self.invalidateAvatar(false){
                                
                            }
                            self.parent.view.layoutIfNeeded()
                    
                            completion?(true)
                }else{
                    
                        completion?(false)
                }
    
        }
    }

    func shouldShowDriverProfilePanel() -> Bool{
        
        let isShow : Bool = (self.driverStatus != nil) && (  self.CurrentOrder!.IsMonitoring() ||  self.CurrentOrder.IsStopped() )
        
        return isShow
    }

    func invalidateDriverProfilePanel(_ isFirstTime: Bool, completion: (() -> ())?){
        
        
            if(shouldShowDriverProfilePanel()){
                
                self.showDriverProfilePanel(true){changed in
                    
                    self.invalidateProfilePanelControls(isFirstTime) {
                        
                        self.pnlDriverProfileArea.isUserInteractionEnabled = true
                        self.parent.view.bringSubview(toFront: self.pnlDriverProfileArea)
                        self.parent.view.bringSubview(toFront: self.btnAvatar)
                        self.parent.view.bringSubview(toFront: self.redCircle)                        
                        self.parent.view.bringSubview(toFront: self.lblMessageNo)

                        
                        completion?()
                    }
                }
                
            }else{
                
                self.showDriverProfilePanel(false) {changed in
                    completion?()
                }
                
            }

        
        
    }
    
    
    func invalidateAvatar(_ isFirstTime: Bool, completion: (() -> ())?){
        
        if(btnAvatar != nil && imgAvatar != nil){
            
            if(self.CurrentOrder.Driver != nil && isFirstTime){
                
                let url = SClientData.ServerURL + "/avatar/driver/\(self.CurrentOrder!.Driver!)"
                
                self.imgAvatar.af_setImageWithURL(
                    URL(string: url)!,
                    placeholderImage: ImageHelper.resize(UIImage(named: "Avatar.png")!, newWidth: 60),
                    filter: AspectScaledToFillSizeWithRoundedCornersFilter(size: CGSize(width: 60,height: 60), radius: 24),
                    imageTransition: .CrossDissolve(0.2), completion: { (result) in
                        if(result.result.isSuccess){
                           self.btnAvatar.setImage(result.result.value!, forState: .Normal)
                        }
                    }
                )
                
                if(self.imgAvatar.image != nil){
                    self.btnAvatar.setImage(self.imgAvatar.image, for: UIControlState())
                }
            }
            
            self.btnAvatar.hidden = !((self.CurrentOrder != nil) && (  self.CurrentOrder!.IsMonitoring() ||  self.CurrentOrder.IsStopped() ))
            self.btnAvatar.ConstraintState = self.isCollapsedProfile ? 1 : 2
            

        }
        completion?()
    }
    
    
    func increaseMessageNo(_ increase : Int?, completion: ((_ number : Int) -> ())?){
        
        if(increase == nil) {
            invalidateMessageNo(false, count : nil,completion : completion)
            return
        }
    
        let strNo = lblMessageNo.text
            
        if(strNo != nil && strNo!.isEmpty == false) {
        
            var count : Int? = Int(strNo!)
            if(count != nil){
                count! += increase!
            }
            
            invalidateMessageNo(false,count : count, completion : completion)
            
        }else {
        
            invalidateMessageNo(false,count : nil, completion : completion);
        }
    
    
    }


    func invalidateMessageNo(_ isFirstTime: Bool, count : Int? ,completion: ((_ number : Int) -> ())?){
        
        
        if(count != nil && isFirstTime == false) {
            
            self.redCircle.isHidden = !self.shouldShowDriverProfilePanel()  || !self.isCollapsedProfile || count! <= 0
            self.lblMessageNo.isHidden = self.redCircle.isHidden
            self.lblMessageNo.text = String(count!)
            completion?(count!)
            return
            
        }
        
        if(isFirstTime == false){
            completion?(0)
            return
        }
        
        TravelOrderController.CountNotYetViewedMessageByUser(self.CurrentOrder!.id!) { (number) in
            
            self.redCircle.hidden = !self.shouldShowDriverProfilePanel()  || !self.isCollapsedProfile || number <= 0
            self.lblMessageNo.hidden = self.redCircle.hidden
            self.lblMessageNo.text = String(number)
            
            completion?(number : number)
        }
    }

    func invalidateLastMessage(_ isFirstTime: Bool,message : String?, completion: (() -> ())?){
        
        self.lblLastMessage.isHidden = !self.shouldShowDriverProfilePanel()  || !self.isCollapsedProfile
        if( message != nil){
            self.lblLastMessage.text = String(message!)
            completion?()
            return
        }

        if(isFirstTime == false && self.chattingView != nil && self.chattingView.chattingTable != nil && self.chattingView.chattingTable.chatData.count > 0){
            
            let lastObj = self.chattingView.chattingTable.chatData.sort({ (item1, item2) -> Bool in
                
                return   item1.1.cellObject!.createdAt!.compare(item2.1.cellObject!.createdAt!) == .OrderedAscending
                
            }).last.map { (newItem) -> TravelChattingObject in
                return newItem.1
            }
            
            
            if( lastObj != nil && lastObj!.cellObject != nil && lastObj!.cellObject!.IsUser == false && lastObj!.cellObject!.Content != nil ){
                self.lblLastMessage.text = String(lastObj!.cellObject!.Content!)
            }else{
                self.lblLastMessage.text = ""
            }
            
            completion?()
            
        }else{
            
            TravelOrderController.GetLastChattingMessage(self.CurrentOrder!.id!, completion: { (chatting) in
                
                if(chatting != nil  && chatting!.IsUser == false  && chatting!.Content != nil){
                    self.lblLastMessage.text = String(chatting!.Content!)
                }else{
                    self.lblLastMessage.text = ""
                }
                
                completion?()
            })
        }
        
        
    }


    func invalidateProfilePanelControls(_ isFirstTime: Bool, completion: (() -> ())?) {
        
            self.invalidateAvatar(isFirstTime){
            }
            self.btnCollapseProfile.setGMDIcon(self.isCollapsedProfile ? GMDType.gmdExpandMore : GMDType.gmdExpandLess, forState: UIControlState())
        
            self.imgStar1.hidden = !( self.driverStatus != nil && self.driverStatus!.Rating >= 1)
            self.imgStar2.hidden = !( self.driverStatus != nil && self.driverStatus!.Rating >= 2)
            self.imgStar3.hidden = !( self.driverStatus != nil && self.driverStatus!.Rating >= 3)
            self.imgStar4.hidden = !( self.driverStatus != nil && self.driverStatus!.Rating >= 4)
            self.imgStar5.hidden = !( self.driverStatus != nil && self.driverStatus!.Rating >= 5)
            
            self.lblRateCount.text =  (self.driverStatus != nil) ? "\(self.driverStatus!.RateCount) lượt" : ""
            self.lblRateCount.isHidden = false
            
            self.lblDriverName.text = (self.driverStatus != nil) ? self.driverStatus!.DriverName!.uppercaseString : ""
            self.lblDriverName.isHidden = false

            self.lblCarNo.text =  (self.driverStatus != nil) ? self.driverStatus!.CarNo : ""
            
            
            var strContent = ""
            if( self.driverStatus != nil){
                
                switch self.driverStatus!.QualityService! {
                case "Popular" : strContent = "Phổ Thông"
                case "Economic" : strContent = "Giá Rẻ"
                case "Luxury" : strContent = " Chất Lượng Cao"
                default: strContent = ""
                }
            }
        
            
            if(self.driverStatus != nil && self.driverStatus!.CarSeater != nil){
                strContent = "\(self.driverStatus!.CarSeater!) chỗ - \(strContent)"
            }
            
            if(self.driverStatus != nil && self.driverStatus!.CompanyName != nil){
                strContent = "\(self.driverStatus!.CompanyName!)  - \(strContent)"
                
            }
            
            self.lblSeaterAndQuality.text = strContent
            self.lblSeaterAndQuality.isHidden = false
            
            self.chattingView!.invalidate(!self.isCollapsedProfile){ changed in
                
                self.invalidateMessageNo(isFirstTime,count : nil){ number in
                    
                    self.invalidateLastMessage(isFirstTime, message:  number <= 0 ? "" : nil){
                        completion?()
                    }
                    
                }
                

            }
            
            self.pnlDriverProfileArea.ConstraintState = self.isCollapsedProfile ? 1 : 2
            self.pnlDriverProfileArea.layoutIfNeeded()
        
        
    }
    
}




