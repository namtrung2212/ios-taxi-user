//
//  Driver.Profile.Comment.Cell.Binding.swift
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

import SClientModelControllers
import DTTableViewManager
import DTModelStorage
import AlamofireImage


extension CommentCell{
    
    
    public  func updateWithModel(_ travelOrder: TravelOrder) {
        
        self.updateAvatar(travelOrder)
        
        self.updateComment(travelOrder)
        
        self.updateRating(travelOrder)
        
        self.updateUserName(travelOrder)
        
        self.updateCreateTime(travelOrder)
    }
    
    func updateUserName(_ travelOrder: TravelOrder){
        
        lblUserName.text = travelOrder.UserName?.uppercaseString
    }
    
    func updateAvatar(_ travelOrder: TravelOrder){
        
        let url = SClientData.ServerURL + "/avatar/user/\(travelOrder.User!)"
        
        self.imgAvatar.af_setImageWithURL(
            URL(string: url)!,
            placeholderImage:  ImageHelper.resize(UIImage(named: "Avatar.png")!, newWidth: CommentCell.AvatarAreaWidth - 20),
            filter: AspectScaledToFillSizeWithRoundedCornersFilter(size: self.imgAvatar.frame.size, radius: 20.0),
            imageTransition: .CrossDissolve(0.2)
        )
        
    }
    
    func updateRating(_ travelOrder: TravelOrder){
        
        imgStar1.image =  (travelOrder.Rating < 1) ?  CommentCell.grayStar : CommentCell.yellowStar
        imgStar2.image =  (travelOrder.Rating < 2) ?  CommentCell.grayStar : CommentCell.yellowStar
        imgStar3.image =  (travelOrder.Rating < 3) ?  CommentCell.grayStar : CommentCell.yellowStar
        imgStar4.image =  (travelOrder.Rating < 4) ?  CommentCell.grayStar : CommentCell.yellowStar
        imgStar5.image =  (travelOrder.Rating < 5) ?  CommentCell.grayStar : CommentCell.yellowStar
        
    }
    
    func updateComment(_ travelOrder: TravelOrder){
        
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.justified
        
        let attributedString = NSAttributedString(string: travelOrder.Comment!,
                                                  attributes: [
                                                    NSParagraphStyleAttributeName: paragraphStyle,
                                                    NSBaselineOffsetAttributeName: NSNumber(float: 0)
            ])
        
        lblComment.attributedText = attributedString
        
    }
    
    func updateCreateTime(_ travelOrder: TravelOrder){
        
        
        if(travelOrder.createdAt!.isNow(30)){
            lblCreateDate.text = "vừa xong"
            
        }else if(travelOrder.createdAt!.isToday()){
            
            lblCreateDate.text = "hôm nay"
            
        } else if(travelOrder.createdAt!.isYesterday()){
            
            lblCreateDate.text = "hôm qua"
            
        }else if(travelOrder.createdAt!.isCurrentYear()){
            
            lblCreateDate.text = travelOrder.createdAt?.toString("dd/MM")
            
        }else{
            
            lblCreateDate.text = travelOrder.createdAt?.toString("dd/MM/yyyy")
        }
    }
    
    
}
