//
//  PopupDatePicker.swift
//  User.iPhone
//
//  Created by Trung Dao on 5/27/16.
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

protocol PopupDatePickerDelegate: class {
    func didChooseDateTime(_ sender: PopupDatePicker)
}


open class PopupDatePicker: UIView, UIPickerViewDelegate {
    
    open static var instance: PopupDatePicker?
    
    open var name: String!
    open var txtCapTion: UILabel!
    open var dateValue: Date = Date()
    
    open var isCancel: Bool = true
    
    var datePicker:  UIDatePicker!
    var pnlButtonArea:  UIView!
    
    var  btn10Minute: UIButton!
    var  btn15Minute: UIButton!
    var  btn20Minute: UIButton!
    
    var  btn30Minute: UIButton!
    var  btn45Minute: UIButton!
    var  btn60Minute: UIButton!

    var  btnCancel: UIButton!
    var  btnApply: UIButton!
    
    var lblNotification: UILabel!

    weak var delegate:PopupDatePickerDelegate?
    
    
    open static func show() -> PopupDatePicker {
        if(instance == nil){
            
            let scrRect = UIScreen.main.bounds
            instance = PopupDatePicker(frame: scrRect)

        }
        
        instance!.dateValue = Date()
        instance!.invalidateButtons()
        return instance!
    }
    
    public override init(frame: CGRect){
    
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.alpha = 1.0
        
        txtCapTion = UILabel(frame: CGRect(x: 0,y: 0,width: 200,height: 30))
        txtCapTion.text = ""
        txtCapTion.font = txtCapTion.font.withSize(17)
        txtCapTion.textColor = UIColor.black
        txtCapTion.textAlignment = NSTextAlignment.center
        txtCapTion.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(txtCapTion)
        txtCapTion.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -50).isActive = true
        txtCapTion.heightAnchor.constraint(equalToConstant: 50).isActive = true
        txtCapTion.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0.0).isActive = true
        txtCapTion.topAnchor.constraint(equalTo: self.topAnchor, constant: 30.0).isActive = true
        
        
        btn10Minute   = UIButton(type: UIButtonType.custom) as UIButton
        btn10Minute.tag = 10
        btn10Minute.setTitle("10 phút ", for: UIControlState())
        btn10Minute.titleLabel!.font =   btn10Minute.titleLabel!.font.withSize(15)
        btn10Minute.titleLabel!.textAlignment = NSTextAlignment.center
        btn10Minute.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btn10Minute.titleLabel!.lineBreakMode = .byTruncatingTail
        btn10Minute.contentHorizontalAlignment = .center
        btn10Minute.contentVerticalAlignment = .center
        btn10Minute.contentMode = .scaleToFill
        btn10Minute.translatesAutoresizingMaskIntoConstraints = false
        btn10Minute.isUserInteractionEnabled = true
        btn10Minute.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallBlueButton2.png")!, newWidth: nil ), forState: UIControlState.Selected)
        btn10Minute.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallFlatButton2.png")!, newWidth: nil ), forState: UIControlState.Normal)
        btn10Minute.setTitleColor(UIColor.black, for: UIControlState())
        btn10Minute.setTitleColor(UIColor.white, for: .selected)
        self.addSubview(btn10Minute)
        btn10Minute.widthAnchor.constraint(equalToConstant: 80).isActive = true
        btn10Minute.heightAnchor.constraint(equalToConstant: 35).isActive = true
        btn10Minute.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 17.0).isActive = true
        btn10Minute.topAnchor.constraint(equalTo: txtCapTion.bottomAnchor, constant: 10).isActive = true

        
        
        btn15Minute   = UIButton(type: UIButtonType.custom) as UIButton
        btn15Minute.tag = 15
        btn15Minute.setTitle("15 phút ", for: UIControlState())
        btn15Minute.titleLabel!.font =   btn15Minute.titleLabel!.font.withSize(15)
        btn15Minute.titleLabel!.textAlignment = NSTextAlignment.center
        btn15Minute.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btn15Minute.titleLabel!.lineBreakMode = .byTruncatingTail
        btn15Minute.contentHorizontalAlignment = .center
        btn15Minute.contentVerticalAlignment = .center
        btn15Minute.contentMode = .scaleToFill
        btn15Minute.translatesAutoresizingMaskIntoConstraints = false
        btn15Minute.isUserInteractionEnabled = true
        btn15Minute.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallBlueButton2.png")!, newWidth: nil ), forState: UIControlState.Selected)
        btn15Minute.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallFlatButton2.png")!, newWidth: nil ), forState: UIControlState.Normal)
        btn15Minute.setTitleColor(UIColor.black, for: UIControlState())
        btn15Minute.setTitleColor(UIColor.white, for: .selected)
        self.addSubview(btn15Minute)
        btn15Minute.widthAnchor.constraint(equalToConstant: 80).isActive = true
        btn15Minute.heightAnchor.constraint(equalToConstant: 35).isActive = true
        btn15Minute.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0.0).isActive = true
        btn15Minute.centerYAnchor.constraint(equalTo: btn10Minute.centerYAnchor, constant: 0.0).isActive = true
        
        
        btn20Minute   = UIButton(type: UIButtonType.custom) as UIButton
        btn20Minute.tag = 20
        btn20Minute.setTitle("20 phút ", for: UIControlState())
        btn20Minute.titleLabel!.font =   btn20Minute.titleLabel!.font.withSize(15)
        btn20Minute.titleLabel!.textAlignment = NSTextAlignment.center
        btn20Minute.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btn20Minute.titleLabel!.lineBreakMode = .byTruncatingTail
        btn20Minute.contentHorizontalAlignment = .center
        btn20Minute.contentVerticalAlignment = .center
        btn20Minute.contentMode = .scaleToFill
        btn20Minute.translatesAutoresizingMaskIntoConstraints = false
        btn20Minute.isUserInteractionEnabled = true
        btn20Minute.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallBlueButton2.png")!, newWidth: nil ), forState: UIControlState.Selected)
        btn20Minute.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallFlatButton2.png")!, newWidth: nil ), forState: UIControlState.Normal)
        btn20Minute.setTitleColor(UIColor.black, for: UIControlState())
        btn20Minute.setTitleColor(UIColor.white, for: .selected)
        self.addSubview(btn20Minute)
        btn20Minute.widthAnchor.constraint(equalToConstant: 80).isActive = true
        btn20Minute.heightAnchor.constraint(equalToConstant: 35).isActive = true
        btn20Minute.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -17.0).isActive = true
        btn20Minute.centerYAnchor.constraint(equalTo: btn10Minute.centerYAnchor, constant: 0.0).isActive = true
        
        
        btn30Minute   = UIButton(type: UIButtonType.custom) as UIButton
        btn30Minute.tag = 30
        btn30Minute.setTitle("30 phút ", for: UIControlState())
        btn30Minute.titleLabel!.font =   btn30Minute.titleLabel!.font.withSize(15)
        btn30Minute.titleLabel!.textAlignment = NSTextAlignment.center
        btn30Minute.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btn30Minute.titleLabel!.lineBreakMode = .byTruncatingTail
        btn30Minute.contentHorizontalAlignment = .center
        btn30Minute.contentVerticalAlignment = .center
        btn30Minute.contentMode = .scaleToFill
        btn30Minute.translatesAutoresizingMaskIntoConstraints = false
        btn30Minute.isUserInteractionEnabled = true
        btn30Minute.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallBlueButton2.png")!, newWidth: nil ), forState: UIControlState.Selected)
        btn30Minute.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallFlatButton2.png")!, newWidth: nil ), forState: UIControlState.Normal)
        btn30Minute.setTitleColor(UIColor.black, for: UIControlState())
        btn30Minute.setTitleColor(UIColor.white, for: .selected)
        self.addSubview(btn30Minute)
        btn30Minute.widthAnchor.constraint(equalToConstant: 80).isActive = true
        btn30Minute.heightAnchor.constraint(equalToConstant: 35).isActive = true
        btn30Minute.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 17.0).isActive = true
        btn30Minute.topAnchor.constraint(equalTo: btn10Minute.bottomAnchor, constant: 10).isActive = true
        
        btn45Minute   = UIButton(type: UIButtonType.custom) as UIButton
        btn45Minute.tag = 45
        btn45Minute.setTitle("45 phút ", for: UIControlState())
        btn45Minute.titleLabel!.font =   btn45Minute.titleLabel!.font.withSize(15)
        btn45Minute.titleLabel!.textAlignment = NSTextAlignment.center
        btn45Minute.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btn45Minute.titleLabel!.lineBreakMode = .byTruncatingTail
        btn45Minute.contentHorizontalAlignment = .center
        btn45Minute.contentVerticalAlignment = .center
        btn45Minute.contentMode = .scaleToFill
        btn45Minute.translatesAutoresizingMaskIntoConstraints = false
        btn45Minute.isUserInteractionEnabled = true
        btn45Minute.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallBlueButton2.png")!, newWidth: nil ), forState: UIControlState.Selected)
        btn45Minute.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallFlatButton2.png")!, newWidth: nil ), forState: UIControlState.Normal)
        btn45Minute.setTitleColor(UIColor.black, for: UIControlState())
        btn45Minute.setTitleColor(UIColor.white, for: .selected)
        self.addSubview(btn45Minute)
        btn45Minute.widthAnchor.constraint(equalToConstant: 80).isActive = true
        btn45Minute.heightAnchor.constraint(equalToConstant: 35).isActive = true
        btn45Minute.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0.0).isActive = true
        btn45Minute.centerYAnchor.constraint(equalTo: btn30Minute.centerYAnchor, constant: 0.0).isActive = true
        
        
        btn60Minute   = UIButton(type: UIButtonType.custom) as UIButton
        btn60Minute.tag = 60
        btn60Minute.setTitle("60 phút ", for: UIControlState())
        btn60Minute.titleLabel!.font =   btn60Minute.titleLabel!.font.withSize(15)
        btn60Minute.titleLabel!.textAlignment = NSTextAlignment.center
        btn60Minute.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btn60Minute.titleLabel!.lineBreakMode = .byTruncatingTail
        btn60Minute.contentHorizontalAlignment = .center
        btn60Minute.contentVerticalAlignment = .center
        btn60Minute.contentMode = .scaleToFill
        btn60Minute.translatesAutoresizingMaskIntoConstraints = false
        btn60Minute.isUserInteractionEnabled = true
        btn60Minute.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallBlueButton2.png")!, newWidth: nil ), forState: UIControlState.Selected)
        btn60Minute.setBackgroundImage( ImageHelper.resize(UIImage(named: "SmallFlatButton2.png")!, newWidth: nil ), forState: UIControlState.Normal)
        btn60Minute.setTitleColor(UIColor.black, for: UIControlState())
        btn60Minute.setTitleColor(UIColor.white, for: .selected)
        self.addSubview(btn60Minute)
        btn60Minute.widthAnchor.constraint(equalToConstant: 80).isActive = true
        btn60Minute.heightAnchor.constraint(equalToConstant: 35).isActive = true
        btn60Minute.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -17.0).isActive = true
        btn60Minute.centerYAnchor.constraint(equalTo: btn30Minute.centerYAnchor, constant: 0.0).isActive = true
        
        
        
        lblNotification = UILabel(frame: CGRect(x: 0,y: 0,width: 200,height: 30))
        lblNotification.text = ""
        lblNotification.font = lblNotification.font.withSize(17)
        lblNotification.textColor = UIColor.black
        lblNotification.textAlignment = NSTextAlignment.center
        lblNotification.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lblNotification)
        lblNotification.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -50).isActive = true
        lblNotification.heightAnchor.constraint(equalToConstant: 50).isActive = true
        lblNotification.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0.0).isActive = true
        lblNotification.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant:  -50).isActive = true
        
        
        // Bottom  Button Area
        pnlButtonArea = UIView()
        pnlButtonArea.translatesAutoresizingMaskIntoConstraints = false
        pnlButtonArea.isUserInteractionEnabled = true        
        
        // btnCancel Button
        let imgCanelButton = ImageHelper.resize(UIImage(named: "SmallYellowButton.png")!, newWidth: nil)
        btnCancel   = UIButton(type: UIButtonType.custom) as UIButton
        btnCancel.setTitle("HỦY ", for: UIControlState())
        btnCancel.setBackgroundImage(imgCanelButton, forState: .Normal)
        btnCancel.titleLabel!.font =   btnCancel.titleLabel!.font.withSize(15)
        btnCancel.titleLabel!.textAlignment = NSTextAlignment.center
        btnCancel.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btnCancel.titleLabel!.lineBreakMode = .byTruncatingTail
        btnCancel.contentHorizontalAlignment = .center
        btnCancel.contentVerticalAlignment = .center
        btnCancel.contentMode = .scaleToFill
        btnCancel.translatesAutoresizingMaskIntoConstraints = false
        btnCancel.isUserInteractionEnabled = true
        
        // Apply Button
        let imgApplyButton = ImageHelper.resize(UIImage(named: "SmallBlueButton.png")!, newWidth: nil)
        btnApply   = UIButton(type: UIButtonType.custom) as UIButton
        btnApply.setTitle("CHỌN", for: UIControlState())
        btnApply.setBackgroundImage(imgApplyButton, forState: .Normal)
        btnApply.titleLabel!.font =   btnApply.titleLabel!.font.withSize(15)
        btnApply.titleLabel!.textAlignment = NSTextAlignment.center
        btnApply.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btnApply.titleLabel!.lineBreakMode = .byTruncatingTail
        btnApply.contentHorizontalAlignment = .center
        btnApply.contentVerticalAlignment = .center
        btnApply.contentMode = .scaleToFill
        btnApply.translatesAutoresizingMaskIntoConstraints = false
        btnApply.isUserInteractionEnabled = true

        
        self.addSubview(pnlButtonArea)
        pnlButtonArea.widthAnchor.constraint(equalTo: self.widthAnchor , constant : -50.0).isActive = true
        pnlButtonArea.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0.0).isActive = true
        pnlButtonArea.bottomAnchor.constraint(equalTo: lblNotification.topAnchor, constant: 0.0).isActive = true
        pnlButtonArea.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        pnlButtonArea.addSubview(btnCancel)
        btnCancel.widthAnchor.constraint(equalTo: pnlButtonArea.widthAnchor, multiplier: 0.49).isActive = true
        btnCancel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnCancel.leftAnchor.constraint(equalTo: pnlButtonArea.leftAnchor, constant: 0.0).isActive = true
        btnCancel.topAnchor.constraint(equalTo: pnlButtonArea.topAnchor, constant: 0.0).isActive = true
        
        pnlButtonArea.addSubview(btnApply)
        btnApply.widthAnchor.constraint(equalTo: pnlButtonArea.widthAnchor, multiplier: 0.49).isActive = true
        btnApply.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnApply.rightAnchor.constraint(equalTo: pnlButtonArea.rightAnchor, constant: 0.0).isActive = true
        btnApply.centerYAnchor.constraint(equalTo: btnCancel.centerYAnchor, constant: 0.0).isActive = true
        
        datePicker = UIDatePicker()
        datePicker.frame = CGRect(x: 0, y: 50, width: self.frame.width, height: 200)
        datePicker.timeZone = TimeZone.autoupdatingCurrent
        // datePicker.backgroundColor = UIColor.whiteColor()
        //  datePicker.layer.cornerRadius = 5.0
        //   datePicker.layer.shadowOpacity = 0.5
        datePicker.addTarget(self, action: #selector(PopupDatePicker.onDidChangeDate(_:)), for: .valueChanged)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(datePicker)
        datePicker.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -50).isActive = true
        //datePicker.heightAnchor.constraintEqualToAnchor(self.heightAnchor, multiplier: 0.5).active = true
        datePicker.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0.0).isActive = true
       // datePicker.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor, constant: -50.0).active = true
        datePicker.topAnchor.constraint(equalTo: btn60Minute.bottomAnchor, constant: 5.0).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: pnlButtonArea.topAnchor, constant: -5.0).isActive = true
        
        

        
        btnCancel.addTarget(self, action: #selector(PopupDatePicker.btnCancel_Clicked(_:)), for:.touchUpInside)
        btnApply.addTarget(self, action: #selector(PopupDatePicker.btnApply_Clicked(_:)), for:.touchUpInside)

        
        
        btn10Minute.addTarget(self, action: #selector(PopupDatePicker.btnMinute_Clicked(_:)), for:.touchUpInside)
        btn15Minute.addTarget(self, action: #selector(PopupDatePicker.btnMinute_Clicked(_:)), for:.touchUpInside)
        btn20Minute.addTarget(self, action: #selector(PopupDatePicker.btnMinute_Clicked(_:)), for:.touchUpInside)
        btn30Minute.addTarget(self, action: #selector(PopupDatePicker.btnMinute_Clicked(_:)), for:.touchUpInside)
        btn45Minute.addTarget(self, action: #selector(PopupDatePicker.btnMinute_Clicked(_:)), for:.touchUpInside)
        btn60Minute.addTarget(self, action: #selector(PopupDatePicker.btnMinute_Clicked(_:)), for:.touchUpInside)
        

    }
    
    open func setTitle(_ title: String){
        txtCapTion.text = title
    }
    
    open func setDate(_ date: Date){
        dateValue = date
        datePicker.setDate(date, animated: true)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func onDidChangeDateByOnStoryboard(_ sender: UIDatePicker) {
        self.onDidChangeDate(sender)
    }
    
    // called when the date picker called.
    internal func onDidChangeDate(_ sender: UIDatePicker){
        
        dateValue = sender.date
        
        
        let elapsedTime = self.dateValue.timeIntervalSince(Date())
        
        if(elapsedTime < 0 ){
            lblNotification.text = "Không chọn thời điểm quá khứ !"
        } else {
            
            lblNotification.text = ""
        }
        
        self.invalidateButtons()
    }
    
    func invalidateButtons(){
        
        let seconds = dateValue.timeIntervalSince(Date())
        let minutes =  Int(seconds / 60)
        
        self.btn10Minute.isSelected = (minutes == 10) || (minutes == 9)
        self.btn15Minute.isSelected = (minutes == 15) || (minutes == 14)
        self.btn20Minute.isSelected = (minutes == 20) || (minutes == 19)
        self.btn30Minute.isSelected = (minutes == 30) || (minutes == 29)
        self.btn45Minute.isSelected = (minutes == 45) || (minutes == 44)
        self.btn60Minute.isSelected = (minutes == 60) || (minutes == 59)

        datePicker.date = dateValue
    }
    
    @IBAction open func btnCancel_Clicked(_ sender: UIButton) {
        
        
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        sender.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                        
                                        self.isCancel = true
                                        self.removeFromSuperview()
                                        self.delegate?.didChooseDateTime(self)
                                    }) 
                                    
        })
        

        
    }
    
    
    @IBAction open func btnApply_Clicked(_ sender: UIButton) {
        
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        sender.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                        
                                        self.dateValue = self.datePicker.date
                                        let elapsedTime = self.dateValue.timeIntervalSince(Date())
                                        
                                        if(elapsedTime < 0 && abs(elapsedTime) > 60 ){
                                            self.lblNotification.text = "Không chọn thời điểm quá khứ !"
                                        } else {
                                            
                                            self.lblNotification.text = ""
                                            
                                            self.isCancel = false
                                            self.removeFromSuperview()
                                            self.delegate?.didChooseDateTime(self)
                                        }

                                    }) 
                                    
        })
        
    }
    
    
    func selectButton(_ sender: UIButton){
        
        self.btn10Minute.isSelected = false
        self.btn15Minute.isSelected = false
        self.btn20Minute.isSelected = false
        self.btn30Minute.isSelected = false
        self.btn45Minute.isSelected = false
        self.btn60Minute.isSelected = false
        
        sender.isSelected = true
        datePicker.date = Date().addingTimeInterval(60*Double(sender.tag))
        
    }
    
    @IBAction open func btnMinute_Clicked(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        sender.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                        
                                        self.selectButton(sender)
                                        
                                    }) 
                                    
        })
    }
    
    
}
