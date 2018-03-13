//
//  Driver.Profile.Info.swift
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


open class ProfileInfoView : UITableViewController, DTTableViewManageable {
    
    open var parent: DriverProfileScreen
    
    var pnlProfileArea: UIView!
    var imgAvatar : UIImageView!
    var imgStar1: UIImageView!
    var imgStar2: UIImageView!
    var imgStar3: UIImageView!
    var imgStar4: UIImageView!
    var imgStar5: UIImageView!
    var lblCitizenID: UILabel!
    var lblCitizenIDValue: UILabel!
    var lblCompany: UILabel!
    var lblCompanyValue: UILabel!
    var lblCarNo: UILabel!
    var lblCarNoValue: UILabel!
    var lblCarSeater: UILabel!
    var lblCarSeaterValue: UILabel!
    var lblCarQuality: UILabel!
    var lblCarQualityValue: UILabel!
    var lblServedQty: UILabel!
    var lblServedQtyValue: UILabel!
    var lblVoidedBfPickupByDriver: UILabel!
    var lblVoidedBfPickupByDriverValue: UILabel!
    var lblRateCountValue: UILabel!
    
    var yellowStar: UIImage!
    var grayStar: UIImage!
    

    public init(parent: DriverProfileScreen){
        
        self.parent = parent
        super.init(nibName: nil, bundle: nil)

    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func invalidate(){
        
        
        self.navigationItem.title = (self.parent.driver != nil &&  self.parent.driver!.Name != nil ? self.parent.driver!.Name!.uppercaseString : "" )
        self.lblCitizenID.text = "CMND :"
        self.lblCitizenIDValue.text = (self.parent.driver != nil &&  self.parent.driver!.CitizenID != nil  ? self.parent.driver!.CitizenID!.uppercaseString : "" )
        self.lblCompany.text = "Hãng xe :"
        self.lblCompanyValue.text =  (self.parent.driverStatus != nil &&  self.parent.driverStatus!.CompanyName != nil  ? self.parent.driverStatus!.CompanyName!.uppercaseString : "" )
        self.lblCarNo.text = "Biển số :"
        self.lblCarNoValue.text = (self.parent.driverStatus != nil  &&  self.parent.driverStatus!.CarNo != nil ? self.parent.driverStatus!.CarNo!.uppercaseString : "" )
        self.lblCarSeater.text = "Số ghế :"
        self.lblCarSeaterValue.text = (self.parent.driverStatus != nil &&  self.parent.driverStatus!.CarSeater != nil  ? self.parent.driverStatus!.CarSeater! : "" )
        self.lblCarQuality.text = "Chất lượng :"
        
        
        self.lblCarQualityValue.text = (self.parent.driverStatus != nil &&  self.parent.driverStatus!.QualityService != nil  ? self.parent.driverStatus!.QualityService! : "" )
        if(self.parent.driverStatus != nil && self.parent.driverStatus!.QualityService != nil){
            
            switch self.parent.driverStatus!.QualityService!  {
            case "Popular": self.lblCarQualityValue.text = "Phổ thông"
            case "Economic": self.lblCarQualityValue.text = "Giá rẻ"
            case "Luxury": self.lblCarQualityValue.text = "Chất lượng cao"
            default: self.lblCarQualityValue.text = self.parent.driverStatus!.QualityService!
            }
            
        }
        self.lblServedQty.text = "Đã phục vụ :"
        self.lblServedQtyValue.text =   (self.parent.driverStatus != nil ? "\(self.parent.driverStatus!.ServedQty) chuyến" : " 0 chuyến" )
        self.lblVoidedBfPickupByDriver.text = "Huỷ đón :"
        self.lblVoidedBfPickupByDriverValue.text =  (self.parent.driverStatus != nil ? "\(self.parent.driverStatus!.VoidedBfPickupByDriver) chuyến" : " 0 chuyến" )
        self.lblVoidedBfPickupByDriver.text = "Huỷ đón :"
        self.lblRateCountValue.text = (self.parent.driverStatus != nil ? "\(self.parent.driverStatus!.RateCount) đánh giá" : " 0 đánh giá" )
        
        
        imgStar1.image = ((self.parent.driverStatus == nil) || (self.parent.driverStatus!.Rating < 1)) ?  grayStar : yellowStar
        imgStar2.image = ((self.parent.driverStatus == nil) || (self.parent.driverStatus!.Rating < 2)) ?  grayStar : yellowStar
        imgStar3.image = ((self.parent.driverStatus == nil) || (self.parent.driverStatus!.Rating < 3)) ?  grayStar : yellowStar
        imgStar4.image = ((self.parent.driverStatus == nil) || (self.parent.driverStatus!.Rating < 4)) ?  grayStar : yellowStar
        imgStar5.image = ((self.parent.driverStatus == nil) || (self.parent.driverStatus!.Rating < 5)) ?  grayStar : yellowStar
        
    }

    
    func initControls(){
        
        let scrRect = UIScreen.main.bounds
                
        
        pnlProfileArea = UIView()
        pnlProfileArea.backgroundColor = UIColor(red: CGFloat(247/255.0), green: CGFloat(247/255.0), blue: CGFloat(247/255.0), alpha: 1.0)
        pnlProfileArea.layer.cornerRadius = 4.0
        pnlProfileArea.layer.borderColor = UIColor.gray.cgColor
        pnlProfileArea.layer.borderWidth = 0.5
        pnlProfileArea.translatesAutoresizingMaskIntoConstraints = false
        pnlProfileArea.isUserInteractionEnabled = true
        
        
        self.imgAvatar = UIImageView(image: ImageHelper.resize(UIImage(named: "Avatar.png")!, newWidth: 100))
        self.imgAvatar.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.imgAvatar.layer.borderWidth=0.5
        self.imgAvatar.layer.masksToBounds = false
        self.imgAvatar.layer.borderColor = UIColor.gray.cgColor
        self.imgAvatar.layer.cornerRadius = 12
        self.imgAvatar.layer.cornerRadius =  self.imgAvatar.frame.size.height/2
        self.imgAvatar.clipsToBounds = true
        self.imgAvatar.translatesAutoresizingMaskIntoConstraints = false
        let url = SClientData.ServerURL + "/avatar/driver/\(self.parent.driver!.id!)"

        self.imgAvatar.af_setImageWithURL(
            URL(string: url)!,
            placeholderImage: ImageHelper.resize(UIImage(named: "Avatar.png")!, newWidth: 100),
            filter: AspectScaledToFillSizeWithRoundedCornersFilter(size: CGSize(width: 100, height: 100), radius: 24),
            imageTransition: .CrossDissolve(0.2)
        )
        yellowStar = ImageHelper.resize(UIImage(named: "star.png")!, newWidth: 16)
        grayStar = ImageHelper.resize(UIImage(named: "graystar.png")!, newWidth: 16)
        
        self.imgStar1 = UIImageView(image: yellowStar)
        self.imgStar1.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        self.imgStar1.translatesAutoresizingMaskIntoConstraints = false
        self.imgStar2 = UIImageView(image: yellowStar)
        self.imgStar2.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        self.imgStar2.translatesAutoresizingMaskIntoConstraints = false
        self.imgStar3 = UIImageView(image: yellowStar)
        self.imgStar3.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        self.imgStar3.translatesAutoresizingMaskIntoConstraints = false
        self.imgStar4 = UIImageView(image: yellowStar)
        self.imgStar4.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        self.imgStar4.translatesAutoresizingMaskIntoConstraints = false
        self.imgStar5 = UIImageView(image: yellowStar)
        self.imgStar5.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        self.imgStar5.translatesAutoresizingMaskIntoConstraints = false
        
        
        // CitizenID Label
        lblCitizenID = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblCitizenID.font = lblCitizenID.font.withSize(12)
        lblCitizenID.textColor = UIColor.darkGray
        lblCitizenID.textAlignment = NSTextAlignment.left
        lblCitizenID.text = ""
        lblCitizenID.translatesAutoresizingMaskIntoConstraints = false
        
        // CitizenID Value Label
        lblCitizenIDValue = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblCitizenIDValue.font = lblCitizenIDValue.font.withSize(12)
        lblCitizenIDValue.textColor = UIColor.darkGray
        lblCitizenIDValue.textAlignment = NSTextAlignment.right
        lblCitizenIDValue.text = ""
        lblCitizenIDValue.translatesAutoresizingMaskIntoConstraints = false
        
        
        // Company Label
        lblCompany = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblCompany.font = lblCompany.font.withSize(12)
        lblCompany.textColor = UIColor.darkGray
        lblCompany.textAlignment = NSTextAlignment.left
        lblCompany.text = ""
        lblCompany.translatesAutoresizingMaskIntoConstraints = false
        
        // Company Value Label
        lblCompanyValue = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblCompanyValue.font = lblCompanyValue.font.withSize(12)
        lblCompanyValue.textColor = UIColor.darkGray
        lblCompanyValue.textAlignment = NSTextAlignment.right
        lblCompanyValue.text = ""
        lblCompanyValue.translatesAutoresizingMaskIntoConstraints = false
        
        
        // CarNo Label
        lblCarNo = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblCarNo.font = lblCarNo.font.withSize(12)
        lblCarNo.textColor = UIColor.darkGray
        lblCarNo.textAlignment = NSTextAlignment.left
        lblCarNo.text = ""
        lblCarNo.translatesAutoresizingMaskIntoConstraints = false
        
        // CarNo Value Label
        lblCarNoValue = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblCarNoValue.font = lblCarNoValue.font.withSize(12)
        lblCarNoValue.textColor = UIColor.darkGray
        lblCarNoValue.textAlignment = NSTextAlignment.right
        lblCarNoValue.text = ""
        lblCarNoValue.translatesAutoresizingMaskIntoConstraints = false
        
        // CarSeater Label
        lblCarSeater = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblCarSeater.font = lblCarSeater.font.withSize(12)
        lblCarSeater.textColor = UIColor.darkGray
        lblCarSeater.textAlignment = NSTextAlignment.left
        lblCarSeater.text = ""
        lblCarSeater.translatesAutoresizingMaskIntoConstraints = false
        
        // CarSeater Value Label
        lblCarSeaterValue = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblCarSeaterValue.font = lblCarSeaterValue.font.withSize(12)
        lblCarSeaterValue.textColor = UIColor.darkGray
        lblCarSeaterValue.textAlignment = NSTextAlignment.right
        lblCarSeaterValue.text = ""
        lblCarSeaterValue.translatesAutoresizingMaskIntoConstraints = false
        
        
        // CarQuality Label
        lblCarQuality = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblCarQuality.font = lblCarQuality.font.withSize(12)
        lblCarQuality.textColor = UIColor.darkGray
        lblCarQuality.textAlignment = NSTextAlignment.left
        lblCarQuality.text = ""
        lblCarQuality.translatesAutoresizingMaskIntoConstraints = false
        
        // CarQuality Value Label
        lblCarQualityValue = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblCarQualityValue.font = lblCarQualityValue.font.withSize(12)
        lblCarQualityValue.textColor = UIColor.darkGray
        lblCarQualityValue.textAlignment = NSTextAlignment.right
        lblCarQualityValue.text = ""
        lblCarQualityValue.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        // ServedQty Label
        lblServedQty = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblServedQty.font = lblServedQty.font.withSize(12)
        lblServedQty.textColor = UIColor.darkGray
        lblServedQty.textAlignment = NSTextAlignment.left
        lblServedQty.text = ""
        lblServedQty.translatesAutoresizingMaskIntoConstraints = false
        
        // ServedQty Value Label
        lblServedQtyValue = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblServedQtyValue.font = lblServedQtyValue.font.withSize(12)
        lblServedQtyValue.textColor = UIColor.darkGray
        lblServedQtyValue.textAlignment = NSTextAlignment.right
        lblServedQtyValue.text = ""
        lblServedQtyValue.translatesAutoresizingMaskIntoConstraints = false
        
        
        // VoidedBfPickupByDriver Label
        lblVoidedBfPickupByDriver = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblVoidedBfPickupByDriver.font = lblVoidedBfPickupByDriver.font.withSize(12)
        lblVoidedBfPickupByDriver.textColor = UIColor.darkGray
        lblVoidedBfPickupByDriver.textAlignment = NSTextAlignment.left
        lblVoidedBfPickupByDriver.text = ""
        lblVoidedBfPickupByDriver.translatesAutoresizingMaskIntoConstraints = false
        
        // VoidedBfPickupByDriver Value Label
        lblVoidedBfPickupByDriverValue = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblVoidedBfPickupByDriverValue.font = lblVoidedBfPickupByDriverValue.font.withSize(12)
        lblVoidedBfPickupByDriverValue.textColor = UIColor.darkGray
        lblVoidedBfPickupByDriverValue.textAlignment = NSTextAlignment.right
        lblVoidedBfPickupByDriverValue.text = ""
        lblVoidedBfPickupByDriverValue.translatesAutoresizingMaskIntoConstraints = false
        
        
        // RateCount Value Label
        lblRateCountValue = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        lblRateCountValue.font = lblRateCountValue.font.withSize(12)
        lblRateCountValue.textColor = UIColor.darkGray
        lblRateCountValue.textAlignment = NSTextAlignment.center
        lblRateCountValue.text = ""
        lblRateCountValue.translatesAutoresizingMaskIntoConstraints = false
        
                
    }

    
    func initLayout(){
        
        let scrRect = UIScreen.main.bounds
        
        
        self.parent.containerView.addSubview(pnlProfileArea)
        pnlProfileArea.frame = CGRect(x: 9, y: 9, width: scrRect.width - 18 , height: 160)
        pnlProfileArea.centerXAnchor.constraint(equalTo: self.parent.containerView.centerXAnchor, constant: 0).isActive = true
        pnlProfileArea.topAnchor.constraint(equalTo: self.parent.containerView.topAnchor, constant: 9).isActive = true
        pnlProfileArea.widthAnchor.constraint(equalToConstant: scrRect.width - 18).isActive = true
        pnlProfileArea.heightAnchor.constraint(equalToConstant: 155).isActive = true
        
        pnlProfileArea.addSubview(imgAvatar)
        imgAvatar.topAnchor.constraint(equalTo: pnlProfileArea.topAnchor, constant: 10).isActive = true
        imgAvatar.leftAnchor.constraint(equalTo: pnlProfileArea.leftAnchor, constant: 10).isActive = true
        imgAvatar.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imgAvatar.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        pnlProfileArea.addSubview(lblCitizenID)
        lblCitizenID.topAnchor.constraint(equalTo: imgAvatar.topAnchor, constant: -3).isActive = true
        lblCitizenID.leftAnchor.constraint(equalTo: imgAvatar.rightAnchor, constant: 10).isActive = true
        lblCitizenID.widthAnchor.constraint(equalToConstant: (scrRect.width-18.0-10-100-10-10)/2).isActive = true
        lblCitizenID.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        pnlProfileArea.addSubview(lblCitizenIDValue)
        lblCitizenIDValue.centerYAnchor.constraint(equalTo: lblCitizenID.centerYAnchor, constant: 0).isActive = true
        lblCitizenIDValue.rightAnchor.constraint(equalTo: pnlProfileArea.rightAnchor, constant: -10).isActive = true
        lblCitizenIDValue.widthAnchor.constraint(equalTo: lblCitizenID.widthAnchor, constant: 0).isActive = true
        lblCitizenIDValue.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        pnlProfileArea.addSubview(lblCompany)
        lblCompany.topAnchor.constraint(equalTo: lblCitizenID.bottomAnchor, constant: 0).isActive = true
        lblCompany.leftAnchor.constraint(equalTo: lblCitizenID.leftAnchor, constant: 0).isActive = true
        lblCompany.widthAnchor.constraint(equalToConstant: (scrRect.width-18.0-10-100-10-10)/2).isActive = true
        lblCompany.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        pnlProfileArea.addSubview(lblCompanyValue)
        lblCompanyValue.centerYAnchor.constraint(equalTo: lblCompany.centerYAnchor, constant: 0).isActive = true
        lblCompanyValue.rightAnchor.constraint(equalTo: lblCitizenIDValue.rightAnchor, constant: 0).isActive = true
        lblCompanyValue.widthAnchor.constraint(equalTo: lblCompany.widthAnchor, constant: 0).isActive = true
        lblCompanyValue.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        pnlProfileArea.addSubview(lblCarNo)
        lblCarNo.topAnchor.constraint(equalTo: lblCompany.bottomAnchor, constant: 0).isActive = true
        lblCarNo.leftAnchor.constraint(equalTo: lblCompany.leftAnchor, constant: 0).isActive = true
        lblCarNo.widthAnchor.constraint(equalTo: lblCompany.widthAnchor, constant: 0).isActive = true
        lblCarNo.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        pnlProfileArea.addSubview(lblCarNoValue)
        lblCarNoValue.centerYAnchor.constraint(equalTo: lblCarNo.centerYAnchor, constant: 0).isActive = true
        lblCarNoValue.rightAnchor.constraint(equalTo: lblCitizenIDValue.rightAnchor, constant: 0).isActive = true
        lblCarNoValue.widthAnchor.constraint(equalTo: lblCarNo.widthAnchor, constant: 0).isActive = true
        lblCarNoValue.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        pnlProfileArea.addSubview(lblCarSeater)
        lblCarSeater.topAnchor.constraint(equalTo: lblCarNo.bottomAnchor, constant: 0).isActive = true
        lblCarSeater.leftAnchor.constraint(equalTo: lblCarNo.leftAnchor, constant: 0).isActive = true
        lblCarSeater.widthAnchor.constraint(equalTo: lblCarNo.widthAnchor, constant: 0).isActive = true
        lblCarSeater.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        pnlProfileArea.addSubview(lblCarSeaterValue)
        lblCarSeaterValue.centerYAnchor.constraint(equalTo: lblCarSeater.centerYAnchor, constant: 0).isActive = true
        lblCarSeaterValue.rightAnchor.constraint(equalTo: lblCitizenIDValue.rightAnchor, constant: 0).isActive = true
        lblCarSeaterValue.widthAnchor.constraint(equalTo: lblCarSeater.widthAnchor, constant: 0).isActive = true
        lblCarSeaterValue.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        
        pnlProfileArea.addSubview(lblCarQuality)
        lblCarQuality.topAnchor.constraint(equalTo: lblCarSeater.bottomAnchor, constant: 0).isActive = true
        lblCarQuality.leftAnchor.constraint(equalTo: lblCarSeater.leftAnchor, constant: 0).isActive = true
        lblCarQuality.widthAnchor.constraint(equalTo: lblCarSeater.widthAnchor, constant: 0).isActive = true
        lblCarQuality.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        pnlProfileArea.addSubview(lblCarQualityValue)
        lblCarQualityValue.centerYAnchor.constraint(equalTo: lblCarQuality.centerYAnchor, constant: 0).isActive = true
        lblCarQualityValue.rightAnchor.constraint(equalTo: lblCitizenIDValue.rightAnchor, constant: 0).isActive = true
        lblCarQualityValue.widthAnchor.constraint(equalTo: lblCarQuality.widthAnchor, constant: 0).isActive = true
        lblCarQualityValue.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        pnlProfileArea.addSubview(lblServedQty)
        lblServedQty.topAnchor.constraint(equalTo: lblCarQuality.bottomAnchor, constant: 0).isActive = true
        lblServedQty.leftAnchor.constraint(equalTo: lblCarQuality.leftAnchor, constant: 0).isActive = true
        lblServedQty.widthAnchor.constraint(equalTo: lblCarQuality.widthAnchor, constant: 0).isActive = true
        lblServedQty.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        pnlProfileArea.addSubview(lblServedQtyValue)
        lblServedQtyValue.centerYAnchor.constraint(equalTo: lblServedQty.centerYAnchor, constant: 0).isActive = true
        lblServedQtyValue.rightAnchor.constraint(equalTo: lblCitizenIDValue.rightAnchor, constant: 0).isActive = true
        lblServedQtyValue.widthAnchor.constraint(equalTo: lblServedQty.widthAnchor, constant: 0).isActive = true
        lblServedQtyValue.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        pnlProfileArea.addSubview(lblVoidedBfPickupByDriver)
        lblVoidedBfPickupByDriver.topAnchor.constraint(equalTo: lblServedQty.bottomAnchor, constant: 0).isActive = true
        lblVoidedBfPickupByDriver.leftAnchor.constraint(equalTo: lblServedQty.leftAnchor, constant: 0).isActive = true
        lblVoidedBfPickupByDriver.widthAnchor.constraint(equalTo: lblServedQty.widthAnchor, constant: 0).isActive = true
        lblVoidedBfPickupByDriver.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        pnlProfileArea.addSubview(lblVoidedBfPickupByDriverValue)
        lblVoidedBfPickupByDriverValue.centerYAnchor.constraint(equalTo: lblVoidedBfPickupByDriver.centerYAnchor, constant: 0).isActive = true
        lblVoidedBfPickupByDriverValue.rightAnchor.constraint(equalTo: lblCitizenIDValue.rightAnchor, constant: 0).isActive = true
        lblVoidedBfPickupByDriverValue.widthAnchor.constraint(equalTo: lblVoidedBfPickupByDriver.widthAnchor, constant: 0).isActive = true
        lblVoidedBfPickupByDriverValue.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        pnlProfileArea.addSubview(imgStar3)
        imgStar3.topAnchor.constraint(equalTo: imgAvatar.bottomAnchor, constant : 2.0).isActive = true
        imgStar3.centerXAnchor.constraint(equalTo: imgAvatar.centerXAnchor, constant : 0.0).isActive = true
        
        pnlProfileArea.addSubview(imgStar2)
        imgStar2.centerYAnchor.constraint(equalTo: imgStar3.centerYAnchor, constant : 0.0).isActive = true
        imgStar2.leftAnchor.constraint(equalTo: imgStar3.rightAnchor, constant : 1.0).isActive = true
        
        pnlProfileArea.addSubview(imgStar1)
        imgStar1.centerYAnchor.constraint(equalTo: imgStar3.centerYAnchor, constant : 0.0).isActive = true
        imgStar1.leftAnchor.constraint(equalTo: imgStar2.rightAnchor, constant : 1.0).isActive = true
        
        pnlProfileArea.addSubview(imgStar4)
        imgStar4.centerYAnchor.constraint(equalTo: imgStar3.centerYAnchor, constant : 0.0).isActive = true
        imgStar4.rightAnchor.constraint(equalTo: imgStar3.leftAnchor, constant : -1.0).isActive = true
        
        pnlProfileArea.addSubview(imgStar5)
        imgStar5.centerYAnchor.constraint(equalTo: imgStar3.centerYAnchor, constant : 0.0).isActive = true
        imgStar5.rightAnchor.constraint(equalTo: imgStar4.leftAnchor, constant : -1.0).isActive = true
        
        
        
        pnlProfileArea.addSubview(lblRateCountValue)
        lblRateCountValue.centerYAnchor.constraint(equalTo: lblVoidedBfPickupByDriver.centerYAnchor, constant: 0).isActive = true
        lblRateCountValue.centerXAnchor.constraint(equalTo: imgAvatar.centerXAnchor, constant: 0).isActive = true
        lblRateCountValue.widthAnchor.constraint(equalTo: imgAvatar.widthAnchor, constant: 0).isActive = true
        lblRateCountValue.heightAnchor.constraint(equalToConstant: 20).isActive = true
                
    }

}
