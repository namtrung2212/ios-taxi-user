
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

open class ChoosePaymentMethodObject{
    
    open var order: TravelOrder?
    open var userPayCard: UserPayCard?
    open var businessCard: BusinessCardBudget?
    
    init(order: TravelOrder? ,userCard: UserPayCard? , businessCard:BusinessCardBudget?){
        
        self.userPayCard = userCard
        self.businessCard = businessCard
        self.order = order
        
    }
    
    open static func fromArray(_ order: TravelOrder? ,arrUserCard: [UserPayCard]?, arrBusinessCard: [BusinessCardBudget]?,completion: ((_ items: [ChoosePaymentMethodObject]?) -> ())?) {
        
        var arrObjects : [ChoosePaymentMethodObject] = []
        var iCount: Int = 0
        
        arrUserCard?.forEach({ (card) in
            
                let obj = ChoosePaymentMethodObject(order: order,userCard: card, businessCard: nil)
            
                arrObjects.append(obj)

                 iCount += 1
                if( iCount == (arrUserCard!.count + ( arrBusinessCard != nil ? arrBusinessCard!.count : 0)) ){
                      completion?(items:arrObjects)
                }
            
        })
        
        arrBusinessCard?.forEach({ (card) in
            
            let obj = ChoosePaymentMethodObject(order: order,userCard: nil, businessCard: card)
            
            arrObjects.append(obj)
            
            iCount += 1
            if( iCount == (arrBusinessCard!.count + ( arrUserCard != nil ? arrUserCard!.count : 0)) ){
                completion?(items:arrObjects)
            }
            
        })
    
    }
}

open class ChoosePaymentMethodCell: UITableViewCell, ModelTransfer {
    
    
    open static var CellHeight: CGFloat = 70
    
    open var lblBank: UILabel!
    open var lblCardNo: UILabel!
    open var lblAccountNo: UILabel!    
    open var lblBusinessName: UILabel!
    open var lblPayableAmount: UILabel!
    open var lblCurrency: UILabel!
    
    
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
        line1.path = UIBezierPath(roundedRect: CGRect(x: 20, y: ChoosePaymentMethodCell.CellHeight  , width: scrRect.width - 78.0, height: 1), cornerRadius: 0).cgPath
        self.backgroundView?.layer.addSublayer(line1)
        
        
        self.lblBusinessName = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        self.lblBusinessName.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        self.lblBusinessName.textColor = UIColor(red: 73.0/255.0, green: 139.0/255.0, blue: 199.0/255.0, alpha: 1.0)
        self.lblBusinessName.textAlignment = NSTextAlignment.left
        self.lblBusinessName.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(lblBusinessName)
        self.lblBusinessName.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant :10.0).isActive = true
        self.lblBusinessName.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant : 15.0).isActive = true
        self.lblBusinessName.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, constant : -20.0).isActive = true
        self.lblBusinessName.heightAnchor.constraint(equalToConstant: 50)
        
        self.lblCardNo = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        self.lblCardNo.font = self.lblCardNo.font.withSize(11)
        self.lblCardNo.textColor = UIColor.gray
        self.lblCardNo.textAlignment = NSTextAlignment.left
        self.lblCardNo.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(lblCardNo)
        self.lblCardNo.topAnchor.constraint(equalTo: lblBusinessName.bottomAnchor, constant : 5.0).isActive = true
        self.lblCardNo.leftAnchor.constraint(equalTo: lblBusinessName.leftAnchor, constant : 0.0).isActive = true
        self.lblCardNo.widthAnchor.constraint(equalTo: lblBusinessName.widthAnchor, constant : 0.0).isActive = true
        self.lblCardNo.heightAnchor.constraint(equalToConstant: 50)
        
        
        self.lblAccountNo = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        self.lblAccountNo.font = self.lblAccountNo.font.withSize(11)
        self.lblAccountNo.textColor = UIColor.gray
        self.lblAccountNo.textAlignment = NSTextAlignment.right
        self.lblAccountNo.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(lblAccountNo)
        self.lblAccountNo.centerYAnchor.constraint(equalTo: lblCardNo.centerYAnchor, constant : 0.0).isActive = true
        self.lblAccountNo.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant : -15.0).isActive = true
        self.lblAccountNo.widthAnchor.constraint(equalTo: lblBusinessName.widthAnchor, constant : 0.0).isActive = true
        self.lblAccountNo.heightAnchor.constraint(equalToConstant: 50)
        
        
        self.lblBank = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        self.lblBank.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        self.lblBank.textColor = UIColor.darkGray
        self.lblBank.textAlignment = NSTextAlignment.left
        self.lblBank.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(lblBank)
        self.lblBank.topAnchor.constraint(equalTo: lblCardNo.bottomAnchor, constant : 5.0).isActive = true
        self.lblBank.leftAnchor.constraint(equalTo: lblCardNo.leftAnchor, constant : 0.0).isActive = true
        self.lblBank.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, constant : -20.0).isActive = true
        self.lblBank.heightAnchor.constraint(equalToConstant: 50)

        
        self.lblPayableAmount = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        self.lblPayableAmount.font = UIFont(name: "HelveticaNeue-Bold", size: 13)
        self.lblPayableAmount.textColor = UIColor(red: 30/255, green: 131/255, blue: 186/255, alpha: 1)
        self.lblPayableAmount.textAlignment = NSTextAlignment.right
        self.lblPayableAmount.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(lblPayableAmount)
        self.lblPayableAmount.centerYAnchor.constraint(equalTo: lblBank.centerYAnchor, constant : 0.0).isActive = true
        self.lblPayableAmount.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant : -20.0).isActive = true
        self.lblPayableAmount.widthAnchor.constraint(equalToConstant: 350)
        self.lblPayableAmount.heightAnchor.constraint(equalToConstant: 30)
        
        

    }
    
    open  func updateWithModel(_ obj: ChoosePaymentMethodObject) {
        
        if(obj.userPayCard != nil){
        
            self.lblBusinessName.text = "\(obj.userPayCard!.BankAccOwner!)".uppercaseString
            self.lblCardNo.text = "Số thẻ: \(obj.userPayCard!.CardNo!)"
            self.lblAccountNo.text =  "TK: \(obj.userPayCard!.BankAcc!)"
            self.lblPayableAmount.text =  obj.userPayCard!.IsExpired ? "Hết hạn" : (obj.userPayCard!.IsLocked ? "Tạm khoá" : "")
            self.lblBank.text = "\(obj.userPayCard!.Bank!)".uppercaseString
        
        }else if(obj.businessCard != nil){
            
            self.lblBusinessName.text = "\(obj.businessCard!.BusinessName!)".uppercaseString
            self.lblCardNo.text = "Số thẻ: \(obj.businessCard!.CardNo!)"
            self.lblAccountNo.text =  "TK: \(obj.businessCard!.AccountNo!)"
            self.lblPayableAmount.text =  obj.businessCard!.PayableAmount.toCurrency(obj.order!.Currency, country: nil)!
            self.lblBank.text = "SCONNECTING".uppercased()

        }
        
    }
    
    public required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

