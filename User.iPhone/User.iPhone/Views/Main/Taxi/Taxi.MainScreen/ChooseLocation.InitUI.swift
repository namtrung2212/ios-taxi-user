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



extension ChooseLocationView {
    
    func initControls(_ completion: (() -> ())?){
        
        let scrRect = UIScreen.main.bounds
        
        // Center Navigation Image
        let image = ImageHelper.resize(UIImage(named: "location3.png")!, newWidth: 58)
        centerLocation = UIImageView(image: image)
        centerLocation.translatesAutoresizingMaskIntoConstraints = false
      
        // Order Panel
        pnlOrderArea = UIView()
        
        pnlOrderArea.backgroundColor = UIColor(red: CGFloat(246/255.0), green: CGFloat(246/255.0), blue: CGFloat(246/255.0), alpha: 1.0)
        pnlOrderArea.layer.cornerRadius = 6.0
        pnlOrderArea.layer.borderColor = UIColor.gray.cgColor
        pnlOrderArea.layer.borderWidth = 0.5
        pnlOrderArea.layer.shadowOffset = CGSize(width: 2, height: 3)
        pnlOrderArea.layer.shadowOpacity = 0.5
        pnlOrderArea.layer.shadowRadius = 3
        
        pnlOrderArea.translatesAutoresizingMaskIntoConstraints = false
        pnlOrderArea.alpha = 1.0
        pnlOrderArea.isHidden = true
        pnlOrderArea.isUserInteractionEnabled = true
        
        // Pickup Button
        var imgPickupHere = ImageHelper.resize(UIImage(named: "pickuphere.png")!, newWidth: 120)
        btnPickupHere   = UIButton(type: UIButtonType.custom) as UIButton
        btnPickupHere.setImage(imgPickupHere, forState: .Normal)
        btnPickupHere.translatesAutoresizingMaskIntoConstraints = false
        
        // Drop Button
        let imgDropHere = ImageHelper.resize(UIImage(named: "drophere.png")!, newWidth: 120)
        btnDropHere   = UIButton(type: UIButtonType.custom) as UIButton
        btnDropHere.frame = CGRect(x: 0, y: 0, width: 120, height: 48.8)
        btnDropHere.setImage(imgDropHere, forState: .Normal)
        btnDropHere.translatesAutoresizingMaskIntoConstraints = false
        btnDropHere.isHidden = true
        
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
        
        // Path Statistic Left Button
        btnPathStatisticIcon   = UIButton(type: UIButtonType.custom) as UIButton
        btnPathStatisticIcon.setGMDIcon(GMDType.gmdLocalTaxi, forState: UIControlState())
        btnPathStatisticIcon.titleLabel?.font = btnPathStatisticIcon.titleLabel?.font.withSize(24)
        btnPathStatisticIcon.setTitleColor(UIColor(red: CGFloat(46.0/255.0), green: CGFloat(162.0/255.0), blue: CGFloat(214.0/255.0), alpha: 1.0), for: UIControlState())
        btnPathStatisticIcon.frame = CGRect(x: 35, y: 35, width: 35, height: 35)
        btnPathStatisticIcon.translatesAutoresizingMaskIntoConstraints = false
        
        // Path Statistic Label
        lblPathStatistic = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblPathStatistic.font = lblPathStatistic.font.withSize(12)
        lblPathStatistic.textColor = UIColor.darkGray
        lblPathStatistic.textAlignment = NSTextAlignment.center
        lblPathStatistic.text = ""
        lblPathStatistic.translatesAutoresizingMaskIntoConstraints = false
        lblPathStatistic.isHidden = true
        
        //  Path Statistic TextBox
        let imgDistanceTextBox = ImageHelper.resize(UIImage(named: "textbox1.png")!, newWidth: scrRect.width * 1.0)
        imgPathStatisticBG = UIImageView(image: imgDistanceTextBox)
        imgPathStatisticBG.translatesAutoresizingMaskIntoConstraints = false
        imgPathStatisticBG.isUserInteractionEnabled = true
        
        
        // Cancel Source Point Button
        let imgCancel1 = ImageHelper.resize(UIImage(named: "cancel-gray.png")!, newWidth: 20)
        btnPickupCancel  = UIButton(type: UIButtonType.custom) as UIButton
        btnPickupCancel.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        btnPickupCancel.setImage(imgCancel1, forState: .Normal)
        btnPickupCancel.translatesAutoresizingMaskIntoConstraints = false
        btnPickupCancel.isHidden = true
        
        // Cancel Destiny Point Button
        let imgCancel2 = ImageHelper.resize(UIImage(named: "cancel-gray.png")!, newWidth: 20)
        btnDropCancel  = UIButton(type: UIButtonType.custom) as UIButton
        btnDropCancel.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        btnDropCancel.setImage(imgCancel2, forState: .Normal)
        btnDropCancel.translatesAutoresizingMaskIntoConstraints = false
        btnDropCancel.isHidden = true
                
        // Bottom  Button Area
        pnlButtonArea = UIView()
        pnlButtonArea.translatesAutoresizingMaskIntoConstraints = false
        pnlButtonArea.isUserInteractionEnabled = true
        pnlButtonArea.isHidden = true
        
        
        // Quick Order Button
        let imgOrangeButton = ImageHelper.resize(UIImage(named: "SmallOrangeButton.png")!, newWidth: scrRect.width/2)
        btnQuickOrder   = UIButton(type: UIButtonType.custom) as UIButton
        btnQuickOrder.setTitle("ĐI NGAY", for: UIControlState())
        btnQuickOrder.setBackgroundImage(imgOrangeButton, forState: .Normal)
        btnQuickOrder.titleLabel!.font =   btnQuickOrder.titleLabel!.font.withSize(15)
        btnQuickOrder.titleLabel!.textAlignment = NSTextAlignment.center
        btnQuickOrder.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btnQuickOrder.titleLabel!.lineBreakMode = .byTruncatingTail
        btnQuickOrder.contentHorizontalAlignment = .center
        btnQuickOrder.contentVerticalAlignment = .center
        btnQuickOrder.contentMode = .scaleToFill
        btnQuickOrder.translatesAutoresizingMaskIntoConstraints = false
        
        // Custom Order Button
        let imgBlueButton = ImageHelper.resize(UIImage(named: "SmallBlueButton.png")!, newWidth: scrRect.width/2)
        btnCustomOrder   = UIButton(type: UIButtonType.custom) as UIButton
        btnCustomOrder.setTitle("XÁC NHẬN", for: UIControlState())
        btnCustomOrder.setBackgroundImage(imgBlueButton, forState: .Normal)
        btnCustomOrder.titleLabel!.font =   btnCustomOrder.titleLabel!.font.withSize(15)
        btnCustomOrder.titleLabel!.textAlignment = NSTextAlignment.center
        btnCustomOrder.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btnCustomOrder.titleLabel!.lineBreakMode = .byTruncatingTail
        btnCustomOrder.contentHorizontalAlignment = .center
        btnCustomOrder.contentVerticalAlignment = .center
        btnCustomOrder.contentMode = .scaleToFill
        btnCustomOrder.translatesAutoresizingMaskIntoConstraints = false
        
        
        btnPickupHere.addTarget(self, action: #selector(ChooseLocationView.btnPickupHere_Clicked(_:)), for:.touchUpInside)
        btnDropHere.addTarget(self, action: #selector(ChooseLocationView.btnDropHere_Clicked(_:)), for:.touchUpInside)
        lblPickupLocation.addTarget(self, action: #selector(ChooseLocationView.btnPickupIcon_Clicked(_:)), for:.touchUpInside)
        btnPickupIcon.addTarget(self, action: #selector(ChooseLocationView.btnPickupIcon_Clicked(_:)), for:.touchUpInside)
        btnDropIcon.addTarget(self, action: #selector(ChooseLocationView.btnDropIcon_Clicked(_:)), for:.touchUpInside)
        lblDropLocation.addTarget(self, action: #selector(ChooseLocationView.btnDropIcon_Clicked(_:)), for:.touchUpInside)
        btnPickupCancel.addTarget(self, action: #selector(ChooseLocationView.btnPickupCancel_Clicked(_:)), for:.touchUpInside)
        btnDropCancel.addTarget(self, action: #selector(ChooseLocationView.btnDropCancel_Clicked(_:)), for:.touchUpInside)
        btnQuickOrder.addTarget(self, action: #selector(ChooseLocationView.btnQuickOrder_Clicked(_:)), for:.touchUpInside)
        btnCustomOrder.addTarget(self, action: #selector(ChooseLocationView.btnCustomOrder_Clicked(_:)), for:.touchUpInside)
        
        completion?()
    }
    
    func initLayout(_ completion: (() -> ())?){
        
        
        let scrRect = UIScreen.main.bounds
        
        self.parent.view.addSubview(centerLocation)
        centerLocation.centerXAnchor.constraint(equalTo: self.parent.view.centerXAnchor, constant: 2.0).isActive = true
        centerLocation.centerYAnchor.constraint(equalTo: self.parent.view.centerYAnchor, constant: -73.0).isActive = true
        

        self.parent.view.addSubview(btnPickupHere)
        btnPickupHere.centerXAnchor.constraint(equalTo: self.centerLocation.centerXAnchor, constant: 60.0).isActive = true
        btnPickupHere.bottomAnchor.constraint(equalTo: self.centerLocation.topAnchor, constant: 7.0).isActive = true
        
        self.parent.view.addSubview(btnDropHere)
        btnDropHere.centerXAnchor.constraint(equalTo: self.centerLocation.centerXAnchor, constant: 60.0).isActive = true
        btnDropHere.bottomAnchor.constraint(equalTo: self.centerLocation.topAnchor, constant: 7.0).isActive = true
        
        
        self.parent.view.addSubview(pnlButtonArea)
        pnlButtonArea.widthAnchor.constraint(equalTo: self.parent.view.widthAnchor , constant : -13.0).isActive = true
        pnlButtonArea.leftAnchor.constraint(equalTo: self.parent.view.leftAnchor, constant: 8.0).isActive = true
        let bottom: CGFloat = (self.parent.tabBarController?.tabBar.isHidden)! == true ? 0 : (self.parent.tabBarController?.tabBar.frame.size.height)!
        pnlButtonArea.bottomAnchor.constraint(equalTo: self.parent.view.bottomAnchor, constant: -3 - bottom).isActive = true
        pnlButtonArea.initHeightConstraints(40,related: nil, second: nil, third: nil, fourth: nil)
        
        pnlButtonArea.addSubview(btnQuickOrder)
        btnQuickOrder.widthAnchor.constraint(equalTo: pnlButtonArea.widthAnchor, multiplier: 0.49).isActive = true
        btnQuickOrder.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnQuickOrder.leftAnchor.constraint(equalTo: pnlButtonArea.leftAnchor, constant: 0.0).isActive = true
        btnQuickOrder.topAnchor.constraint(equalTo: pnlButtonArea.topAnchor, constant: 0.0).isActive = true
        
        pnlButtonArea.addSubview(btnCustomOrder)
        btnCustomOrder.widthAnchor.constraint(equalTo: pnlButtonArea.widthAnchor, multiplier: 0.49).isActive = true
        btnCustomOrder.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnCustomOrder.rightAnchor.constraint(equalTo: pnlButtonArea.rightAnchor, constant: 0.0).isActive = true
        btnCustomOrder.centerYAnchor.constraint(equalTo: btnQuickOrder.centerYAnchor, constant: 0.0).isActive = true
        
        
        self.parent.view.addSubview(pnlOrderArea)
        pnlOrderArea.centerXAnchor.constraint(equalTo: self.parent.view.centerXAnchor, constant: 0).isActive = true
        bottomAnchorOrderArea =  pnlOrderArea.bottomAnchor.constraint(equalTo: pnlButtonArea.topAnchor, constant: -5.0)
        bottomAnchorOrderArea!.isActive = true
        topAnchorOrderArea =  pnlOrderArea.topAnchor.constraint(equalTo: self.parent.view.topAnchor, constant: 70.0)
        topAnchorOrderArea!.isActive = false
        
        
        pnlOrderArea.widthAnchor.constraint(equalToConstant: scrRect.width-18.0).isActive = true
        pnlOrderArea.heightAnchor.constraint(equalToConstant: 132).isActive = true
        
        self.pnlOrderArea.addSubview(btnPickupIcon)
        btnPickupIcon.topAnchor.constraint(equalTo: pnlOrderArea.topAnchor, constant: 13.0).isActive = true
        btnPickupIcon.leftAnchor.constraint(equalTo: pnlOrderArea.leftAnchor, constant : 8.0).isActive = true
        btnPickupIcon.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        self.pnlOrderArea.addSubview(imgPickupLocationBG)
        imgPickupLocationBG.centerYAnchor.constraint(equalTo: btnPickupIcon.centerYAnchor, constant: 0.0).isActive = true
        imgPickupLocationBG.leftAnchor.constraint(equalTo: btnPickupIcon.rightAnchor, constant : 2.0).isActive = true
        imgPickupLocationBG.widthAnchor.constraint(equalTo: pnlOrderArea.widthAnchor, constant : -57.0).isActive = true
        imgPickupLocationBG.heightAnchor.constraint(equalToConstant: 33).isActive = true
        
        self.pnlOrderArea.addSubview(lblPickupLocation)
        lblPickupLocation.centerYAnchor.constraint(equalTo: btnPickupIcon.centerYAnchor, constant: 0.0).isActive = true
        lblPickupLocation.leftAnchor.constraint(equalTo: imgPickupLocationBG.leftAnchor, constant : 5.0).isActive = true
        lblPickupLocation.widthAnchor.constraint(equalTo: imgPickupLocationBG.widthAnchor, constant : -28.0).isActive = true
        lblPickupLocation.heightAnchor.constraint(equalToConstant: 13).isActive = true
        
        self.pnlOrderArea.addSubview(btnPickupCancel)
        btnPickupCancel.centerYAnchor.constraint(equalTo: btnPickupIcon.centerYAnchor, constant: 0.0).isActive = true
        btnPickupCancel.rightAnchor.constraint(equalTo: pnlOrderArea.rightAnchor, constant : -18).isActive = true
        
        
        
        self.pnlOrderArea.addSubview(btnDropIcon)
        btnDropIcon.topAnchor.constraint(equalTo: btnPickupIcon.bottomAnchor, constant: 2.0).isActive = true
        btnDropIcon.leftAnchor.constraint(equalTo: btnPickupIcon.leftAnchor, constant : 0.0).isActive = true
        btnDropIcon.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        self.pnlOrderArea.addSubview(imgDropLocationBG)
        imgDropLocationBG.centerYAnchor.constraint(equalTo: btnDropIcon.centerYAnchor, constant: 0.0).isActive = true
        imgDropLocationBG.leftAnchor.constraint(equalTo: btnDropIcon.rightAnchor, constant : 2.0).isActive = true
        imgDropLocationBG.widthAnchor.constraint(equalTo: imgPickupLocationBG.widthAnchor, constant : 0.0).isActive = true
        imgDropLocationBG.heightAnchor.constraint(equalToConstant: 33).isActive = true
        
        self.pnlOrderArea.addSubview(lblDropLocation)
        lblDropLocation.centerYAnchor.constraint(equalTo: btnDropIcon.centerYAnchor, constant: 0.0).isActive = true
        lblDropLocation.leftAnchor.constraint(equalTo: imgDropLocationBG.leftAnchor, constant : 5.0).isActive = true
        lblDropLocation.widthAnchor.constraint(equalTo: imgDropLocationBG.widthAnchor, constant : -28.0).isActive = true
        lblDropLocation.heightAnchor.constraint(equalToConstant: 13).isActive = true
        
        self.pnlOrderArea.addSubview(btnDropCancel)
        btnDropCancel.centerYAnchor.constraint(equalTo: btnDropIcon.centerYAnchor, constant: 0.0).isActive = true
        btnDropCancel.rightAnchor.constraint(equalTo: pnlOrderArea.rightAnchor, constant : -18).isActive = true
        
        
        
        
        self.pnlOrderArea.addSubview(btnPathStatisticIcon)
        btnPathStatisticIcon.topAnchor.constraint(equalTo: btnDropIcon.bottomAnchor, constant: 2.0).isActive = true
        btnPathStatisticIcon.leftAnchor.constraint(equalTo: btnDropIcon.leftAnchor, constant : 0.0).isActive = true
        btnPathStatisticIcon.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        
        self.pnlOrderArea.addSubview(imgPathStatisticBG)
        imgPathStatisticBG.centerYAnchor.constraint(equalTo: btnPathStatisticIcon.centerYAnchor, constant: 0.0).isActive = true
        imgPathStatisticBG.leftAnchor.constraint(equalTo: imgDropLocationBG.leftAnchor, constant : 0.0).isActive = true
        imgPathStatisticBG.widthAnchor.constraint(equalTo: imgDropLocationBG.widthAnchor, constant : 0.0).isActive = true
        imgPathStatisticBG.heightAnchor.constraint(equalToConstant: 33).isActive = true
        
        self.pnlOrderArea.addSubview(lblPathStatistic)
        lblPathStatistic.centerYAnchor.constraint(equalTo: imgPathStatisticBG.centerYAnchor, constant: 0.0).isActive = true
        lblPathStatistic.leftAnchor.constraint(equalTo: imgPathStatisticBG.leftAnchor, constant : 5.0).isActive = true
        lblPathStatistic.widthAnchor.constraint(equalTo: imgDropLocationBG.widthAnchor, constant : -28.0).isActive = true
        lblPathStatistic.heightAnchor.constraint(equalToConstant: 13).isActive = true
        
        
        self.parent.view.layoutIfNeeded()
        completion?()
    }
    

}
