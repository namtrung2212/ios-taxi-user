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


extension CustomOrderView {
    
    
    func initControls(_ completion: (() -> ())?){
        
        let scrRect = UIScreen.main.bounds
        
        pnlGrayOverlay = UIView()
        pnlGrayOverlay.frame = scrRect
        pnlGrayOverlay.backgroundColor =  UIColor.darkGray
        pnlGrayOverlay.alpha = 0.6
        pnlGrayOverlay.isHidden = true
        pnlGrayOverlay.isUserInteractionEnabled = false
        
        // Order Panel
        
        pnlCustomOrderArea = UIView()
        pnlCustomOrderArea.backgroundColor = UIColor(red: CGFloat(246/255.0), green: CGFloat(246/255.0), blue: CGFloat(246/255.0), alpha: 1.0)
        pnlCustomOrderArea.layer.cornerRadius = 6.0
        pnlCustomOrderArea.layer.borderColor = UIColor.gray.cgColor
        pnlCustomOrderArea.layer.borderWidth = 0.5
        pnlCustomOrderArea.layer.shadowOffset = CGSize(width: 2, height: 3)
        pnlCustomOrderArea.layer.shadowOpacity = 0.5
        pnlCustomOrderArea.layer.shadowRadius = 3
        pnlCustomOrderArea.translatesAutoresizingMaskIntoConstraints = false
        pnlCustomOrderArea.alpha = 1.0
        pnlCustomOrderArea.isHidden = true
        pnlCustomOrderArea.isUserInteractionEnabled = true
        
        
        // Bottom  Button Area
        pnlButtonArea = UIView()
        pnlButtonArea.translatesAutoresizingMaskIntoConstraints = false
        pnlButtonArea.isUserInteractionEnabled = true
        pnlButtonArea.isHidden = true
        
        
        
        // Quick Order Button
        let imgOrangeButton = ImageHelper.resize(UIImage(named: "SmallOrangeButton.png")!, newWidth: nil)
        btnCancelOrder   = UIButton(type: UIButtonType.custom) as UIButton
        btnCancelOrder.setTitle("HỦY ", for: UIControlState())
        btnCancelOrder.setBackgroundImage(imgOrangeButton, forState: .Normal)
        btnCancelOrder.titleLabel!.font =   btnCancelOrder.titleLabel!.font.withSize(15)
        btnCancelOrder.titleLabel!.textAlignment = NSTextAlignment.center
        btnCancelOrder.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btnCancelOrder.titleLabel!.lineBreakMode = .byTruncatingTail
        btnCancelOrder.contentHorizontalAlignment = .center
        btnCancelOrder.contentVerticalAlignment = .center
        btnCancelOrder.contentMode = .scaleToFill
        btnCancelOrder.translatesAutoresizingMaskIntoConstraints = false
        btnCancelOrder.isUserInteractionEnabled = true
        
        // Custom Order Button
        let imgBlueButton = ImageHelper.resize(UIImage(named: "SmallBlueButton.png")!, newWidth: nil)
        btnCreateOrder   = UIButton(type: UIButtonType.custom) as UIButton
        btnCreateOrder.setTitle("GỬI YÊU CẦU", for: UIControlState())
        btnCreateOrder.setBackgroundImage(imgBlueButton, forState: .Normal)
        btnCreateOrder.titleLabel!.font =   btnCreateOrder.titleLabel!.font.withSize(15)
        btnCreateOrder.titleLabel!.textAlignment = NSTextAlignment.center
        btnCreateOrder.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btnCreateOrder.titleLabel!.lineBreakMode = .byTruncatingTail
        btnCreateOrder.contentHorizontalAlignment = .center
        btnCreateOrder.contentVerticalAlignment = .center
        btnCreateOrder.contentMode = .scaleToFill
        btnCreateOrder.translatesAutoresizingMaskIntoConstraints = false
        btnCreateOrder.isUserInteractionEnabled = true
        
        
        
        line1 = CAShapeLayer()
        line1.fillColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1).cgColor
        
        line2 = CAShapeLayer()
        line2.fillColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1).cgColor
        
        line3 = CAShapeLayer()
        line3.fillColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1).cgColor
        
        line4 = CAShapeLayer()
        line4.fillColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1).cgColor
        
        // Return Button
        btnReturn   = UIButton(type: UIButtonType.custom) as UIButton
        btnReturn.setTitle("Khứ hồi", for: UIControlState())
        btnReturn.titleLabel!.font =   btnReturn.titleLabel!.font.withSize(13)
        btnReturn.titleLabel!.textAlignment = NSTextAlignment.center
        btnReturn.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btnReturn.titleLabel!.lineBreakMode = .byTruncatingTail
        btnReturn.contentHorizontalAlignment = .center
        btnReturn.contentVerticalAlignment = .center
        btnReturn.contentMode = .scaleToFill
        btnReturn.translatesAutoresizingMaskIntoConstraints = false
        btnReturn.isUserInteractionEnabled = true
        btnReturn.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallBlueButton.png")!, newWidth: nil), forState: UIControlState.Selected)
        btnReturn.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallFlatButton.png")!, newWidth: nil), forState: UIControlState.Normal)
        btnReturn.setTitleColor(UIColor.black, for: UIControlState())
        btnReturn.setTitleColor(UIColor.white, for: .selected)
        
        
        // OneWay Button
        btnOneWay   = UIButton(type: UIButtonType.custom) as UIButton
        btnOneWay.setTitle("Một chiều", for: UIControlState())
        btnOneWay.titleLabel!.font =   btnOneWay.titleLabel!.font.withSize(13)
        btnOneWay.titleLabel!.textAlignment = NSTextAlignment.center
        btnOneWay.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btnOneWay.titleLabel!.lineBreakMode = .byTruncatingTail
        btnOneWay.contentHorizontalAlignment = .center
        btnOneWay.contentVerticalAlignment = .center
        btnOneWay.contentMode = .scaleToFill
        btnOneWay.translatesAutoresizingMaskIntoConstraints = false
        btnOneWay.isUserInteractionEnabled = true
        btnOneWay.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallBlueButton.png")!, newWidth: nil ), forState: UIControlState.Selected)
        btnOneWay.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallFlatButton.png")!, newWidth: nil ), forState: UIControlState.Normal)
        btnOneWay.setTitleColor(UIColor.black, for: UIControlState())
        btnOneWay.setTitleColor(UIColor.white, for: .selected)
        
        
        // AllSeat Button
        btnAllSeat   = UIButton(type: UIButtonType.custom) as UIButton
        btnAllSeat.setTitle("Tất cả", for: UIControlState())
        btnAllSeat.titleLabel!.font =   btnAllSeat.titleLabel!.font.withSize(13)
        btnAllSeat.titleLabel!.textAlignment = NSTextAlignment.center
        btnAllSeat.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btnAllSeat.titleLabel!.lineBreakMode = .byTruncatingTail
        btnAllSeat.contentHorizontalAlignment = .center
        btnAllSeat.contentVerticalAlignment = .center
        btnAllSeat.contentMode = .scaleToFill
        btnAllSeat.translatesAutoresizingMaskIntoConstraints = false
        btnAllSeat.isUserInteractionEnabled = true
        btnAllSeat.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallBlueButton2.png")!, newWidth: nil ), forState: UIControlState.Selected)
        btnAllSeat.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallFlatButton2.png")!, newWidth: nil ), forState: UIControlState.Normal)
        btnAllSeat.setTitleColor(UIColor.black, for: UIControlState())
        btnAllSeat.setTitleColor(UIColor.white, for: .selected)
        
        
        // 4 Seats Button
        btn4Seat   = UIButton(type: UIButtonType.custom) as UIButton
        btn4Seat.setTitle("4 chỗ", for: UIControlState())
        btn4Seat.titleLabel!.font =   btn4Seat.titleLabel!.font.withSize(13)
        btn4Seat.titleLabel!.textAlignment = NSTextAlignment.center
        btn4Seat.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btn4Seat.titleLabel!.lineBreakMode = .byTruncatingTail
        btn4Seat.contentHorizontalAlignment = .center
        btn4Seat.contentVerticalAlignment = .center
        btn4Seat.contentMode = .scaleToFill
        btn4Seat.translatesAutoresizingMaskIntoConstraints = false
        btn4Seat.isUserInteractionEnabled = true
        btn4Seat.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallBlueButton2.png")!, newWidth: nil ), forState: UIControlState.Selected)
        btn4Seat.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallFlatButton2.png")!, newWidth: nil ), forState: UIControlState.Normal)
        btn4Seat.setTitleColor(UIColor.black, for: UIControlState())
        btn4Seat.setTitleColor(UIColor.white, for: .selected)
        
        
        
        // 7 Seats Button
        btn7Seat   = UIButton(type: UIButtonType.custom) as UIButton
        btn7Seat.setTitle("7 chỗ", for: UIControlState())
        btn7Seat.titleLabel!.font =   btn7Seat.titleLabel!.font.withSize(13)
        btn7Seat.titleLabel!.textAlignment = NSTextAlignment.center
        btn7Seat.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btn7Seat.titleLabel!.lineBreakMode = .byTruncatingTail
        btn7Seat.contentHorizontalAlignment = .center
        btn7Seat.contentVerticalAlignment = .center
        btn7Seat.contentMode = .scaleToFill
        btn7Seat.translatesAutoresizingMaskIntoConstraints = false
        btn7Seat.isUserInteractionEnabled = true
        btn7Seat.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallBlueButton2.png")!, newWidth: nil ), forState: UIControlState.Selected)
        btn7Seat.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallFlatButton2.png")!, newWidth: nil ), forState: UIControlState.Normal)
        btn7Seat.setTitleColor(UIColor.black, for: UIControlState())
        btn7Seat.setTitleColor(UIColor.white, for: .selected)
        
        
        // Filter by Type Button
        btnPopular   = UIButton(type: UIButtonType.custom) as UIButton
        btnPopular.setTitle("Phổ thông", for: UIControlState())
        btnPopular.titleLabel!.font =   btnPopular.titleLabel!.font.withSize(13)
        btnPopular.titleLabel!.textAlignment = NSTextAlignment.center
        btnPopular.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btnPopular.titleLabel!.lineBreakMode = .byTruncatingTail
        btnPopular.contentHorizontalAlignment = .center
        btnPopular.contentVerticalAlignment = .center
        btnPopular.contentMode = .scaleToFill
        btnPopular.translatesAutoresizingMaskIntoConstraints = false
        btnPopular.isUserInteractionEnabled = true
        btnPopular.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallBlueButton2.png")!, newWidth: nil ), forState: UIControlState.Selected)
        btnPopular.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallFlatButton2.png")!, newWidth: nil ), forState: UIControlState.Normal)
        btnPopular.setTitleColor(UIColor.black, for: UIControlState())
        btnPopular.setTitleColor(UIColor.white, for: .selected)
        
        
        
        // Filter by Type Button
        btnLuxury   = UIButton(type: UIButtonType.custom) as UIButton
        btnLuxury.setTitle("Cao cấp", for: UIControlState())
        btnLuxury.titleLabel!.font =   btnLuxury.titleLabel!.font.withSize(13)
        btnLuxury.titleLabel!.textAlignment = NSTextAlignment.center
        btnLuxury.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btnLuxury.titleLabel!.lineBreakMode = .byTruncatingTail
        btnLuxury.contentHorizontalAlignment = .center
        btnLuxury.contentVerticalAlignment = .center
        btnLuxury.contentMode = .scaleToFill
        btnLuxury.translatesAutoresizingMaskIntoConstraints = false
        btnLuxury.isUserInteractionEnabled = true
        btnLuxury.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallBlueButton2.png")!, newWidth: nil ), forState: UIControlState.Selected)
        btnLuxury.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallFlatButton2.png")!, newWidth: nil ), forState: UIControlState.Normal)
        btnLuxury.setTitleColor(UIColor.black, for: UIControlState())
        btnLuxury.setTitleColor(UIColor.white, for: .selected)
        
        
        
        // Filter by Type Button
        btnEconomic   = UIButton(type: UIButtonType.custom) as UIButton
        btnEconomic.setTitle("Giá rẻ", for: UIControlState())
        btnEconomic.titleLabel!.font =   btnEconomic.titleLabel!.font.withSize(13)
        btnEconomic.titleLabel!.textAlignment = NSTextAlignment.center
        btnEconomic.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btnEconomic.titleLabel!.lineBreakMode = .byTruncatingTail
        btnEconomic.contentHorizontalAlignment = .center
        btnEconomic.contentVerticalAlignment = .center
        btnEconomic.contentMode = .scaleToFill
        btnEconomic.translatesAutoresizingMaskIntoConstraints = false
        btnEconomic.isUserInteractionEnabled = true
        btnEconomic.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallBlueButton2.png")!, newWidth: nil ), forState: UIControlState.Selected)
        btnEconomic.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallFlatButton2.png")!, newWidth: nil ), forState: UIControlState.Normal)
        btnEconomic.setTitleColor(UIColor.black, for: UIControlState())
        btnEconomic.setTitleColor(UIColor.white, for: .selected)
        
        
        
        // Immediately Button
        btnImmediately   = UIButton(type: UIButtonType.custom) as UIButton
        btnImmediately.setTitle("Đi ngay", for: UIControlState())
        btnImmediately.titleLabel!.font =   btnImmediately.titleLabel!.font.withSize(13)
        btnImmediately.titleLabel!.textAlignment = NSTextAlignment.center
        btnImmediately.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btnImmediately.titleLabel!.lineBreakMode = .byTruncatingTail
        btnImmediately.contentHorizontalAlignment = .center
        btnImmediately.contentVerticalAlignment = .center
        btnImmediately.contentMode = .scaleToFill
        btnImmediately.translatesAutoresizingMaskIntoConstraints = false
        btnImmediately.isUserInteractionEnabled = true
        btnImmediately.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallBlueButton2.png")!, newWidth: nil ), forState: UIControlState.Selected)
        btnImmediately.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallFlatButton2.png")!, newWidth: nil ), forState: UIControlState.Normal)
        btnImmediately.setTitleColor(UIColor.black, for: UIControlState())
        btnImmediately.setTitleColor(UIColor.white, for: .selected)
        
        
        
        // Later Button
        btnLater   = UIButton(type: UIButtonType.custom) as UIButton
        btnLater.setTitle("Khởi hành trễ", for: UIControlState())
        btnLater.titleLabel!.font =   btnLater.titleLabel!.font.withSize(13)
        btnLater.titleLabel!.textAlignment = NSTextAlignment.center
        btnLater.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btnLater.titleLabel!.lineBreakMode = .byTruncatingTail
        btnLater.contentHorizontalAlignment = .center
        btnLater.contentVerticalAlignment = .center
        btnLater.contentMode = .scaleToFill
        btnLater.translatesAutoresizingMaskIntoConstraints = false
        btnLater.isUserInteractionEnabled = true
        btnLater.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallBlueButton.png")!, newWidth: nil ), forState: UIControlState.Selected)
        btnLater.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallFlatButton.png")!, newWidth: nil ), forState: UIControlState.Normal)
        btnLater.setTitleColor(UIColor.black, for: UIControlState())
        btnLater.setTitleColor(UIColor.white, for: .selected)
        
        
        
        //  PickupTime TextBox
        let imgPickupTextBox = ImageHelper.resize(UIImage(named: "textbox1.png")!, newWidth: scrRect.width * 1.0)
        imgPickupTimeBG = UIImageView(image: imgPickupTextBox)
        imgPickupTimeBG.translatesAutoresizingMaskIntoConstraints = false
        imgPickupTimeBG.isUserInteractionEnabled = true
        
        // PickupTime Label
        lblPickupTimeValue   = UIButton(type: UIButtonType.custom) as UIButton
        lblPickupTimeValue.frame = CGRect(x: 0, y: 0, width: 0, height: 10)
        lblPickupTimeValue.setTitle(" ", for: UIControlState())
        lblPickupTimeValue.setTitleColor(UIColor.darkGray, for: UIControlState())
        lblPickupTimeValue.titleLabel!.font = lblPickupTimeValue.titleLabel!.font.withSize(14)
        lblPickupTimeValue.titleLabel!.textAlignment = NSTextAlignment.center
        lblPickupTimeValue.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        lblPickupTimeValue.titleLabel!.lineBreakMode = .byTruncatingTail
        lblPickupTimeValue.contentHorizontalAlignment = .center
        lblPickupTimeValue.translatesAutoresizingMaskIntoConstraints = false
        
        
        // PickupTime Label
        lblPickupTime = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblPickupTime.font = lblPickupTime.font.withSize(14)
        lblPickupTime.textColor = UIColor.darkGray
        lblPickupTime.textAlignment = NSTextAlignment.left
        lblPickupTime.text = "Đón lúc "
        lblPickupTime.translatesAutoresizingMaskIntoConstraints = false
        
        
        btnPickupTime  = UIButton(type: UIButtonType.custom) as UIButton
        btnPickupTime.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        btnPickupTime.setFAIcon(FAType.faCalendar, forState: UIControlState())
        btnPickupTime.translatesAutoresizingMaskIntoConstraints = false
        btnPickupTime.titleLabel?.font = btnPickupTime.titleLabel?.font.withSize(22)
        btnPickupTime.setTitleColor(UIColor(red: CGFloat(46.0/255.0), green: CGFloat(162.0/255.0), blue: CGFloat(214.0/255.0), alpha: 1.0), for: UIControlState())
        
        
        
        // Clock Icon
        icoClock = UIImageView(image: ImageHelper.resize(UIImage(named: "ClockIcon.png")!, newWidth: 28))
        icoClock.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        icoClock.translatesAutoresizingMaskIntoConstraints = false
        
        // Seat Icon
        icoSeat = UIImageView(image: ImageHelper.resize(UIImage(named: "SeatIcon.png")!, newWidth: 28))
        icoSeat.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        icoSeat.translatesAutoresizingMaskIntoConstraints = false
        
        // Quality Icon
        icoQuality = UIImageView(image: ImageHelper.resize(UIImage(named: "QualityIcon.png")!, newWidth: 28))
        icoQuality.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        icoQuality.translatesAutoresizingMaskIntoConstraints = false
        
        // Clock Label
        lblClock = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblClock.font = lblClock.font.withSize(14)
        lblClock.textColor = UIColor.darkGray
        lblClock.textAlignment = NSTextAlignment.left
        lblClock.text = "Thời gian khởi hành"
        lblClock.translatesAutoresizingMaskIntoConstraints = false
        
        
        // Seat Label
        lblSeat = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblSeat.font = lblSeat.font.withSize(14)
        lblSeat.textColor = UIColor.darkGray
        lblSeat.textAlignment = NSTextAlignment.left
        lblSeat.text = "Số lượng ghế"
        lblSeat.translatesAutoresizingMaskIntoConstraints = false
        
        
        // Quality Label
        lblQuality = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblQuality.font = lblClock.font.withSize(14)
        lblQuality.textColor = UIColor.darkGray
        lblQuality.textAlignment = NSTextAlignment.left
        lblQuality.text = "Chất lượng xe"
        lblQuality.translatesAutoresizingMaskIntoConstraints = false
        
        btnCancelOrder.addTarget(self, action: #selector(CustomOrderView.btnCancelOrder_Clicked(_:)), for:.touchUpInside)
        btnCreateOrder.addTarget(self, action: #selector(CustomOrderView.btnCreateOrder_Clicked(_:)), for:.touchUpInside)
        btnOneWay.addTarget(self, action: #selector(CustomOrderView.btnOneWay_Clicked(_:)), for:.touchUpInside)
        btnReturn.addTarget(self, action: #selector(CustomOrderView.btnReturn_Clicked(_:)), for:.touchUpInside)
        
        
        btnAllSeat.addTarget(self, action: #selector(CustomOrderView.btnAllSeat_Clicked(_:)), for:.touchUpInside)
        btn4Seat.addTarget(self, action: #selector(CustomOrderView.btn4Seat_Clicked(_:)), for:.touchUpInside)
        btn7Seat.addTarget(self, action: #selector(CustomOrderView.btn7Seat_Clicked(_:)), for:.touchUpInside)
        btnPopular.addTarget(self, action: #selector(CustomOrderView.btnPopular_Clicked(_:)), for:.touchUpInside)
        btnLuxury.addTarget(self, action: #selector(CustomOrderView.btnLuxury_Clicked(_:)), for:.touchUpInside)
        btnEconomic.addTarget(self, action: #selector(CustomOrderView.btnEconomic_Clicked(_:)), for:.touchUpInside)
        btnImmediately.addTarget(self, action: #selector(CustomOrderView.btnImmediately_Clicked(_:)), for:.touchUpInside)
        btnLater.addTarget(self, action: #selector(CustomOrderView.btnLater_Clicked(_:)), for:.touchUpInside)
        lblPickupTimeValue.addTarget(self, action: #selector(CustomOrderView.lblPickupTime_Clicked(_:)), for:.touchUpInside)
        btnPickupTime.addTarget(self, action: #selector(CustomOrderView.lblPickupTime_Clicked(_:)), for:.touchUpInside)
        
        self.btnOneWay.isSelected = true
        self.btnAllSeat.isSelected = true
        self.btnPopular.isSelected = true
        self.btnImmediately.isSelected = true
        
        
        completion?()
    }
    
    func initLayout(_ completion: (() -> ())?){
        
        
        let scrRect = UIScreen.main.bounds
        
        self.parent.view.addSubview(pnlGrayOverlay)
        
        self.parent.view.addSubview(pnlCustomOrderArea)
        pnlCustomOrderArea.centerXAnchor.constraint(equalTo: self.parent.view.centerXAnchor, constant: 0).isActive = true
        pnlCustomOrderArea.topAnchor.constraint(equalTo: self.parent.chooseLocationView.pnlOrderArea.bottomAnchor , constant: 5.0).isActive = true
        pnlCustomOrderArea.widthAnchor.constraint(equalToConstant: scrRect.width-18.0).isActive = true
        pnlCustomOrderArea.heightAnchor.constraint(equalToConstant: scrRect.height-250).isActive = true
        
        
        pnlCustomOrderArea.addSubview(btnOneWay)
        btnOneWay.widthAnchor.constraint(equalTo: pnlCustomOrderArea.widthAnchor, multiplier: 0.432).isActive = true
        btnOneWay.heightAnchor.constraint(equalTo: self.parent.view.heightAnchor, multiplier: 0.06).isActive = true
        btnOneWay.leftAnchor.constraint(equalTo: pnlCustomOrderArea.leftAnchor, constant: 17.0).isActive = true
        btnOneWay.topAnchor.constraint(equalTo: pnlCustomOrderArea.topAnchor, constant: 10.0).isActive = true
        
        pnlCustomOrderArea.addSubview(btnReturn)
        btnReturn.widthAnchor.constraint(equalTo: pnlCustomOrderArea.widthAnchor, multiplier: 0.432).isActive = true
        btnReturn.heightAnchor.constraint(equalTo: self.parent.view.heightAnchor, multiplier: 0.06).isActive = true
        btnReturn.rightAnchor.constraint(equalTo: pnlCustomOrderArea.rightAnchor, constant: -17.0).isActive = true
        btnReturn.centerYAnchor.constraint(equalTo: btnOneWay.centerYAnchor, constant: 0.0).isActive = true
        
        line1.path = UIBezierPath(roundedRect: CGRect(x: 20, y: scrRect.height * 0.087, width: scrRect.width-57.0, height: 1), cornerRadius: 0).cgPath
        pnlCustomOrderArea.layer.addSublayer(line1)
        
        pnlCustomOrderArea.addSubview(icoQuality)
        icoQuality.leftAnchor.constraint(equalTo: pnlCustomOrderArea.leftAnchor, constant: 20.0).isActive = true
        icoQuality.topAnchor.constraint(equalTo: pnlCustomOrderArea.topAnchor, constant: (scrRect.height * 0.087) + 5).isActive = true
        
        pnlCustomOrderArea.addSubview(lblQuality)
        lblQuality.leftAnchor.constraint(equalTo: icoQuality.leftAnchor, constant: 30.0).isActive = true
        lblQuality.centerYAnchor.constraint(equalTo: icoQuality.centerYAnchor, constant: 0.0).isActive = true
        
        
        pnlCustomOrderArea.addSubview(btnPopular)
        btnPopular.widthAnchor.constraint(equalTo: pnlCustomOrderArea.widthAnchor, multiplier: 0.275).isActive = true
        btnPopular.heightAnchor.constraint(equalTo: self.parent.view.heightAnchor, multiplier: 0.06).isActive = true
        btnPopular.leftAnchor.constraint(equalTo: pnlCustomOrderArea.leftAnchor, constant:  17.0).isActive = true
        btnPopular.topAnchor.constraint( equalTo: icoQuality.bottomAnchor, constant: 4).isActive = true
        
        pnlCustomOrderArea.addSubview(btnEconomic)
        btnEconomic.widthAnchor.constraint(equalTo: pnlCustomOrderArea.widthAnchor, multiplier: 0.275).isActive = true
        btnEconomic.heightAnchor.constraint(equalTo: self.parent.view.heightAnchor, multiplier: 0.06).isActive = true
        btnEconomic.centerXAnchor.constraint(equalTo: self.parent.view.centerXAnchor, constant: 0.0).isActive = true
        btnEconomic.centerYAnchor.constraint(equalTo: btnPopular.centerYAnchor, constant: 0.0).isActive = true
        
        pnlCustomOrderArea.addSubview(btnLuxury)
        btnLuxury.widthAnchor.constraint(equalTo: pnlCustomOrderArea.widthAnchor, multiplier: 0.275).isActive = true
        btnLuxury.heightAnchor.constraint(equalTo: self.parent.view.heightAnchor, multiplier: 0.06).isActive = true
        btnLuxury.rightAnchor.constraint(equalTo: pnlCustomOrderArea.rightAnchor, constant: -17.0).isActive = true
        btnLuxury.centerYAnchor.constraint(equalTo: btnEconomic.centerYAnchor, constant: 0.0).isActive = true
        
        line2.path = UIBezierPath(roundedRect: CGRect(x: 20, y: scrRect.height * 0.225, width: scrRect.width-57.0, height: 1), cornerRadius: 0).cgPath
        pnlCustomOrderArea.layer.addSublayer(line2)
        
        
        pnlCustomOrderArea.addSubview(icoSeat)
        icoSeat.leftAnchor.constraint(equalTo: pnlCustomOrderArea.leftAnchor, constant: 20.0).isActive = true
        icoSeat.topAnchor.constraint(equalTo: pnlCustomOrderArea.topAnchor, constant: (scrRect.height * 0.225) + 5).isActive = true
        
        pnlCustomOrderArea.addSubview(lblSeat)
        lblSeat.leftAnchor.constraint(equalTo: icoSeat.leftAnchor, constant: 30.0).isActive = true
        lblSeat.centerYAnchor.constraint(equalTo: icoSeat.centerYAnchor, constant: 0.0).isActive = true
        
        pnlCustomOrderArea.addSubview(btn4Seat)
        btn4Seat.widthAnchor.constraint(equalTo: pnlCustomOrderArea.widthAnchor, multiplier: 0.275).isActive = true
        btn4Seat.heightAnchor.constraint(equalTo: self.parent.view.heightAnchor, multiplier: 0.06).isActive = true
        btn4Seat.leftAnchor.constraint(equalTo: pnlCustomOrderArea.leftAnchor, constant: 17.0).isActive = true
        btn4Seat.topAnchor.constraint(equalTo: icoSeat.bottomAnchor, constant: 4).isActive = true
        
        pnlCustomOrderArea.addSubview(btn7Seat)
        btn7Seat.widthAnchor.constraint(equalTo: pnlCustomOrderArea.widthAnchor, multiplier: 0.275).isActive = true
        btn7Seat.heightAnchor.constraint(equalTo: self.parent.view.heightAnchor, multiplier: 0.06).isActive = true
        btn7Seat.centerXAnchor.constraint(equalTo: self.parent.view.centerXAnchor, constant: 0.0).isActive = true
        btn7Seat.centerYAnchor.constraint(equalTo: btn4Seat.centerYAnchor, constant: 0.0).isActive = true
        
        
        pnlCustomOrderArea.addSubview(btnAllSeat)
        btnAllSeat.widthAnchor.constraint(equalTo: pnlCustomOrderArea.widthAnchor, multiplier: 0.275).isActive = true
        btnAllSeat.heightAnchor.constraint(equalTo: self.parent.view.heightAnchor, multiplier: 0.06).isActive = true
        btnAllSeat.rightAnchor.constraint(equalTo: pnlCustomOrderArea.rightAnchor, constant: -17.0).isActive = true
        btnAllSeat.centerYAnchor.constraint(equalTo: btn7Seat.centerYAnchor, constant: 0.0).isActive = true
        
        
        line3.path = UIBezierPath(roundedRect: CGRect(x: 20, y: scrRect.height * 0.36, width: scrRect.width-57.0, height: 1), cornerRadius: 0).cgPath
        pnlCustomOrderArea.layer.addSublayer(line3)
        
        
        pnlCustomOrderArea.addSubview(icoClock)
        icoClock.leftAnchor.constraint(equalTo: pnlCustomOrderArea.leftAnchor, constant: 20.0).isActive = true
        icoClock.topAnchor.constraint(equalTo: pnlCustomOrderArea.topAnchor, constant: (scrRect.height * 0.36) + 5).isActive = true
        
        
        pnlCustomOrderArea.addSubview(lblClock)
        lblClock.leftAnchor.constraint(equalTo: icoClock.leftAnchor, constant: 30.0).isActive = true
        lblClock.centerYAnchor.constraint(equalTo: icoClock.centerYAnchor, constant: 0.0).isActive = true
        
        
        
        pnlCustomOrderArea.addSubview(btnImmediately)
        btnImmediately.widthAnchor.constraint(equalTo: pnlCustomOrderArea.widthAnchor, multiplier: 0.432).isActive = true
        btnImmediately.heightAnchor.constraint(equalTo: self.parent.view.heightAnchor, multiplier: 0.06).isActive = true
        btnImmediately.leftAnchor.constraint(equalTo: pnlCustomOrderArea.leftAnchor, constant: 17.0).isActive = true
        btnImmediately.topAnchor.constraint(equalTo: icoClock.bottomAnchor, constant: 4).isActive = true
        
        pnlCustomOrderArea.addSubview(btnLater)
        btnLater.widthAnchor.constraint(equalTo: pnlCustomOrderArea.widthAnchor, multiplier: 0.432).isActive = true
        btnLater.heightAnchor.constraint(equalTo: self.parent.view.heightAnchor, multiplier: 0.06).isActive = true
        btnLater.rightAnchor.constraint(equalTo: pnlCustomOrderArea.rightAnchor, constant: -17.0).isActive = true
        btnLater.centerYAnchor.constraint(equalTo: btnImmediately.centerYAnchor, constant: 0.0).isActive = true
        
        
        pnlCustomOrderArea.addSubview(imgPickupTimeBG)
        imgPickupTimeBG.topAnchor.constraint(equalTo: btnImmediately.bottomAnchor, constant: 5.0).isActive = true
        imgPickupTimeBG.rightAnchor.constraint(equalTo: btnLater.rightAnchor, constant : 0.0).isActive = true
        imgPickupTimeBG.widthAnchor.constraint(equalTo: pnlCustomOrderArea.widthAnchor, constant : -150.0).isActive = true
        imgPickupTimeBG.heightAnchor.constraint(equalToConstant: 33).isActive = true
        
        pnlCustomOrderArea.addSubview(lblPickupTimeValue)
        lblPickupTimeValue.centerYAnchor.constraint(equalTo: imgPickupTimeBG.centerYAnchor, constant: 0.0).isActive = true
        lblPickupTimeValue.leftAnchor.constraint(equalTo: imgPickupTimeBG.leftAnchor, constant : 0.0).isActive = true
        lblPickupTimeValue.widthAnchor.constraint(equalTo: imgPickupTimeBG.widthAnchor, constant : 0.0).isActive = true
        lblPickupTimeValue.heightAnchor.constraint(equalToConstant: 13).isActive = true
        
        pnlCustomOrderArea.addSubview(btnPickupTime)
        btnPickupTime.centerYAnchor.constraint(equalTo: imgPickupTimeBG.centerYAnchor, constant: -2.0).isActive = true
        btnPickupTime.leftAnchor.constraint(equalTo: icoClock.leftAnchor, constant : 0.0).isActive = true
        
        
        pnlCustomOrderArea.addSubview(lblPickupTime)
        lblPickupTime.leftAnchor.constraint(equalTo: btnPickupTime.rightAnchor, constant: 20.0).isActive = true
        lblPickupTime.centerYAnchor.constraint(equalTo: btnPickupTime.centerYAnchor, constant: 0.0).isActive = true
        
        
        
        self.parent.view.addSubview(pnlButtonArea)
        pnlButtonArea.widthAnchor.constraint(equalTo: self.parent.view.widthAnchor , constant : -13.0).isActive = true
        pnlButtonArea.leftAnchor.constraint(equalTo: self.parent.view.leftAnchor, constant: 8.0).isActive = true
        
        pnlButtonArea.bottomAnchor.constraint(equalTo: self.parent.view.bottomAnchor, constant: -3-(self.parent.tabBarController?.tabBar.frame.size.height)!).isActive = true
        pnlButtonArea.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        pnlButtonArea.addSubview(btnCancelOrder)
        btnCancelOrder.widthAnchor.constraint(equalTo: pnlButtonArea.widthAnchor, multiplier: 0.49).isActive = true
        btnCancelOrder.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnCancelOrder.leftAnchor.constraint(equalTo: pnlButtonArea.leftAnchor, constant: 0.0).isActive = true
        btnCancelOrder.topAnchor.constraint(equalTo: pnlButtonArea.topAnchor, constant: 0.0).isActive = true
        
        pnlButtonArea.addSubview(btnCreateOrder)
        btnCreateOrder.widthAnchor.constraint(equalTo: pnlButtonArea.widthAnchor, multiplier: 0.49).isActive = true
        btnCreateOrder.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnCreateOrder.rightAnchor.constraint(equalTo: pnlButtonArea.rightAnchor, constant: 0.0).isActive = true
        btnCreateOrder.centerYAnchor.constraint(equalTo: btnCancelOrder.centerYAnchor, constant: 0.0).isActive = true
        
        
        self.parent.view.layoutIfNeeded()
        completion?()
    }
    

}
