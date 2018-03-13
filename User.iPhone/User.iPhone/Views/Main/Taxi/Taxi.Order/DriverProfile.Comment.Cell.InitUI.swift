//
//  Driver.Profile.Comment.Cell.swift
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

open class CommentCell: UITableViewCell, ModelTransfer {
    
    open static var AvatarAreaWidth: CGFloat = 60
    open static var CommentAreaWidth: CGFloat = UIScreen.main.bounds.size.width - 18 - AvatarAreaWidth
    open static var CommentLabelWidth: CGFloat = CommentAreaWidth - 10*2
    open static var yellowStar: UIImage = ImageHelper.resize(UIImage(named: "star.png")!, newWidth: 12)
    open static var grayStar: UIImage = ImageHelper.resize(UIImage(named: "graystar.png")!, newWidth: 12)
    open static var leftComment: UIImage = ImageHelper.resize(UIImage(named: "leftComment")!, newWidth: 20)
    
    open var lblUserName: UILabel!
    open var lblComment: UILabel!
    open var lblCreateDate: UILabel!
        
    open var imgAvatar: UIImageView!
    
    open var imgLeftComment: UIImageView!
    open var imgStar1: UIImageView!
    open var imgStar2: UIImageView!
    open var imgStar3: UIImageView!
    open var imgStar4: UIImageView!
    open var imgStar5: UIImageView!
    
    var pnlCommentArea: UIView!
    open var cellHeight: CGFloat = 0
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
        self.backgroundView =  UIView()
        self.backgroundColor = UIColor.clear
        
        
        imgAvatar = UIImageView(image: ImageHelper.resize(UIImage(named: "Avatar.png")!, newWidth: CommentCell.AvatarAreaWidth - 20))
        imgAvatar.frame = CGRect(x: 0, y: 0, width: CommentCell.AvatarAreaWidth - 20, height: CommentCell.AvatarAreaWidth - 20)
        imgAvatar.layer.borderWidth=1.0
        imgAvatar.layer.masksToBounds = false
        imgAvatar.layer.borderColor = UIColor.gray.cgColor
        imgAvatar.layer.cornerRadius = 13
        imgAvatar.layer.cornerRadius =  self.imgAvatar.frame.size.height/2
        imgAvatar.clipsToBounds = true
        imgAvatar.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(imgAvatar)
        imgAvatar.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant : 0.0).isActive = true
        imgAvatar.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant : 5.0).isActive = true
        
        pnlCommentArea = UIView()
        pnlCommentArea.backgroundColor = UIColor(red: CGFloat(247/255.0), green: CGFloat(247/255.0), blue: CGFloat(247/255.0), alpha: 1.0)
        pnlCommentArea.layer.cornerRadius = 3.0
        pnlCommentArea.layer.borderColor = UIColor.gray.cgColor
        pnlCommentArea.layer.borderWidth = 0.5
        pnlCommentArea.translatesAutoresizingMaskIntoConstraints = false
        pnlCommentArea.isUserInteractionEnabled = true
        
        self.contentView.addSubview(pnlCommentArea)
        pnlCommentArea.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant : 0.0).isActive = true
        pnlCommentArea.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant : -10.0).isActive = true
        pnlCommentArea.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant : 0.0).isActive = true
        pnlCommentArea.widthAnchor.constraint(equalToConstant: CommentCell.CommentAreaWidth).isActive = true
        
        
        
        imgLeftComment = UIImageView(image: CommentCell.leftComment)
        imgLeftComment.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        imgLeftComment.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(imgLeftComment)
        imgLeftComment.centerYAnchor.constraint(equalTo: imgAvatar.centerYAnchor, constant : 0.0).isActive = true
        imgLeftComment.rightAnchor.constraint(equalTo: pnlCommentArea.leftAnchor, constant : 3.0).isActive = true
        
        
        lblUserName = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblUserName.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        lblUserName.textColor = UIColor(red: CGFloat(40/255.0), green: CGFloat(152/255.0), blue: CGFloat(208/255.0), alpha: 1.0)
        lblUserName.textAlignment = NSTextAlignment.left
        lblUserName.translatesAutoresizingMaskIntoConstraints = false
        
        pnlCommentArea.addSubview(lblUserName)
        lblUserName.topAnchor.constraint(equalTo: pnlCommentArea.topAnchor, constant : 5.0).isActive = true
        lblUserName.leftAnchor.constraint(equalTo: pnlCommentArea.leftAnchor, constant : 10.0).isActive = true
        lblUserName.widthAnchor.constraint(equalTo: pnlCommentArea.widthAnchor, constant : -15.0).isActive = true
        lblUserName.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
        
        
        lblComment = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblComment.font = UILabel.appearance().font.withSize(12)
        lblComment.textColor = UIColor.darkGray
        lblComment.textAlignment = NSTextAlignment.justified
        lblComment.lineBreakMode = .byWordWrapping
        lblComment.numberOfLines = 0
        lblComment.translatesAutoresizingMaskIntoConstraints = false
        
        pnlCommentArea.addSubview(lblComment)
        lblComment.topAnchor.constraint(equalTo: lblUserName.bottomAnchor, constant : 8.0).isActive = true
        lblComment.bottomAnchor.constraint(equalTo: pnlCommentArea.bottomAnchor, constant : -10.0).isActive = true
        lblComment.leftAnchor.constraint(equalTo: lblUserName.leftAnchor, constant : 0.0).isActive = true
        lblComment.widthAnchor.constraint(equalToConstant: CommentCell.CommentLabelWidth).isActive = true
        
        
        
        self.imgStar1 = UIImageView(image: ImageHelper.resize(UIImage(named: "star.png")!, newWidth: 12))
        self.imgStar1.translatesAutoresizingMaskIntoConstraints = false
        self.imgStar2 = UIImageView(image: ImageHelper.resize(UIImage(named: "star.png")!, newWidth: 12))
        self.imgStar2.translatesAutoresizingMaskIntoConstraints = false
        self.imgStar3 = UIImageView(image: ImageHelper.resize(UIImage(named: "star.png")!, newWidth: 12))
        self.imgStar3.translatesAutoresizingMaskIntoConstraints = false
        self.imgStar4 = UIImageView(image: ImageHelper.resize(UIImage(named: "star.png")!, newWidth: 12))
        self.imgStar4.translatesAutoresizingMaskIntoConstraints = false
        self.imgStar5 = UIImageView(image: ImageHelper.resize(UIImage(named: "star.png")!, newWidth: 12))
        self.imgStar5.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        self.contentView.addSubview(imgStar1)
        self.imgStar1.centerYAnchor.constraint(equalTo: lblUserName.centerYAnchor, constant : 0.0).isActive = true
        self.imgStar1.rightAnchor.constraint(equalTo: lblComment.rightAnchor, constant : 0.0).isActive = true
        
        self.contentView.addSubview(imgStar2)
        self.imgStar2.centerYAnchor.constraint(equalTo: imgStar1.centerYAnchor, constant : 0.0).isActive = true
        self.imgStar2.rightAnchor.constraint(equalTo: imgStar1.leftAnchor, constant : 0.0).isActive = true
        
        self.contentView.addSubview(imgStar3)
        self.imgStar3.centerYAnchor.constraint(equalTo: imgStar1.centerYAnchor, constant : 0.0).isActive = true
        self.imgStar3.rightAnchor.constraint(equalTo: imgStar2.leftAnchor, constant : 0.0).isActive = true
        
        self.contentView.addSubview(imgStar4)
        self.imgStar4.centerYAnchor.constraint(equalTo: imgStar1.centerYAnchor, constant : 0.0).isActive = true
        self.imgStar4.rightAnchor.constraint(equalTo: imgStar3.leftAnchor, constant : 0.0).isActive = true
        
        self.contentView.addSubview(imgStar5)
        self.imgStar5.centerYAnchor.constraint(equalTo: imgStar1.centerYAnchor, constant : 0.0).isActive = true
        self.imgStar5.rightAnchor.constraint(equalTo: imgStar4.leftAnchor, constant : 0.0).isActive = true
        
        
        
        
        lblCreateDate = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblCreateDate.font = UILabel.appearance().font.withSize(11)
        lblCreateDate.textColor = UIColor.gray
        lblCreateDate.textAlignment = NSTextAlignment.right
        lblCreateDate.translatesAutoresizingMaskIntoConstraints = false
        
        pnlCommentArea.addSubview(lblCreateDate)
        lblCreateDate.topAnchor.constraint(equalTo: imgStar1.bottomAnchor, constant : -4.0).isActive = true
        lblCreateDate.rightAnchor.constraint(equalTo: lblComment.rightAnchor, constant : 0.0).isActive = true
        lblCreateDate.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        lblCreateDate.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
                
    }
    
    public required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}

