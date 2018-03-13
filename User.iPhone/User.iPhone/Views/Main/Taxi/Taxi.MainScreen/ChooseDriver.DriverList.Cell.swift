//
//  Order.ChooseDriver.DriverList.Cell.swift
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
import DTTableViewManager
import DTModelStorage
import SClientModelControllers
import AlamofireImage

import RealmSwift

open class ChooseDriverObject{
    
    open var order: TravelOrder?
    open var driver: Driver?
    open var driverId: String?
    open var driverStatus: DriverStatus?
    open var driverBidding: DriverBidding?
    open var estPrice: Double?
    
    init(order: TravelOrder? ,status: DriverStatus? , bidding:DriverBidding?){
        
        driverStatus = status
        driverBidding = bidding
        self.order = order
        
    }
    
    open func loadDriver(_ completion: ((_ item: Driver?) -> ())?) {
      
        
        if(self.driverBidding != nil){
            self.driverId = self.driverBidding!.Driver!
            
        }else if(self.driverStatus != nil){
            self.driverId = self.driverStatus!.Driver!
        
        }
        
        if(self.driverId == nil){
             completion?(item:nil)
             return
        }
        
        ModelController<Driver>.getById(self.driverId!,
            clientHandler: { (item : Driver?) in
                
                self.driver = item
                
                self.loadDriverStatus{
                    completion?(item:item)
                }
            
            }, serverHandler: { (item) in
                
                self.driver = item
                self.loadDriverStatus{
                    completion?(item:item)
                }

               
        })
        
    }
    
    open func loadDriverStatus(_ completion: (() -> ())?) {
        
        ModelController<DriverStatus>.getOneByField("Driver", value: self.driverId, isGetNow: false, clientHandler: { (item) in
            
                self.driverStatus = item?.copy() as? DriverStatus
                completion?()
            
            }, serverHandler: { (item) in
                
                self.driverStatus = item?.copy() as? DriverStatus
                completion?()
        })

    }
    
    open func  loadEstPrice(_ completion: (() -> ())?){
        
        if(self.estPrice == nil){
            
            if(self.order != nil){
                TravelOrderController.CalculateOrderPrice(driverId!, distance: self.order!.OrderDistance , currency: self.order!.Currency, serverHandler: { (result) in
                    self.estPrice = result
                    completion?()
                })
            }
            
        }else{
            
              completion?()
        
        }
        
    }

    open static func fromArray(_ order: TravelOrder? ,arrStatus: [DriverStatus]?, arrBidding: [DriverBidding]?,completion: ((_ items: Dictionary<String,ChooseDriverObject>) -> ())?) {
        
        var arrObjects : Dictionary<String,ChooseDriverObject> =  Dictionary<String,ChooseDriverObject>()
        var iCount: Int = 0
        
        if((arrStatus != nil && arrStatus!.count > 0)  || (arrBidding != nil && arrBidding!.count > 0)){
            
                arrStatus?.forEach({ (status) in
                    
                        let obj = ChooseDriverObject(order: order,status: status, bidding: nil)
                        obj.loadDriver({ (item) in
                            
                            if(item != nil){
                                
                                let driverId = item!.id!
                                arrObjects[String(driverId)] = obj
                            }

                             iCount += 1
                            if( iCount == (arrStatus!.count + ( arrBidding != nil ? arrBidding!.count : 0)) ){
                                  completion?(items:arrObjects)
                            }
                            
                        })
                    
                })
                
                arrBidding?.forEach({ (bidding) in
                    
                        let obj = ChooseDriverObject(order: order,status: nil, bidding: bidding)
                        obj.loadDriver({ (item) in
                            
                            if(item != nil){
                                let driverId = item!.id!
                                arrObjects[String(driverId)] = obj

                            }
                            
                            iCount += 1
                            if( iCount == (arrBidding!.count + ( arrStatus != nil ? arrStatus!.count : 0)) ){
                                completion?(items:arrObjects)
                            }
                            
                        })
                    
                })
            
        }else{
             completion?(arrObjects)
        }
    
    }
}

open class ChooseDriverCell: UITableViewCell, ModelTransfer {
    
    
    open static var CellHeight: CGFloat = 65
    
    open var imgAvatar: UIImageView!
    open var lblDriverName: UILabel!
    open var lblSeaterAndQuality: UILabel!
    
    open var lblCompany: UILabel!
    open var lblEstPrice: UILabel!
    
    open var imgStar1: UIImageView!
    open var imgStar2: UIImageView!
    open var imgStar3: UIImageView!
    open var imgStar4: UIImageView!
    open var imgStar5: UIImageView!
    open var lblRateCount: UILabel!
    
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let scrRect = UIScreen.main.bounds
        
        self.selectionStyle = .blue
        self.backgroundView =  UIView()
        self.backgroundColor = UIColor.clear
        self.selectedBackgroundView = UIView()
        self.selectedBackgroundView?.backgroundColor = UIColor(red: 186/255, green: 221/255, blue: 246/255, alpha: 1)
        
        
        let line1 = CAShapeLayer()
        line1.fillColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1).cgColor
        line1.path = UIBezierPath(roundedRect: CGRect(x: 20, y: ChooseDriverCell.CellHeight  , width: scrRect.width - 78.0, height: 1), cornerRadius: 0).cgPath
        self.backgroundView?.layer.addSublayer(line1)
        
        self.imgAvatar = UIImageView(image: ImageHelper.resize(UIImage(named: "Avatar.png")!, newWidth: ChooseDriverCell.CellHeight - 20))
        self.imgAvatar.frame = CGRect(x: 0, y: 0, width: ChooseDriverCell.CellHeight - 20, height: ChooseDriverCell.CellHeight - 20)
        self.imgAvatar.layer.borderWidth=1.0
        self.imgAvatar.layer.masksToBounds = false
        self.imgAvatar.layer.borderColor = UIColor.gray.cgColor
        self.imgAvatar.layer.cornerRadius = 13
        self.imgAvatar.layer.cornerRadius =  self.imgAvatar.frame.size.height/2
        self.imgAvatar.clipsToBounds = true
        self.imgAvatar.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(imgAvatar)
        imgAvatar.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 0.0).isActive = true
        imgAvatar.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant : 5.0).isActive = true
        
        self.lblDriverName = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        self.lblDriverName.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        self.lblDriverName.textColor = UIColor.darkGray
        self.lblDriverName.textAlignment = NSTextAlignment.left
        self.lblDriverName.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(lblDriverName)
        self.lblDriverName.topAnchor.constraint(equalTo: imgAvatar.topAnchor, constant : 0.0).isActive = true
        self.lblDriverName.leftAnchor.constraint(equalTo: imgAvatar.rightAnchor, constant : 5.0).isActive = true
        self.lblDriverName.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, constant : -20.0).isActive = true
        self.lblDriverName.heightAnchor.constraint(equalToConstant: 50)
        
        
        self.lblRateCount = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        self.lblRateCount.font = self.lblRateCount.font.withSize(11)
        self.lblRateCount.textColor = UIColor.gray
        self.lblRateCount.textAlignment = NSTextAlignment.right
        self.lblRateCount.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(lblRateCount)
        self.lblRateCount.centerYAnchor.constraint(equalTo: lblDriverName.centerYAnchor, constant : 0.0).isActive = true
        self.lblRateCount.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant : -20.0).isActive = true
        
        self.lblCompany = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        self.lblCompany.font = self.lblCompany.font.withSize(11)
        self.lblCompany.textColor = UIColor.gray
        self.lblCompany.textAlignment = NSTextAlignment.left
        self.lblCompany.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(lblCompany)
        self.lblCompany.topAnchor.constraint(equalTo: lblDriverName.bottomAnchor, constant : 5.0).isActive = true
        self.lblCompany.leftAnchor.constraint(equalTo: lblDriverName.leftAnchor, constant : 0.0).isActive = true
        self.lblCompany.widthAnchor.constraint(equalTo: lblDriverName.widthAnchor, constant : 0.0).isActive = true
        self.lblCompany.heightAnchor.constraint(equalToConstant: 50)
        
        
        self.lblSeaterAndQuality = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        self.lblSeaterAndQuality.font = UIFont(name: "HelveticaNeue-Bold", size: 11)
        self.lblSeaterAndQuality.textColor = UIColor.gray
        self.lblSeaterAndQuality.textAlignment = NSTextAlignment.left
        self.lblSeaterAndQuality.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(lblSeaterAndQuality)
        self.lblSeaterAndQuality.topAnchor.constraint(equalTo: lblCompany.bottomAnchor, constant : 5.0).isActive = true
        self.lblSeaterAndQuality.leftAnchor.constraint(equalTo: lblDriverName.leftAnchor, constant : 0.0).isActive = true
        self.lblSeaterAndQuality.widthAnchor.constraint(equalTo: lblDriverName.widthAnchor, constant : 0.0).isActive = true
        self.lblSeaterAndQuality.heightAnchor.constraint(equalToConstant: 50)

        
        
        
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
        
        
        self.contentView.addSubview(imgStar1)
        self.imgStar1.centerYAnchor.constraint(equalTo: lblCompany.centerYAnchor, constant : 0.0).isActive = true
        self.imgStar1.rightAnchor.constraint(equalTo: lblRateCount.rightAnchor, constant : 3.0).isActive = true
        
        self.contentView.addSubview(imgStar2)
        self.imgStar2.centerYAnchor.constraint(equalTo: imgStar1.centerYAnchor, constant : 0.0).isActive = true
        self.imgStar2.rightAnchor.constraint(equalTo: imgStar1.leftAnchor, constant : -3.0).isActive = true
        
        self.contentView.addSubview(imgStar3)
        self.imgStar3.centerYAnchor.constraint(equalTo: imgStar1.centerYAnchor, constant : 0.0).isActive = true
        self.imgStar3.rightAnchor.constraint(equalTo: imgStar2.leftAnchor, constant : -3.0).isActive = true
        
        self.contentView.addSubview(imgStar4)
        self.imgStar4.centerYAnchor.constraint(equalTo: imgStar1.centerYAnchor, constant : 0.0).isActive = true
        self.imgStar4.rightAnchor.constraint(equalTo: imgStar3.leftAnchor, constant : -3.0).isActive = true
        
        self.contentView.addSubview(imgStar5)
        self.imgStar5.centerYAnchor.constraint(equalTo: imgStar1.centerYAnchor, constant : 0.0).isActive = true
        self.imgStar5.rightAnchor.constraint(equalTo: imgStar4.leftAnchor, constant : -3.0).isActive = true
        
        
        self.lblEstPrice = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        self.lblEstPrice.font = UIFont(name: "HelveticaNeue-Bold", size: 13)
        self.lblEstPrice.textColor = UIColor(red: 30/255, green: 131/255, blue: 186/255, alpha: 1)
        self.lblEstPrice.textAlignment = NSTextAlignment.right
        self.lblEstPrice.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(lblEstPrice)
        self.lblEstPrice.centerYAnchor.constraint(equalTo: lblSeaterAndQuality.centerYAnchor, constant : 0.0).isActive = true
        self.lblEstPrice.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant : -20.0).isActive = true
        self.lblEstPrice.widthAnchor.constraint(equalToConstant: 50)
        self.lblEstPrice.heightAnchor.constraint(equalToConstant: 30)
        

    }
    
    open  func updateWithModel(_ obj: ChooseDriverObject) {
        
        
        let url = obj.driverId != nil ? SClientData.ServerURL + "/avatar/driver/\(obj.driverId!)" : ""
        
        self.imgAvatar.af_setImageWithURL(
            URL(string: url)!,
            placeholderImage: ImageHelper.resize(UIImage(named: "Avatar.png")!, newWidth: ChooseDriverCell.CellHeight - 20),
            filter: AspectScaledToFillSizeWithRoundedCornersFilter(size: self.imgAvatar.frame.size, radius: 20.0),
            imageTransition: .CrossDissolve(0.2)
        )
        
        imgStar1.hidden = !( obj.driverStatus != nil && obj.driverStatus!.Rating >= 1)
        imgStar2.hidden = !( obj.driverStatus != nil && obj.driverStatus!.Rating >= 2)
        imgStar3.hidden = !( obj.driverStatus != nil && obj.driverStatus!.Rating >= 3)
        imgStar4.hidden = !( obj.driverStatus != nil && obj.driverStatus!.Rating >= 4)
        imgStar5.hidden = !( obj.driverStatus != nil && obj.driverStatus!.Rating >= 5)
        lblRateCount.hidden = !( obj.driverStatus != nil && obj.driverStatus!.RateCount > 0)
        lblRateCount.text =  (obj.driverStatus != nil) ? "\(obj.driverStatus!.RateCount) lượt" : ""
        
        self.lblDriverName.text = (obj.driver != nil) ? obj.driver!.Name!.uppercaseString : ""
        self.lblCompany.text =  (obj.driverStatus != nil) ? obj.driverStatus!.CompanyName : ""
        
        var qualityText = ""
        if( obj.driverStatus != nil){
            
            switch obj.driverStatus!.QualityService! {
            case "Popular" : qualityText = "Phổ Thông"
            case "Economic" : qualityText = "Giá Rẻ"
            case "Luxury" : qualityText = " Chất Lượng Cao"
            default: qualityText = ": chưa rõ"
            }
        }
        self.lblSeaterAndQuality.text =   (obj.driverStatus != nil) ? "\(obj.driverStatus!.CarSeater!) chỗ - \(qualityText)" : ""
     
        self.updateEstPrice(obj)
        
    }
    
    open func updateEstPrice(_ obj: ChooseDriverObject){
        if(obj.estPrice == nil){
                obj.loadEstPrice {
                    self.lblEstPrice.text = (obj.estPrice != nil && obj.estPrice! > 0) ? obj.estPrice!.toCurrency(nil, country: obj.driver!.Country!) : ""
                }
        }
        
         self.lblEstPrice.text = (obj.estPrice != nil && obj.estPrice! > 0) ? obj.estPrice!.toCurrency(nil, country: obj.driver!.Country!) : ""
    }
    
    public required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

