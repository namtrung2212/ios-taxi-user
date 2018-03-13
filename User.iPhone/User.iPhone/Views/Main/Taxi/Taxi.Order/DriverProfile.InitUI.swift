//
//  Driver.Profile.InitUI.swift
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
import SClientUI
import CoreLocation
import RealmSwift
import GoogleMaps

import DTTableViewManager
import DTModelStorage
import AlamofireImage

extension DriverProfileScreen{
    
    
    
    func initControls(_ completion: (() -> ())?){
        
        let scrRect = UIScreen.main.bounds
        
        
        btnBack = UIBarButtonItem(title: "", style: .plain, target: self, action: "btnBack_Clicked")
        btnBack.setFAIcon(FAType.faArrowLeft, iconSize : 20)
        btnBack.setTitlePositionAdjustment(UIOffsetMake(0, -5), for: .default)
        self.navigationItem.leftBarButtonItem = btnBack
        self.navigationItem.title = self.driver!.Name!.uppercaseString
        
        scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor(red: CGFloat(228/255.0), green: CGFloat(228/255.0), blue: CGFloat(228/255.0), alpha: 1.0)
        scrollView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refresh:", for: .valueChanged)
        scrollView.addSubview(refreshControl)

        containerView = UIView()
        containerView.backgroundColor = UIColor(red: CGFloat(228/255.0), green: CGFloat(228/255.0), blue: CGFloat(228/255.0), alpha: 1.0)

        self.profileView.initControls()
        
        
        
        lblEstPrice = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblEstPrice.font = UIFont(name: "HelveticaNeue-Bold", size: 27)
        lblEstPrice.textColor = UIColor.darkGray
        lblEstPrice.textAlignment = NSTextAlignment.center
        lblEstPrice.layer.shadowOffset = CGSize(width: 1, height: 1)
        lblEstPrice.layer.shadowOpacity = 0.2
        lblEstPrice.layer.shadowRadius = 1
        lblEstPrice.isHidden = true
        lblEstPrice.translatesAutoresizingMaskIntoConstraints = false
        
        
        lblStatus = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblStatus.font = lblStatus.font.withSize(15)
        lblStatus.textColor = UIColor.darkGray
        lblStatus.textAlignment = NSTextAlignment.center
        lblStatus.isHidden = true
        lblStatus.translatesAutoresizingMaskIntoConstraints = false


        let imgOrangeButton = ImageHelper.resize(UIImage(named: "BlueButton.png")!, newWidth: scrRect.width)
        btnSendRequest   = UIButton(type: UIButtonType.custom) as UIButton
        btnSendRequest.setTitle("ĐỀ NGHỊ ĐÓN", for: UIControlState())
        btnSendRequest.setBackgroundImage(imgOrangeButton, forState: .Normal)
        btnSendRequest.titleLabel!.font =   btnSendRequest.titleLabel!.font.withSize(15)
        btnSendRequest.titleLabel!.textAlignment = NSTextAlignment.center
        btnSendRequest.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btnSendRequest.titleLabel!.lineBreakMode = .byTruncatingTail
        btnSendRequest.contentHorizontalAlignment = .center
        btnSendRequest.contentVerticalAlignment = .center
        btnSendRequest.contentMode = .scaleToFill
        btnSendRequest.isHidden = true
        btnSendRequest.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        let imgGrayButton = ImageHelper.resize(UIImage(named: "GrayButton.png")!, newWidth: scrRect.width)
        btnCancelRequest   = UIButton(type: UIButtonType.custom) as UIButton
        btnCancelRequest.setTitleColor(UIColor.white, for: UIControlState())
        btnCancelRequest.setTitle("HỦY ĐÓN", for: UIControlState())
        btnCancelRequest.setBackgroundImage(imgGrayButton, forState: .Normal)
        btnCancelRequest.titleLabel!.font =   btnCancelRequest.titleLabel!.font.withSize(15)
        btnCancelRequest.titleLabel!.textAlignment = NSTextAlignment.center
        btnCancelRequest.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btnCancelRequest.titleLabel!.lineBreakMode = .byTruncatingTail
        btnCancelRequest.contentHorizontalAlignment = .center
        btnCancelRequest.contentVerticalAlignment = .center
        btnCancelRequest.contentMode = .scaleToFill
        btnCancelRequest.isHidden = true
        btnCancelRequest.translatesAutoresizingMaskIntoConstraints = false
        
        let imgAcceptButton = ImageHelper.resize(UIImage(named: "BlueButton.png")!, newWidth: scrRect.width)
        btnAcceptBidding   = UIButton(type: UIButtonType.custom) as UIButton
        btnAcceptBidding.setTitle("CHẤP NHẬN TÀI XẾ", for: UIControlState())
        btnAcceptBidding.setBackgroundImage(imgAcceptButton, forState: .Normal)
        btnAcceptBidding.titleLabel!.font =   btnAcceptBidding.titleLabel!.font.withSize(15)
        btnAcceptBidding.titleLabel!.textAlignment = NSTextAlignment.center
        btnAcceptBidding.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btnAcceptBidding.titleLabel!.lineBreakMode = .byTruncatingTail
        btnAcceptBidding.contentHorizontalAlignment = .center
        btnAcceptBidding.contentVerticalAlignment = .center
        btnAcceptBidding.contentMode = .scaleToFill
        btnAcceptBidding.isHidden = true
        btnAcceptBidding.translatesAutoresizingMaskIntoConstraints = false
        
        
        
       // let imgGrayButton = ImageHelper.resize(UIImage(named: "GrayButton.png")!, newWidth: scrRect.width)
        btnCancelBidding   = UIButton(type: UIButtonType.custom) as UIButton
        btnCancelBidding.setTitleColor(UIColor.white, for: UIControlState())
        btnCancelBidding.setTitle("TỪ CHỐI", for: UIControlState())
        btnCancelBidding.setBackgroundImage(imgGrayButton, forState: .Normal)
        btnCancelBidding.titleLabel!.font =   btnCancelBidding.titleLabel!.font.withSize(15)
        btnCancelBidding.titleLabel!.textAlignment = NSTextAlignment.center
        btnCancelBidding.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btnCancelBidding.titleLabel!.lineBreakMode = .byTruncatingTail
        btnCancelBidding.contentHorizontalAlignment = .center
        btnCancelBidding.contentVerticalAlignment = .center
        btnCancelBidding.contentMode = .scaleToFill
        btnCancelBidding.isHidden = true
        btnCancelBidding.translatesAutoresizingMaskIntoConstraints = false
        

        self.commentView.initControls()
        
        
        // Source Point Label
        btnLoadMore   = UIButton(type: UIButtonType.custom) as UIButton
        btnLoadMore.frame = CGRect(x: 0, y: 0, width: 0, height: 10)
        btnLoadMore.setTitle("Xem thêm", for: UIControlState())
        btnLoadMore.setTitleColor(UIColor.white, for: UIControlState())
        btnLoadMore.titleLabel!.font = btnLoadMore.titleLabel!.font.withSize(12)
        btnLoadMore.titleLabel!.textAlignment = NSTextAlignment.left
        btnLoadMore.titleLabel!.lineBreakMode = .byTruncatingTail
        btnLoadMore.backgroundColor = UIColor(red: 73.0/255.0, green: 139.0/255.0, blue: 199.0/255.0, alpha: 1.0)
        btnLoadMore.layer.cornerRadius = 10
        btnLoadMore.clipsToBounds = true
        btnLoadMore.contentHorizontalAlignment = .center
        btnLoadMore.contentEdgeInsets = UIEdgeInsetsMake(0,1,0,1)
        btnLoadMore.translatesAutoresizingMaskIntoConstraints = false
        
        self.initControlEvents()
        
        completion?()
        
    }
    
    func initLayout(_ completion: (() -> ())?){
        
        let scrRect = UIScreen.main.bounds
        
        scrollView.frame = self.view.bounds
        scrollView.autoresizingMask = UIViewAutoresizing.flexibleHeight
        self.view.addSubview(scrollView)
        
        containerView.frame = CGRect(x: 0, y: 0, width: scrRect.width , height: 2000)
        scrollView.addSubview(containerView)
        scrollView.contentSize = CGSize(width: scrRect.width, height: 2000)
        
        self.profileView.initLayout()
        
        
        self.view.addSubview(lblEstPrice)
        lblEstPrice.widthAnchor.constraint(equalTo: self.profileView.pnlProfileArea.widthAnchor , constant : 5.0).isActive = true
        lblEstPrice.leftAnchor.constraint(equalTo: self.profileView.pnlProfileArea.leftAnchor, constant: -2.0).isActive = true
        lblEstPrice.topAnchor.constraint(equalTo: self.profileView.pnlProfileArea.bottomAnchor, constant: 5).isActive = true
        lblEstPrice.initHeightConstraints(40,related: nil, second: nil, third: nil, fourth: nil)
        
        self.view.addSubview(lblStatus)
        lblStatus.widthAnchor.constraint(equalTo: self.profileView.pnlProfileArea.widthAnchor , constant : 5.0).isActive = true
        lblStatus.leftAnchor.constraint(equalTo: self.profileView.pnlProfileArea.leftAnchor, constant: -2.0).isActive = true
        lblStatus.topAnchor.constraint(equalTo: lblEstPrice.bottomAnchor, constant: 5).isActive = true
        lblStatus.initHeightConstraints(30,related: nil, second: nil, third: nil, fourth: nil)
        lblStatus.showControl = false
        
        self.view.addSubview(btnSendRequest)
        btnSendRequest.widthAnchor.constraint(equalTo: self.profileView.pnlProfileArea.widthAnchor , constant : 5.0).isActive = true
        btnSendRequest.leftAnchor.constraint(equalTo: self.profileView.pnlProfileArea.leftAnchor, constant: -2.0).isActive = true
        btnSendRequest.topAnchor.constraint(equalTo: lblStatus.bottomAnchor, constant: 5).isActive = true
        btnSendRequest.initHeightConstraints(40,related: nil, second: nil, third: nil, fourth: nil)
        btnSendRequest.showControl = false
        
        self.view.addSubview(btnCancelRequest)
        btnCancelRequest.widthAnchor.constraint(equalTo: self.profileView.pnlProfileArea.widthAnchor , constant : 5.0).isActive = true
        btnCancelRequest.leftAnchor.constraint(equalTo: self.profileView.pnlProfileArea.leftAnchor, constant: -2.0).isActive = true
        btnCancelRequest.topAnchor.constraint(equalTo: lblStatus.bottomAnchor, constant: 5).isActive = true
        btnCancelRequest.initHeightConstraints(40,related: nil, second: nil, third: nil, fourth: nil)
        btnCancelRequest.showControl = false
        
        self.view.addSubview(btnAcceptBidding)
        btnAcceptBidding.widthAnchor.constraint(equalTo: self.profileView.pnlProfileArea.widthAnchor , constant : 5.0).isActive = true
        btnAcceptBidding.leftAnchor.constraint(equalTo: self.profileView.pnlProfileArea.leftAnchor, constant: -2.0).isActive = true
        btnAcceptBidding.topAnchor.constraint(equalTo: lblStatus.bottomAnchor, constant: 5).isActive = true
        btnAcceptBidding.initHeightConstraints(40,related: nil, second: nil, third: nil, fourth: nil)
        btnAcceptBidding.showControl = false
        
        self.view.addSubview(btnCancelBidding)
        btnCancelBidding.widthAnchor.constraint(equalTo: self.profileView.pnlProfileArea.widthAnchor , constant : 5.0).isActive = true
        btnCancelBidding.leftAnchor.constraint(equalTo: self.profileView.pnlProfileArea.leftAnchor, constant: -2.0).isActive = true
        btnCancelBidding.topAnchor.constraint(equalTo: lblStatus.bottomAnchor, constant: 5).isActive = true
        btnCancelBidding.initHeightConstraints(40,related: nil, second: nil, third: nil, fourth: nil)
        btnCancelBidding.showControl = false

       
        self.commentView.initLayout()
        
        containerView.addSubview(btnLoadMore)
        btnLoadMore.topAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant : -100.0).isActive = true
        btnLoadMore.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant : 0.0).isActive = true
        btnLoadMore.heightAnchor.constraint(equalToConstant: 20).isActive = true
        btnLoadMore.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        self.view.layoutIfNeeded()
        
        completion?()
        
    }
    
    func initControlEvents(){
        
        btnSendRequest.addTarget(self, action: #selector(DriverProfileScreen.btnSendRequest_Clicked(_:)), for:.touchUpInside)
        btnCancelRequest.addTarget(self, action: #selector(DriverProfileScreen.btnCancelRequest_Clicked(_:)), for:.touchUpInside)
        
        btnAcceptBidding.addTarget(self, action: #selector(DriverProfileScreen.btnAcceptBidding_Clicked(_:)), for:.touchUpInside)
        btnCancelBidding.addTarget(self, action: #selector(DriverProfileScreen.btnCancelBidding_Clicked(_:)), for:.touchUpInside)
        
        btnLoadMore.addTarget(self, action: #selector(DriverProfileScreen.btnLoadMore_Clicked(_:)), for:.touchUpInside)
        

    }

    public func resetScrollSize(){
        
        let scrRect = UIScreen.main.bounds
        containerView.frame = CGRect(x: 0, y: 0, width: scrRect.width , height: self.commentView.getPreferedTableHeight() + 350)
        scrollView.contentSize = CGSize(width: scrRect.width, height: self.commentView.getPreferedTableHeight() + 350)
        
        
    }
}
