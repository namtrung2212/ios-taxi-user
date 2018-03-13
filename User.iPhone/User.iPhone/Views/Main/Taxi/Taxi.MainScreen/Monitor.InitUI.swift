//
//  Main.CreateOrder.ChooseLocation.InitUI.swift
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



extension TravelMonitoringView {
    
    func initControls(_ completion: (() -> ())?){
        
        self.initOrderPanel{
            self.initDriverProfilePanel(completion)
        }
    }
    
    func initLayout(_ completion: (() -> ())?){
        self.initOrderPanelLayout{
            self.initDriverProfilePanelLayout(completion)
        }
    }
    
    
    func initOrderPanel(_ completion: (() -> ())?){
        
        let scrRect = UIScreen.main.bounds
       
        
        // Order Panel
        pnlOrderArea = UIView()
        
        pnlOrderArea.backgroundColor = UIColor(red: CGFloat(246/255.0), green: CGFloat(246/255.0), blue: CGFloat(246/255.0), alpha: 1.0)
        pnlOrderArea.layer.cornerRadius = 5.0
        pnlOrderArea.layer.borderColor = UIColor.gray.cgColor
        pnlOrderArea.layer.borderWidth = 0.5
        pnlOrderArea.layer.shadowOffset = CGSize(width: 2, height: 3)
        pnlOrderArea.layer.shadowOpacity = 0.5
        pnlOrderArea.layer.shadowRadius = 3
        
        pnlOrderArea.translatesAutoresizingMaskIntoConstraints = false
        pnlOrderArea.alpha = 0.92
        pnlOrderArea.isHidden = true
        pnlOrderArea.isUserInteractionEnabled = true
        
        btnCollapseOrder   = UIButton(type: UIButtonType.custom) as UIButton
        btnCollapseOrder.frame = CGRect(x: 0, y: 0, width: 0, height: 10)
        btnCollapseOrder.titleLabel!.font = btnCollapseOrder.titleLabel!.font.withSize(25)
        btnCollapseOrder.setGMDIcon(GMDType.gmdExpandMore, forState: UIControlState())
        btnCollapseOrder.setTitleColor(UIColor.gray, for: UIControlState())
        btnCollapseOrder.translatesAutoresizingMaskIntoConstraints = false
        
        // Source Point Left Button
        let imgSource = ImageHelper.resize(UIImage(named: "pickupIcon.png")!, newWidth: 35)
        btnPickupIcon   = UIButton(type: UIButtonType.custom) as UIButton
        btnPickupIcon.frame = CGRect(x: 35, y: 35, width: 35, height: 35)
        btnPickupIcon.setImage(imgSource, forState: .Normal)
        btnPickupIcon.translatesAutoresizingMaskIntoConstraints = false
        
        //  Source TextBox
        let imgSouceTextBox = ImageHelper.resize(UIImage(named: "textbox1.png")!, newWidth: scrRect.width * 1.0)
        imgPickupLocationBG = UIImageView(image: imgSouceTextBox)
        imgPickupLocationBG.translatesAutoresizingMaskIntoConstraints = false
        imgPickupLocationBG.isUserInteractionEnabled = true
        
        // Source Point Label
        lblPickupLocation   = UIButton(type: UIButtonType.custom) as UIButton
        lblPickupLocation.frame = CGRect(x: 0, y: 0, width: 0, height: 10)
        lblPickupLocation.setTitle(" ", for: UIControlState())
        lblPickupLocation.setTitleColor(UIColor.darkGray, for: UIControlState())
        lblPickupLocation.titleLabel!.font = lblPickupLocation.titleLabel!.font.withSize(12)
        lblPickupLocation.titleLabel!.textAlignment = NSTextAlignment.left
        lblPickupLocation.titleLabel!.lineBreakMode = .byTruncatingTail
        lblPickupLocation.contentHorizontalAlignment = .left
        lblPickupLocation.contentEdgeInsets = UIEdgeInsetsMake(0,1,0,1)
        lblPickupLocation.translatesAutoresizingMaskIntoConstraints = false
        
        // Destiny Point Left Button
        let imgDrop = ImageHelper.resize(UIImage(named: "dropicon.png")!, newWidth: 35)
        btnDropIcon   = UIButton(type: UIButtonType.custom) as UIButton
        btnDropIcon.frame = CGRect(x: 35, y: 35, width: 35, height: 35)
        btnDropIcon.setImage(imgDrop, forState: .Normal)
        btnDropIcon.translatesAutoresizingMaskIntoConstraints = false
        
        //  Destiny TextBox
        let imgDestinyTextBox = ImageHelper.resize(UIImage(named: "textbox1.png")!, newWidth: scrRect.width * 1.0)
        imgDropLocationBG = UIImageView(image: imgDestinyTextBox)
        imgDropLocationBG.translatesAutoresizingMaskIntoConstraints = false
        imgDropLocationBG.isUserInteractionEnabled = true
        
        // Destiny Point Label
        lblDropLocation   = UIButton(type: UIButtonType.custom) as UIButton
        lblDropLocation.frame = CGRect(x: 0, y: 0, width: 0, height: 10)
        lblDropLocation.setTitle(" ", for: UIControlState())
        lblDropLocation.setTitleColor(UIColor.darkGray, for: UIControlState())
        lblDropLocation.titleLabel!.font = lblDropLocation.titleLabel!.font.withSize(12)
        lblDropLocation.titleLabel!.textAlignment = NSTextAlignment.left
        lblDropLocation.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        lblDropLocation.titleLabel!.lineBreakMode = .byTruncatingTail
        lblDropLocation.contentHorizontalAlignment = .left
        lblDropLocation.translatesAutoresizingMaskIntoConstraints = false
        
        // Path Statistic Label
        lblMoreInfo = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblMoreInfo.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        lblMoreInfo.textColor = UIColor.darkGray
        lblMoreInfo.textAlignment = NSTextAlignment.center
        lblMoreInfo.text = ""
        lblMoreInfo.translatesAutoresizingMaskIntoConstraints = false
        lblMoreInfo.isHidden = true
        
        
        lblStatus = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblStatus.font = UIFont(name: "HelveticaNeue-Bold", size: 13)
        lblStatus.textColor = UIColor(red: 73.0/255.0, green: 139.0/255.0, blue: 199.0/255.0, alpha: 1.0)
        lblStatus.textAlignment = NSTextAlignment.center
        lblStatus.text = ""
        lblStatus.translatesAutoresizingMaskIntoConstraints = false        
        
        lblCurrentPrice = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblCurrentPrice.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        lblCurrentPrice.textColor = UIColor.darkGray
        lblCurrentPrice.textAlignment = NSTextAlignment.center
        lblCurrentPrice.text = ""
        lblCurrentPrice.translatesAutoresizingMaskIntoConstraints = false
        lblCurrentPrice.isHidden = true

        // Bottom  Button Area
        pnlButtonArea = UIView()
        pnlButtonArea.translatesAutoresizingMaskIntoConstraints = false
        pnlButtonArea.isUserInteractionEnabled = true
        pnlButtonArea.isHidden = true
        
        
        // Quick Order Button
        let imgOrangeButton = ImageHelper.resize(UIImage(named: "OrangeButton.png")!, newWidth: scrRect.width/2)
        btnVoid   = UIButton(type: UIButtonType.custom) as UIButton
        btnVoid.setTitle("HỦY CHUYẾN", for: UIControlState())
        btnVoid.setBackgroundImage(imgOrangeButton, forState: .Normal)
        btnVoid.titleLabel!.font =   btnVoid.titleLabel!.font.withSize(15)
        btnVoid.titleLabel!.textAlignment = NSTextAlignment.center
        btnVoid.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btnVoid.titleLabel!.lineBreakMode = .byTruncatingTail
        btnVoid.contentHorizontalAlignment = .center
        btnVoid.contentVerticalAlignment = .center
        btnVoid.contentMode = .scaleToFill
        btnVoid.translatesAutoresizingMaskIntoConstraints = false
        
        lblPickupLocation.addTarget(self, action: #selector(TravelMonitoringView.btnPickupIcon_Clicked(_:)), for:.touchUpInside)
        btnCollapseOrder.addTarget(self, action: #selector(TravelMonitoringView.btnCollapseOrder_Clicked(_:)), for:.touchUpInside)
        
        btnPickupIcon.addTarget(self, action: #selector(TravelMonitoringView.btnPickupIcon_Clicked(_:)), for:.touchUpInside)
        btnDropIcon.addTarget(self, action: #selector(TravelMonitoringView.btnDropIcon_Clicked(_:)), for:.touchUpInside)
        lblDropLocation.addTarget(self, action: #selector(TravelMonitoringView.btnDropIcon_Clicked(_:)), for:.touchUpInside)
      
        btnVoid.addTarget(self, action: #selector(TravelMonitoringView.btnVoid_Clicked(_:)), for:.touchUpInside)
        
        completion?()
        
    }
    
    func initOrderPanelLayout(_ completion: (() -> ())?){
        
        
        let scrRect = UIScreen.main.bounds
                
        self.parent.view.addSubview(pnlButtonArea)
        pnlButtonArea.widthAnchor.constraint(equalToConstant: scrRect.width-7.0).isActive = true
        pnlButtonArea.centerXAnchor.constraint(equalTo: self.parent.view.centerXAnchor, constant: 2.0).isActive = true
        
        let bottom: CGFloat = (self.parent.tabBarController?.tabBar.isHidden)! == true ? 0 : (self.parent.tabBarController?.tabBar.frame.size.height)!
        
        pnlButtonArea.bottomAnchor.constraint(equalTo: self.parent.view.bottomAnchor, constant: -3 - bottom).isActive = true
        pnlButtonArea.initHeightConstraints(40,related: nil, second: nil, third: nil, fourth: nil)
        
        pnlButtonArea.addSubview(btnVoid)
        btnVoid.widthAnchor.constraint(equalTo: pnlButtonArea.widthAnchor, multiplier: 1.0).isActive = true
        btnVoid.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnVoid.centerXAnchor.constraint(equalTo: pnlButtonArea.centerXAnchor, constant: 0.0).isActive = true
        btnVoid.topAnchor.constraint(equalTo: pnlButtonArea.topAnchor, constant: 0.0).isActive = true
        
        
        self.parent.view.addSubview(pnlOrderArea)
        pnlOrderArea.centerXAnchor.constraint(equalTo: self.parent.view.centerXAnchor, constant: 0).isActive = true
        pnlOrderArea.bottomAnchor.constraint(equalTo: pnlButtonArea.topAnchor, constant: -5.0).isActive = true
        pnlOrderArea.widthAnchor.constraint(equalToConstant: scrRect.width-18.0).isActive = true
        pnlOrderArea.initHeightConstraints(155,related: nil, second: 90, third: 180, fourth: nil)
        
        self.pnlOrderArea.addSubview(btnCollapseOrder)
        btnCollapseOrder.topAnchor.constraint(equalTo: pnlOrderArea.topAnchor, constant: 5.0).isActive = true
        btnCollapseOrder.centerXAnchor.constraint(equalTo: pnlOrderArea.centerXAnchor, constant : 0.0).isActive = true
        btnCollapseOrder.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        self.pnlOrderArea.addSubview(lblStatus)
        lblStatus.topAnchor.constraint(equalTo: btnCollapseOrder.bottomAnchor, constant: 5.0).isActive = true
        lblStatus.centerXAnchor.constraint(equalTo: pnlOrderArea.centerXAnchor, constant : 0.0).isActive = true
        lblStatus.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        self.pnlOrderArea.addSubview(lblMoreInfo)
        lblMoreInfo.initBottomConstraints(-10.0, related: self.pnlOrderArea.bottomAnchor, second: 0, third: nil, fourth: nil)
        lblMoreInfo.centerXAnchor.constraint(equalTo: pnlOrderArea.centerXAnchor, constant : 0.0).isActive = true
        lblMoreInfo.widthAnchor.constraint(equalTo: pnlOrderArea.widthAnchor, multiplier: 0.95).isActive = true
        lblMoreInfo.initHeightConstraints(15, related: nil, second: 0, third: nil, fourth: nil)
        
        self.pnlOrderArea.addSubview(btnDropIcon)
        btnDropIcon.bottomAnchor.constraint(equalTo: lblMoreInfo.topAnchor, constant: -5.0).isActive = true
        btnDropIcon.leftAnchor.constraint(equalTo: pnlOrderArea.leftAnchor, constant : 8.0).isActive = true
        btnDropIcon.initHeightConstraints(35, related: nil, second: 0, third: nil, fourth: nil)
        
        self.pnlOrderArea.addSubview(imgDropLocationBG)
        imgDropLocationBG.centerYAnchor.constraint(equalTo: btnDropIcon.centerYAnchor, constant: 0.0).isActive = true
        imgDropLocationBG.leftAnchor.constraint(equalTo: btnDropIcon.rightAnchor, constant : 2.0).isActive = true
        imgDropLocationBG.widthAnchor.constraint(equalTo: pnlOrderArea.widthAnchor, constant : -57.0).isActive = true
        imgDropLocationBG.initHeightConstraints(33, related: nil, second: 0, third: nil, fourth: nil)
        
        self.pnlOrderArea.addSubview(lblDropLocation)
        lblDropLocation.centerYAnchor.constraint(equalTo: btnDropIcon.centerYAnchor, constant: 0.0).isActive = true
        lblDropLocation.leftAnchor.constraint(equalTo: imgDropLocationBG.leftAnchor, constant : 5.0).isActive = true
        lblDropLocation.widthAnchor.constraint(equalTo: imgDropLocationBG.widthAnchor, constant : -28.0).isActive = true
        lblDropLocation.initHeightConstraints(13, related: nil, second: 0, third: nil, fourth: nil)
        
        self.pnlOrderArea.addSubview(btnPickupIcon)
        btnPickupIcon.bottomAnchor.constraint(equalTo: btnDropIcon.topAnchor, constant: -7.0).isActive = true
        btnPickupIcon.leftAnchor.constraint(equalTo: btnDropIcon.leftAnchor, constant : 0.0).isActive = true
        btnPickupIcon.initHeightConstraints(35, related: nil, second: 0, third: nil, fourth: nil)
        
        self.pnlOrderArea.addSubview(imgPickupLocationBG)
        imgPickupLocationBG.centerYAnchor.constraint(equalTo: btnPickupIcon.centerYAnchor, constant: 0.0).isActive = true
        imgPickupLocationBG.leftAnchor.constraint(equalTo: btnPickupIcon.rightAnchor, constant : 2.0).isActive = true
        imgPickupLocationBG.widthAnchor.constraint(equalTo: imgDropLocationBG.widthAnchor, constant : 0.0).isActive = true
        imgPickupLocationBG.initHeightConstraints(33, related: nil, second: 0, third: nil, fourth: nil)
        
        self.pnlOrderArea.addSubview(lblPickupLocation)
        lblPickupLocation.centerYAnchor.constraint(equalTo: btnPickupIcon.centerYAnchor, constant: 0.0).isActive = true
        lblPickupLocation.leftAnchor.constraint(equalTo: imgPickupLocationBG.leftAnchor, constant : 5.0).isActive = true
        lblPickupLocation.widthAnchor.constraint(equalTo: imgPickupLocationBG.widthAnchor, constant : -28.0).isActive = true
        lblPickupLocation.initHeightConstraints(13, related: nil, second: 0, third: nil, fourth: nil)
        
        self.pnlOrderArea.addSubview(lblCurrentPrice)
        lblCurrentPrice.initTopConstraints(4, related: lblStatus.bottomAnchor, second: 10, third: nil, fourth: nil)
        lblCurrentPrice.centerXAnchor.constraint(equalTo: pnlOrderArea.centerXAnchor, constant : 0.0).isActive = true
        lblCurrentPrice.widthAnchor.constraint(equalTo: pnlOrderArea.widthAnchor, multiplier: 0.95).isActive = true
        
        self.parent.view.layoutIfNeeded()
        completion?()
    }
    
    
    func initDriverProfilePanel(_ completion: (() -> ())?){
        
        let scrRect = UIScreen.main.bounds
        
        
        // Profile Panel
        pnlDriverProfileArea = UIView()
        
        pnlDriverProfileArea.backgroundColor = UIColor(red: CGFloat(246/255.0), green: CGFloat(246/255.0), blue: CGFloat(246/255.0), alpha: 0.9)
        pnlDriverProfileArea.layer.cornerRadius = 5.0
        pnlDriverProfileArea.layer.borderColor = UIColor.gray.withAlphaComponent(0.9).cgColor
        pnlDriverProfileArea.layer.borderWidth = 0.5
        pnlDriverProfileArea.layer.shadowOffset = CGSize(width: 2, height: 3)
        pnlDriverProfileArea.layer.shadowOpacity = 0.5
        pnlDriverProfileArea.layer.shadowRadius = 3
        
        pnlDriverProfileArea.translatesAutoresizingMaskIntoConstraints = false
        pnlDriverProfileArea.isHidden = true
        pnlDriverProfileArea.isUserInteractionEnabled = true
        
        btnCollapseProfile   = UIButton(type: UIButtonType.custom) as UIButton
        btnCollapseProfile.frame = CGRect(x: 0, y: 0, width: 0, height: 10)
        btnCollapseProfile.titleLabel!.font = btnCollapseProfile.titleLabel!.font.withSize(25)
        btnCollapseProfile.setGMDIcon(GMDType.gmdExpandMore, forState: UIControlState())
        btnCollapseProfile.setTitleColor(UIColor.gray, for: UIControlState())
        btnCollapseProfile.translatesAutoresizingMaskIntoConstraints = false

        
        let avatar = ImageHelper.resize(UIImage(named: "Avatar.png")!, newWidth: 60)
        
        self.imgAvatar = UIImageView(image: avatar)
        self.imgAvatar.frame = CGRect(x: 0, y: 0, width: 60, height: 60)

        self.btnAvatar   = UIButton(type: UIButtonType.custom) as UIButton
        self.btnAvatar.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        self.btnAvatar.setImage(avatar, forState: .Normal)
        self.btnAvatar.layer.borderWidth = 0.6
        self.btnAvatar.layer.masksToBounds = false
        self.btnAvatar.layer.borderColor = UIColor.gray.cgColor
        self.btnAvatar.layer.cornerRadius = 13
        self.btnAvatar.layer.cornerRadius =  self.btnAvatar.frame.size.height/2
        self.btnAvatar.clipsToBounds = true
        self.btnAvatar.layer.shadowOffset = CGSize(width: 2, height: 3)
        self.btnAvatar.layer.shadowOpacity = 0.5
        self.btnAvatar.layer.shadowRadius = 3
        self.btnAvatar.translatesAutoresizingMaskIntoConstraints = false
        self.btnAvatar.isHidden = true

        
        
        
        self.lblDriverName = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        self.lblDriverName.font = UIFont(name: "HelveticaNeue-Bold", size: 13)
        self.lblDriverName.textColor = UIColor.darkGray
        self.lblDriverName.textAlignment = NSTextAlignment.left
        self.lblDriverName.translatesAutoresizingMaskIntoConstraints = false
        
        self.lblRateCount = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        self.lblRateCount.font = self.lblRateCount.font.withSize(11)
        self.lblRateCount.textColor = UIColor.gray
        self.lblRateCount.textAlignment = NSTextAlignment.right
        self.lblRateCount.translatesAutoresizingMaskIntoConstraints = false
        self.lblRateCount.isHidden = true
                
        self.lblSeaterAndQuality = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        self.lblSeaterAndQuality.font = UIFont(name: "HelveticaNeue-Bold", size: 11)
        self.lblSeaterAndQuality.textColor = UIColor.darkGray
        self.lblSeaterAndQuality.textAlignment = NSTextAlignment.left
        self.lblSeaterAndQuality.translatesAutoresizingMaskIntoConstraints = false
        self.lblSeaterAndQuality.isHidden = true
        
        self.lblCarNo = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        self.lblCarNo.font = UIFont(name: "HelveticaNeue-Bold", size: 13)
        self.lblCarNo.textColor = UIColor.gray
        self.lblCarNo.textAlignment = NSTextAlignment.right
        self.lblCarNo.translatesAutoresizingMaskIntoConstraints = false

        
        self.imgStar1 = UIImageView(image: ImageHelper.resize(UIImage(named: "star.png")!, newWidth: 16))
        self.imgStar1.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        self.imgStar1.translatesAutoresizingMaskIntoConstraints = false
        self.imgStar2 = UIImageView(image: ImageHelper.resize(UIImage(named: "star.png")!, newWidth: 16))
        self.imgStar2.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        self.imgStar2.translatesAutoresizingMaskIntoConstraints = false
        self.imgStar3 = UIImageView(image: ImageHelper.resize(UIImage(named: "star.png")!, newWidth: 16))
        self.imgStar3.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        self.imgStar3.translatesAutoresizingMaskIntoConstraints = false
        self.imgStar4 = UIImageView(image: ImageHelper.resize(UIImage(named: "star.png")!, newWidth: 16))
        self.imgStar4.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        self.imgStar4.translatesAutoresizingMaskIntoConstraints = false
        self.imgStar5 = UIImageView(image: ImageHelper.resize(UIImage(named: "star.png")!, newWidth: 16))
        self.imgStar5.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        self.imgStar5.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.lblLastMessage = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        self.lblLastMessage.font = UIFont(name: "HelveticaNeue-Italic", size:11)
        self.lblLastMessage.textColor = UIColor.darkGray
        self.lblLastMessage.text = ""
        self.lblLastMessage.textAlignment = NSTextAlignment.left
        self.lblLastMessage.translatesAutoresizingMaskIntoConstraints = false
        self.lblLastMessage.isHidden = false
        
        
        
        let imgredCircle = ImageHelper.resize(UIImage(named: "redcircle.png")!, newWidth: 20.0)
        redCircle = UIImageView(image: imgredCircle)
        redCircle.translatesAutoresizingMaskIntoConstraints = false
        redCircle.isUserInteractionEnabled = false
        redCircle.isHidden = true
        
        
        self.lblMessageNo = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        self.lblMessageNo.font = UIFont(name: "HelveticaNeue", size: 10)
        self.lblMessageNo.textColor = UIColor.white
        self.lblMessageNo.text = "12"
        self.lblMessageNo.textAlignment = NSTextAlignment.center
        self.lblMessageNo.translatesAutoresizingMaskIntoConstraints = false
        self.lblMessageNo.isHidden = true
        chattingView = TravelChattingView(parent: self.parent)
        chattingView.initControls(completion)
        
    }
    
    func initDriverProfilePanelLayout(_ completion: (() -> ())?){
        
        let scrRect = UIScreen.main.bounds
        
        self.parent.view.addSubview(pnlDriverProfileArea)
        pnlDriverProfileArea.widthAnchor.constraint(equalTo: self.parent.view.widthAnchor , constant : -16.0).isActive = true
        pnlDriverProfileArea.leftAnchor.constraint(equalTo: self.parent.view.leftAnchor, constant: 8.0).isActive = true
        pnlDriverProfileArea.topAnchor.constraint(equalTo: self.parent.view.topAnchor, constant: 70).isActive = true
        pnlDriverProfileArea.initHeightConstraints(80,related: nil, second: 400, third: nil, fourth: nil)
        
        pnlDriverProfileArea.addSubview(btnCollapseProfile)
        btnCollapseProfile.topAnchor.constraint(equalTo: pnlDriverProfileArea.bottomAnchor, constant: -20.0).isActive = true
        btnCollapseProfile.centerXAnchor.constraint(equalTo: pnlDriverProfileArea.centerXAnchor, constant : 0.0).isActive = true
        btnCollapseProfile.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        
        self.parent.view.addSubview(btnAvatar)
        //btnAvatar.topAnchor.constraintEqualToAnchor(self.parent.view.topAnchor, constant: 66.0).active = true
        btnAvatar.initTopConstraints(75, related: self.parent.view.topAnchor, second: 75, third: nil, fourth: nil)
        btnAvatar.leftAnchor.constraint(equalTo: pnlDriverProfileArea.leftAnchor, constant : 5.0).isActive = true
        btnAvatar.initWidthConstraints(60, related: nil, second: nil, third: nil, fourth: nil)
        btnAvatar.initHeightConstraints(60, related: nil, second: nil, third: nil, fourth: nil)
        
        
        self.parent.view.addSubview(redCircle)
        redCircle.topAnchor.constraint(equalTo: btnAvatar.topAnchor, constant : 0.0).isActive = true
        redCircle.leftAnchor.constraint(equalTo: btnAvatar.rightAnchor, constant : -18.0).isActive = true
        redCircle.widthAnchor.constraint(equalToConstant: 20).isActive = true
        redCircle.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        self.parent.view.addSubview(lblMessageNo)
        lblMessageNo.centerXAnchor.constraint(equalTo: redCircle.centerXAnchor, constant : 0.0).isActive = true
        lblMessageNo.centerYAnchor.constraint(equalTo: redCircle.centerYAnchor, constant : 0.0).isActive = true
        lblMessageNo.widthAnchor.constraint(equalToConstant: 50).isActive = true
        lblMessageNo.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        pnlDriverProfileArea.addSubview(lblDriverName)
        lblDriverName.topAnchor.constraint(equalTo: pnlDriverProfileArea.topAnchor, constant : 10.0).isActive = true
        lblDriverName.leftAnchor.constraint(equalTo: pnlDriverProfileArea.leftAnchor, constant : 70.0).isActive = true
        lblDriverName.widthAnchor.constraint(equalTo: pnlDriverProfileArea.widthAnchor, constant : -20.0).isActive = true
        lblDriverName.heightAnchor.constraint(equalToConstant: 20)
        
        pnlDriverProfileArea.addSubview(lblSeaterAndQuality)
        lblSeaterAndQuality.topAnchor.constraint(equalTo: lblDriverName.bottomAnchor, constant : 5.0).isActive = true
        lblSeaterAndQuality.leftAnchor.constraint(equalTo: lblDriverName.leftAnchor, constant : 0.0).isActive = true
        lblSeaterAndQuality.widthAnchor.constraint(equalTo: lblDriverName.widthAnchor, constant : 0.0).isActive = true
        lblSeaterAndQuality.heightAnchor.constraint(equalToConstant: 20)
        
        
        pnlDriverProfileArea.addSubview(lblLastMessage)
        lblLastMessage.topAnchor.constraint(equalTo: lblSeaterAndQuality.bottomAnchor, constant : 5.0).isActive = true
        lblLastMessage.leftAnchor.constraint(equalTo: lblDriverName.leftAnchor, constant : 0.0).isActive = true
        lblLastMessage.widthAnchor.constraint(equalTo: pnlDriverProfileArea.widthAnchor, constant : -130.0).isActive = true
        lblLastMessage.heightAnchor.constraint(equalToConstant: 20)
        
        
        
        pnlDriverProfileArea.addSubview(lblCarNo)
        lblCarNo.centerYAnchor.constraint(equalTo: lblDriverName.centerYAnchor, constant : 0.0).isActive = true
        lblCarNo.rightAnchor.constraint(equalTo: pnlDriverProfileArea.rightAnchor, constant : -10.0).isActive = true
        
        pnlDriverProfileArea.addSubview(imgStar1)
        imgStar1.centerYAnchor.constraint(equalTo: lblSeaterAndQuality.centerYAnchor, constant : 0.0).isActive = true
        imgStar1.rightAnchor.constraint(equalTo: lblCarNo.rightAnchor, constant : 3.0).isActive = true
        
        pnlDriverProfileArea.addSubview(imgStar2)
        imgStar2.centerYAnchor.constraint(equalTo: imgStar1.centerYAnchor, constant : 0.0).isActive = true
        imgStar2.rightAnchor.constraint(equalTo: imgStar1.leftAnchor, constant : -3.0).isActive = true
        
        pnlDriverProfileArea.addSubview(imgStar3)
        imgStar3.centerYAnchor.constraint(equalTo: imgStar1.centerYAnchor, constant : 0.0).isActive = true
        imgStar3.rightAnchor.constraint(equalTo: imgStar2.leftAnchor, constant : -3.0).isActive = true
        
        pnlDriverProfileArea.addSubview(imgStar4)
        imgStar4.centerYAnchor.constraint(equalTo: imgStar1.centerYAnchor, constant : 0.0).isActive = true
        imgStar4.rightAnchor.constraint(equalTo: imgStar3.leftAnchor, constant : -3.0).isActive = true
        
        pnlDriverProfileArea.addSubview(imgStar5)
        imgStar5.centerYAnchor.constraint(equalTo: imgStar1.centerYAnchor, constant : 0.0).isActive = true
        imgStar5.rightAnchor.constraint(equalTo: imgStar4.leftAnchor, constant : -3.0).isActive = true
        
        
        pnlDriverProfileArea.addSubview(lblRateCount)
        lblRateCount.topAnchor.constraint(equalTo: imgStar1.bottomAnchor, constant : 6.0).isActive = true
        lblRateCount.rightAnchor.constraint(equalTo: lblCarNo.rightAnchor, constant : 0.0).isActive = true
        
        btnAvatar.addTarget(self, action: #selector(TravelMonitoringView.btnAvatar_Clicked(_:)), for:.touchUpInside)
        btnCollapseProfile.addTarget(self, action: #selector(TravelMonitoringView.btnCollapseProfile_Clicked(_:)), for:.touchUpInside)
        
        
        chattingView.initLayout(completion)

        self.parent.view.layoutIfNeeded()
        self.parent.view.layoutSubviews()
                
    }
    
}
