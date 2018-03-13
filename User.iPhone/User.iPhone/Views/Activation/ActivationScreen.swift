//
//  ActivationViewController.swift
//  User.iPhone
//
//  Created by Trung Dao on 6/15/16.
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

open class ActivationScreen: UIViewController,UITextFieldDelegate{
    
    var lblTitle: UILabel!
    var txtUserName: UITextField!
    var txtPhoneNo: UITextField!
    var txtActivationCode: UITextField!
    var btnGetCode: UIButton!
    var btnCancel: UIButton!
    var btnCommitCode: UIButton!
    var btnDone: UIButton!

    var lblStatus: UILabel!
    var currentRequestID: String?
    var UserId: String?
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.initControls()
        
    }
    
    
    func initControls(){
        
        let scrRect = UIScreen.main.bounds
        
        lblTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 17)
        lblTitle.text = "XÁC NHẬN TÀI KHOẢN"
        lblTitle.textColor = UIColor.black
        lblTitle.textAlignment = NSTextAlignment.center
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(lblTitle)
        lblTitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0).isActive = true
        lblTitle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60.0).isActive = true
        
        
        txtUserName = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        txtUserName.placeholder = "Họ và tên"
        txtUserName.font = UIFont.systemFont(ofSize: 16)
        txtUserName.borderStyle = UITextBorderStyle.none
        txtUserName.autocorrectionType = UITextAutocorrectionType.no
        txtUserName.keyboardType = UIKeyboardType.namePhonePad
        txtUserName.returnKeyType = UIReturnKeyType.continue
        txtUserName.clearButtonMode = UITextFieldViewMode.whileEditing;
        txtUserName.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        txtUserName.textAlignment = .center
        txtUserName.translatesAutoresizingMaskIntoConstraints = false
        txtUserName.delegate = self
        txtUserName.isHidden = true

        self.view.addSubview(txtUserName)
        txtUserName.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0).isActive = true
        txtUserName.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 30.0).isActive = true
        txtUserName.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        txtUserName.initHeightConstraints(45,related: nil, second: nil, third: nil, fourth: nil)
        
        txtPhoneNo = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        txtPhoneNo.placeholder = "Số điện thoại"
        txtPhoneNo.font = UIFont.systemFont(ofSize: 18)
        txtPhoneNo.borderStyle = UITextBorderStyle.none
        txtPhoneNo.autocorrectionType = UITextAutocorrectionType.no
        txtPhoneNo.keyboardType = UIKeyboardType.phonePad
        txtPhoneNo.returnKeyType = UIReturnKeyType.continue
        txtPhoneNo.clearButtonMode = UITextFieldViewMode.whileEditing;
        txtPhoneNo.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        txtPhoneNo.textAlignment = .center
        txtPhoneNo.translatesAutoresizingMaskIntoConstraints = false
        txtPhoneNo.delegate = self
        self.view.addSubview(txtPhoneNo)
        txtPhoneNo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0).isActive = true
        txtPhoneNo.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 30.0).isActive = true
        txtPhoneNo.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        txtPhoneNo.initHeightConstraints(45,related: nil, second: nil, third: nil, fourth: nil)

        
        
        txtActivationCode = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        txtActivationCode.placeholder = "Nhập mã xác nhận"
        txtActivationCode.font = UIFont.systemFont(ofSize: 15)
        txtActivationCode.borderStyle = UITextBorderStyle.none
        txtActivationCode.autocorrectionType = UITextAutocorrectionType.no
        txtActivationCode.keyboardType = UIKeyboardType.numberPad
        txtActivationCode.returnKeyType = UIReturnKeyType.continue
        txtActivationCode.clearButtonMode = UITextFieldViewMode.whileEditing;
        txtActivationCode.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        txtActivationCode.textAlignment = .center
        txtActivationCode.translatesAutoresizingMaskIntoConstraints = false
        txtActivationCode.delegate = self
        txtActivationCode.isHidden = true
        self.view.addSubview(txtActivationCode)
        txtActivationCode.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0).isActive = true
        txtActivationCode.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 30.0).isActive = true
        txtActivationCode.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        txtActivationCode.initHeightConstraints(40,related: nil, second: nil, third: nil, fourth: nil)
        
        
        
        let line1 = CAShapeLayer()
        line1.fillColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 0.8).cgColor
        line1.path = UIBezierPath(roundedRect: CGRect(x: scrRect.width*0.1, y: 150  , width: scrRect.width * 0.8, height: 1), cornerRadius: 0).cgPath
        self.view.layer.addSublayer(line1)

        
        // Quick Order Button
        let imgButton = ImageHelper.resize(UIImage(named: "BlueButton.png")!, newWidth: scrRect.width/2)
        btnGetCode   = UIButton(type: UIButtonType.custom) as UIButton
        btnGetCode.setTitle("GỬI MÃ XÁC NHẬN", for: UIControlState())
        btnGetCode.setBackgroundImage(imgButton, forState: .Normal)
        btnGetCode.titleLabel!.font =   btnGetCode.titleLabel!.font.withSize(15)
        btnGetCode.titleLabel!.textAlignment = NSTextAlignment.center
        btnGetCode.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btnGetCode.titleLabel!.lineBreakMode = .byTruncatingTail
        btnGetCode.contentHorizontalAlignment = .center
        btnGetCode.contentVerticalAlignment = .center
        btnGetCode.contentMode = .scaleToFill
        btnGetCode.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(btnGetCode)
        btnGetCode.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        btnGetCode.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0).isActive = true
        btnGetCode.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -300.0).isActive = true
        btnGetCode.initHeightConstraints(40,related: nil, second: nil, third: nil, fourth: nil)
        
        
        
        // Quick Order Button
        let imgBlueButton = ImageHelper.resize(UIImage(named: "SmallPurpleButton.png")!, newWidth: scrRect.width/4.5)
        btnCancel   = UIButton(type: UIButtonType.custom) as UIButton
        btnCancel.setTitle("LÀM LẠI", for: UIControlState())
        btnCancel.setBackgroundImage(imgButton, forState: .Normal)
        btnCancel.titleLabel!.font =   btnCancel.titleLabel!.font.withSize(15)
        btnCancel.titleLabel!.textAlignment = NSTextAlignment.center
        btnCancel.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btnCancel.titleLabel!.lineBreakMode = .byTruncatingTail
        btnCancel.contentHorizontalAlignment = .center
        btnCancel.contentVerticalAlignment = .center
        btnCancel.contentMode = .scaleToFill
        btnCancel.translatesAutoresizingMaskIntoConstraints = false
        btnCancel.isHidden = true

        self.view.addSubview(btnCancel)
        btnCancel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.45).isActive = true
        btnCancel.initHeightConstraints(40,related: nil, second: nil, third: nil, fourth: nil)
        btnCancel.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -5).isActive = true
        btnCancel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -300.0).isActive = true
        
        

        // Quick Order Button
        let imgOrangeButton = ImageHelper.resize(UIImage(named: "SmallOrangeButton.png")!, newWidth: scrRect.width/4.5)
        btnCommitCode   = UIButton(type: UIButtonType.custom) as UIButton
        btnCommitCode.setTitle("XÁC NHẬN", for: UIControlState())
        btnCommitCode.setBackgroundImage(imgOrangeButton, forState: .Normal)
        btnCommitCode.titleLabel!.font =   btnCommitCode.titleLabel!.font.withSize(15)
        btnCommitCode.titleLabel!.textAlignment = NSTextAlignment.center
        btnCommitCode.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btnCommitCode.titleLabel!.lineBreakMode = .byTruncatingTail
        btnCommitCode.contentHorizontalAlignment = .center
        btnCommitCode.contentVerticalAlignment = .center
        btnCommitCode.contentMode = .scaleToFill
        btnCommitCode.translatesAutoresizingMaskIntoConstraints = false
        btnCommitCode.isHidden = true
        self.view.addSubview(btnCommitCode)
        btnCommitCode.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.45).isActive = true
        btnCommitCode.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 5.0).isActive = true
        btnCommitCode.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -300.0).isActive = true
        btnCommitCode.initHeightConstraints(40,related: nil, second: nil, third: nil, fourth: nil)
        

        
        
        
        // Quick Order Button
        let imgDoneButton = ImageHelper.resize(UIImage(named: "BlueButton.png")!, newWidth: scrRect.width/2)
        btnDone   = UIButton(type: UIButtonType.custom) as UIButton
        btnDone.setTitle("HOÀN TẤT", for: UIControlState())
        btnDone.setBackgroundImage(imgDoneButton, forState: .Normal)
        btnDone.titleLabel!.font =   btnDone.titleLabel!.font.withSize(15)
        btnDone.titleLabel!.textAlignment = NSTextAlignment.center
        btnDone.contentEdgeInsets = UIEdgeInsetsMake(1,1,1,1)
        btnDone.titleLabel!.lineBreakMode = .byTruncatingTail
        btnDone.contentHorizontalAlignment = .center
        btnDone.contentVerticalAlignment = .center
        btnDone.contentMode = .scaleToFill
        btnDone.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(btnDone)
        btnDone.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        btnDone.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0).isActive = true
        btnDone.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -300.0).isActive = true
        btnDone.initHeightConstraints(40,related: nil, second: nil, third: nil, fourth: nil)
        

        
        lblStatus = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblStatus.font = lblTitle.font.withSize(12)
        lblStatus.text = "Mã xác nhận sẽ được gửi đến số điện thoại của bạn."
        lblStatus.textColor = UIColor.darkGray
        lblStatus.textAlignment = NSTextAlignment.center
        lblStatus.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(lblStatus)
        lblStatus.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0).isActive = true
        lblStatus.bottomAnchor.constraint(equalTo: btnCommitCode.topAnchor, constant: -70.0).isActive = true
        
        
        
        btnGetCode.addTarget(self, action: #selector(ActivationScreen.btnGetCode_Clicked(_:)), for:.touchUpInside)
        btnCommitCode.addTarget(self, action: #selector(ActivationScreen.btnCommitCode_Clicked(_:)), for:.touchUpInside)
        btnCancel.addTarget(self, action: #selector(ActivationScreen.btnCancel_Clicked(_:)), for:.touchUpInside)
        btnDone.addTarget(self, action: #selector(ActivationScreen.btnDone_Clicked(_:)), for:.touchUpInside)



        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ActivationScreen.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
        txtPhoneNo.becomeFirstResponder()
    }
    
    func dismissKeyboard() {
       self.view.endEditing(true)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.txtUserName.showControl = false
        self.txtPhoneNo.showControl = true
        self.txtActivationCode.showControl = false
        self.btnGetCode.showControl = true
        self.btnCancel.showControl = false
        self.btnCommitCode.showControl = false
        self.btnDone.showControl = false
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    @IBAction open func btnGetCode_Clicked(_ sender: UIButton) {
        
        self.txtPhoneNo.endEditing(true)
        self.txtActivationCode.endEditing(true)
        self.txtUserName.endEditing(true)
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    self.btnGetCode.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        self.btnGetCode.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                     
                                        
                                        self.txtPhoneNo.showControl = false
                                        self.btnGetCode.showControl = false
                                        self.btnCancel.showControl = true
                                        self.btnCommitCode.showControl = true
                                        self.txtActivationCode.showControl = true
                                        
                                        self.txtActivationCode.text = ""
                                        self.txtActivationCode.becomeFirstResponder()
                                        
                                        let phoneNo = self.txtPhoneNo.text!.trimmingCharacters(
                                            in: CharacterSet.whitespacesAndNewlines
                                        )
                                        
                                        if(phoneNo != "" ){
                                                UserController.RequestForActivationCode(phoneNo, countryCode: "VN") { (requestId) in
                                                    
                                                    if(requestId != nil){
                                                        self.currentRequestID = requestId
                                                        self.lblStatus.text = "Đã gửi mã kích hoạt đến số điện thoại của bạn."

                                                    }else{
                                                        
                                                        self.lblStatus.text = "Gửi mã kích hoạt không thành công."
                                                        
                                                    }
                                                    
                                                }
                                        }else{
                                                self.lblStatus.text = "Vui lòng nhập số điện thoại của bạn."
                                        }
                                    }) 
                                    
        })
    }

    @IBAction open func btnCommitCode_Clicked(_ sender: UIButton) {
        
        self.txtPhoneNo.endEditing(true)
        self.txtActivationCode.endEditing(true)
        self.txtUserName.endEditing(true)
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    self.btnCommitCode.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        self.btnCommitCode.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                        
                                        if(self.currentRequestID != nil){
                                            
                                                self.lblStatus.text = "Đang kiểm tra mã kích hoạt..."
                                            
                                            
                                                let phoneNo = self.txtPhoneNo.text!.trimmingCharacters(
                                                    in: CharacterSet.whitespacesAndNewlines
                                                )

                                                let activateCode = self.txtActivationCode.text!.trimmingCharacters(
                                                    in: CharacterSet.whitespacesAndNewlines
                                                )
                                                

                                                UserController.CheckForActivationCode(self.currentRequestID!, code: activateCode, phoneNo: phoneNo) { (userId, errorcode) in
                                                    
                                                                if(userId == nil){
                                                                    self.lblStatus.text = "Mã kích hoạt không đúng, vui lòng kiểm tra lại!"
                                                                    return
                                                                }
                                                    
                                                                SCONNECTING.UserManager!.login( userId!, completion: { (isLogged) in
                                                                    
                                                                        self.btnGetCode.showControl = false
                                                                        self.btnCommitCode.showControl = false
                                                                        self.txtActivationCode.showControl = false
                                                                    
                                                                        if(!isLogged){
                                                                            self.lblStatus.text = "Kết nối không hợp lệ."
                                                                            self.btnCancel.showControl = true
                                                                            self.btnDone.showControl = false
                                                                            return
                                                                        }
                                                                    
                                                                        self.btnCancel.showControl = false
                                                                        self.btnDone.showControl = true
                                                                        self.txtUserName.showControl = true

                                                                        self.lblStatus.text = "Kích hoạt thành công."
                                                                    
                                                                        UserController.queryServerById(userId!, serverHandler: { (item) in
                                                                            if(item != nil){
                                                                                self.txtUserName.text = item?.Name
                                                                            }
                                                                        })
                                                                        
                                                                        self.UserId = userId
                                                                    
                                                                })
                                                        
                                                    
                                                    }
                                            
                                            
                                        }
                                    }) 
                                    
        })
    }
    
    
    @IBAction open func btnCancel_Clicked(_ sender: UIButton) {
        
        self.txtPhoneNo.endEditing(true)
        self.txtActivationCode.endEditing(true)
        self.txtUserName.endEditing(true)
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    self.btnCancel.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        self.btnCancel.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                        
                                        self.btnDone.showControl = false
                                        self.btnGetCode.showControl = true
                                        self.btnCancel.showControl = false
                                        self.btnCommitCode.showControl = false
                                        self.txtActivationCode.showControl = false
                                        self.txtUserName.showControl = false
                                        self.txtPhoneNo.showControl = true
                                        self.txtActivationCode.text = ""
                                        
                                        self.lblStatus.text = "Vui lòng nhập số điện thoại của bạn."                                        
                                        
                                        self.txtPhoneNo.becomeFirstResponder()
                                    
                                    }) 
                                    
        })
    }
    
    
    @IBAction open func btnDone_Clicked(_ sender: UIButton) {
        
        self.txtPhoneNo.endEditing(true)
        self.txtActivationCode.endEditing(true)
        self.txtUserName.endEditing(true)
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    self.btnCancel.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        self.btnCancel.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                        
                                        self.lblStatus.text = "Cập nhật thông tin cá nhân...."
                                        
                                        self.btnDone.showControl = false
                                        self.btnGetCode.showControl = false
                                        self.btnCancel.showControl = false
                                        self.btnCommitCode.showControl = false
                                        
                                        
                                        SCONNECTING.UserManager!.updateUserName(self.txtUserName.text!, userId: self.UserId!){
                                            
                                            SCONNECTING.UserManager!.initCurrentUser { isValidUser in
                                                
                                                    if(isValidUser == false){
                                                        
                                                        AppDelegate.activationWindow = ActivationWindow(frame: UIScreen.main.bounds)
                                                        AppDelegate.activationWindow?.makeKeyAndVisible()
                                                        
                                                    }else{
                                                        
                                                        UserController.activate(self.UserId!){
                                                            
                                                            SCONNECTING.Start {
                                                                
                                                                if( AppDelegate.mainWindow  == nil){
                                                                    AppDelegate.mainWindow = MainWindow(frame: UIScreen.mainScreen().bounds)
                                                                    AppDelegate.mainWindow?.makeKeyAndVisible()
                                                                }
                                                                
                                                            }
                                                        }
                                                    }

                                            }
                                        }                                        
                                    }) 
                                    
        })

    }    
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      
        if (textField === txtUserName)
        {
            txtUserName.resignFirstResponder()
            txtPhoneNo.becomeFirstResponder()
        }
        if (textField === txtPhoneNo)
        {
            txtPhoneNo.resignFirstResponder()
            btnGetCode.becomeFirstResponder()
        }

        return true;
    }

}
