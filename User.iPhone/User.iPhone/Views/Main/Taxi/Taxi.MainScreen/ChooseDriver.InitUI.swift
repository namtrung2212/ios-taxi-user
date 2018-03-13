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



extension ChooseDriverView{
    
    
    func initControls(_ completion: (() -> ())?){
        
        let scrRect = UIScreen.main.bounds
        
        
        pnlGrayOverlay = UIView()
        pnlGrayOverlay.frame = scrRect
        pnlGrayOverlay.backgroundColor =  UIColor.darkGray
        pnlGrayOverlay.alpha = 0.6
        pnlGrayOverlay.isHidden = true
        pnlGrayOverlay.isUserInteractionEnabled = false
        
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
        
        // pnlDriverListArea
        
        pnlDriverListArea = UIView()
        pnlDriverListArea.backgroundColor = UIColor(red: CGFloat(125/255.0), green: CGFloat(187/255.0), blue: CGFloat(233/255.0), alpha: 1.0)
        pnlDriverListArea.layer.cornerRadius = 6.0
        pnlDriverListArea.layer.borderColor = UIColor.gray.cgColor
        pnlDriverListArea.layer.borderWidth = 0.5
        pnlDriverListArea.layer.shadowOffset = CGSize(width: 2, height: 3)
        pnlDriverListArea.layer.shadowOpacity = 0.5
        pnlDriverListArea.layer.shadowRadius = 3
        pnlDriverListArea.translatesAutoresizingMaskIntoConstraints = false
        pnlDriverListArea.alpha = 1.0
        pnlDriverListArea.isHidden = true
        pnlDriverListArea.isUserInteractionEnabled = true
        
        lblDriverList = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblDriverList.font = lblDriverList.font.withSize(15)
        lblDriverList.text = "DANH SÁCH TÀI XẾ PHÙ HỢP"
        lblDriverList.textColor = UIColor.white
        lblDriverList.textAlignment = NSTextAlignment.center
        lblDriverList.translatesAutoresizingMaskIntoConstraints = false
        
        // Cancel Order Button
        let imgOrangeButton = ImageHelper.resize(UIImage(named: "OrangeButton.png")!, newWidth: scrRect.width)
        btnCancelOrder   = UIButton(type: UIButtonType.custom) as UIButton
        btnCancelOrder.setTitle("HỦY YÊU CẦU", for: UIControlState())
        btnCancelOrder.setBackgroundImage(imgOrangeButton, forState: .Normal)
        btnCancelOrder.titleLabel!.font =   btnCancelOrder.titleLabel!.font.withSize(15)
        btnCancelOrder.titleLabel!.textAlignment = NSTextAlignment.center
        btnCancelOrder.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btnCancelOrder.titleLabel!.lineBreakMode = .byTruncatingTail
        btnCancelOrder.contentHorizontalAlignment = .center
        btnCancelOrder.contentVerticalAlignment = .center
        btnCancelOrder.contentMode = .scaleToFill
        btnCancelOrder.translatesAutoresizingMaskIntoConstraints = false
        btnCancelOrder.isHidden = true
        
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
        lblPickupLocation = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblPickupLocation.font = lblPickupLocation.font.withSize(12)
        lblPickupLocation.textColor = UIColor.darkGray
        lblPickupLocation.textAlignment = NSTextAlignment.center
        lblPickupLocation.text = ""
        lblPickupLocation.translatesAutoresizingMaskIntoConstraints = false
        
        lblPickupTime = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblPickupTime.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        lblPickupTime.textColor = UIColor(red: 73.0/255.0, green: 139.0/255.0, blue: 199.0/255.0, alpha: 1.0)
        lblPickupTime.textAlignment = NSTextAlignment.center
        lblPickupTime.text = "Khởi hành : "
        lblPickupTime.translatesAutoresizingMaskIntoConstraints = false
        
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
        lblDropLocation = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblDropLocation.font = lblDropLocation.font.withSize(12)
        lblDropLocation.textColor = UIColor.darkGray
        lblDropLocation.textAlignment = NSTextAlignment.center
        lblDropLocation.text = ""
        lblDropLocation.translatesAutoresizingMaskIntoConstraints = false
        
        // super.init(nibName: nil, bundle: nil)
        
        driverTable = ChooseDriverTable(parent: self)
        
        
        btnCancelOrder.addTarget(self, action: #selector(ChooseDriverView.btnCancelOrder_Clicked(_:)), for:.touchUpInside)
        
        completion?()
    }
    
    func initLayout(_ completion: (() -> ())?){
        
        let scrRect = UIScreen.main.bounds
        
        self.parent.view.addSubview(pnlGrayOverlay)
        
        self.parent.view.addSubview(pnlOrderArea)
        pnlOrderArea.centerXAnchor.constraint(equalTo: self.parent.view.centerXAnchor, constant: 0).isActive = true
        pnlOrderArea.topAnchor.constraint(equalTo: self.parent.view.topAnchor, constant: 70).isActive = true
        pnlOrderArea.widthAnchor.constraint(equalToConstant: scrRect.width-18.0).isActive = true
        pnlOrderArea.heightAnchor.constraint(equalToConstant: 105).isActive = true
        
        
        self.parent.view.addSubview(btnCancelOrder)
        btnCancelOrder.widthAnchor.constraint(equalTo: self.parent.view.widthAnchor , constant : -13.0).isActive = true
        btnCancelOrder.leftAnchor.constraint(equalTo: self.parent.view.leftAnchor, constant: 7.0).isActive = true
        btnCancelOrder.bottomAnchor.constraint(equalTo: self.parent.view.bottomAnchor, constant: -5).isActive = true
        btnCancelOrder.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.parent.view.addSubview(pnlDriverListArea)
        pnlDriverListArea.centerXAnchor.constraint(equalTo: self.parent.view.centerXAnchor, constant: 0).isActive = true
        pnlDriverListArea.topAnchor.constraint(equalTo: pnlOrderArea.bottomAnchor , constant: 8.0).isActive = true
        pnlDriverListArea.bottomAnchor.constraint(equalTo: btnCancelOrder.topAnchor , constant: -5.0).isActive = true
        pnlDriverListArea.widthAnchor.constraint(equalToConstant: scrRect.width-18.0).isActive = true
        
      //  let bottom: CGFloat = (self.parent.tabBarController?.tabBar.hidden)! == false ? 0 : (self.parent.tabBarController?.tabBar.frame.size.height)!
        //pnlDriverListArea.heightAnchor.constraintEqualToConstant(scrRect.height - 60 - 60 - 90 - 7 - 50 + bottom).active = true
        
        pnlDriverListArea.addSubview(lblDriverList)
        lblDriverList.widthAnchor.constraint(equalTo: pnlDriverListArea.widthAnchor, constant : -20.0).isActive = true
        lblDriverList.centerXAnchor.constraint(equalTo: self.parent.view.centerXAnchor, constant: 0).isActive = true
        lblDriverList.topAnchor.constraint(equalTo: pnlDriverListArea.topAnchor, constant : 10.0).isActive = true
        lblDriverList.heightAnchor.constraint(equalToConstant: 50)

        
        
        
        self.pnlOrderArea.addSubview(btnPickupIcon)
        btnPickupIcon.topAnchor.constraint(equalTo: pnlOrderArea.topAnchor, constant: 8.0).isActive = true
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
        
        
        self.pnlOrderArea.addSubview(lblPickupTime)
        lblPickupTime.topAnchor.constraint(equalTo: imgDropLocationBG.bottomAnchor, constant: 5.0).isActive = true
        lblPickupTime.centerXAnchor.constraint(equalTo: pnlOrderArea.centerXAnchor, constant : 0.0).isActive = true
        lblPickupTime.widthAnchor.constraint(equalTo: pnlOrderArea.widthAnchor, constant : -18.0).isActive = true
        lblPickupTime.heightAnchor.constraint(equalToConstant: 13).isActive = true
        

        
        
        driverTable.initLayout{
            self.parent.view.layoutIfNeeded()
            completion?()
        }
    }

}
