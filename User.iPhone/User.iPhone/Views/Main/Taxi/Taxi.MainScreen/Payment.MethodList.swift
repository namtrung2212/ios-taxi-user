//
//  Order.ChooseDriver.DriverList.swift
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


open class ChoosePaymentMethodTable : UITableViewController, DTTableViewManageable {
    
    open var parent: ChoosePaymentMethodView
    var currentPages = 1
    
    var CurrentOrder: TravelOrder! {
        
        get {
            return  self.parent.CurrentOrder
        }
    }
        

    public init(parent: ChoosePaymentMethodView){
        
        self.parent = parent
        super.init(nibName: nil, bundle: nil)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: #selector(ChoosePaymentMethodTable.refresh(_:)), for: .valueChanged)
        self.tableView.addSubview(self.refreshControl!)
        
        manager.startManagingWithDelegate(self)
        manager.registerCellClass(ChoosePaymentMethodCell)
        manager.cellSelection(ChoosePaymentMethodTable.selectedMethod)

    }

    open func initLayout(_ completion: (() -> ())?){
        
        self.parent.pnlMethodListArea.addSubview(self.tableView)
        self.tableView.widthAnchor.constraint(equalTo: self.parent.pnlMethodListArea.widthAnchor , constant : -20.0).isActive = true
        self.tableView.centerXAnchor.constraint(equalTo: self.parent.pnlMethodListArea.centerXAnchor, constant: 0).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.parent.pnlMethodListArea.topAnchor, constant: 40).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.parent.pnlMethodListArea.bottomAnchor, constant: -10).isActive = true
        
        completion?()

    }
    
    func selectedMethod(_ cell: ChoosePaymentMethodCell, object: ChoosePaymentMethodObject, indexPath: IndexPath) {
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        cell.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                        
                                        if(object.userPayCard != nil){
                                            let alert = UIAlertController(title: "Bạn muốn thanh toán ?  ", message: "Thẻ \(object.userPayCard!.Bank!) - \(object.userPayCard!.CardNo!) sẽ được dùng để thanh toán số tiền \(self.CurrentOrder!.ActPrice.toCurrency(self.CurrentOrder!.Currency, country: nil)!)", preferredStyle: UIAlertControllerStyle.Alert)
                                            
                                            alert.addAction(UIAlertAction(title: "Thanh toán", style: .Default, handler: { (action: UIAlertAction!) in
                                                
                                                SCONNECTING.TaxiManager!.paid(self.CurrentOrder, userpaycard: object.userPayCard!, completion: { (item) in
                                                    
                                                    SCONNECTING.TaxiManager!.reset(true){
                                                        
                                                    }
                                                    
                                                })
                                                
                                            }))
                                            
                                            alert.addAction(UIAlertAction(title: "Không", style: .Cancel, handler: { (action: UIAlertAction!) in
                                                
                                                
                                            }))
                                            
                                            AppDelegate.mainWindow?.mainViewCtrl.presentViewController(alert, animated: true, completion: nil)
                                            
                                        }else  if(object.businessCard != nil){
                                            
                                            let alert = UIAlertController(title: "Bạn muốn thanh toán ?  ", message: "Thẻ \(object.businessCard!.AccountNo!) - \(object.businessCard!.BusinessName!) sẽ được dùng để thanh toán số tiền \(self.CurrentOrder!.ActPrice.toCurrency(self.CurrentOrder!.Currency, country: nil)!)", preferredStyle: UIAlertControllerStyle.Alert)
                                            
                                            alert.addAction(UIAlertAction(title: "Thanh toán", style: .Default, handler: { (action: UIAlertAction!) in
                                                
                                                SCONNECTING.TaxiManager!.paid(self.CurrentOrder, businessCard: object.businessCard!, completion: { (item) in
                                                    
                                                    SCONNECTING.TaxiManager!.reset(true){
                                                        
                                                    }
                                                    
                                                })
                                                
                                            }))
                                            
                                            alert.addAction(UIAlertAction(title: "Không", style: .Cancel, handler: { (action: UIAlertAction!) in
                                                
                                                
                                            }))
                                            
                                            AppDelegate.mainWindow?.mainViewCtrl.presentViewController(alert, animated: true, completion: nil)
                                            
                                        
                                    }
                                        
                                    }) 
        })
        
        
    }
    
    
    func refresh(_ refreshControl: UIRefreshControl) {
        
        self.refreshMethodList()
        refreshControl.endRefreshing()
    }
    

    func refreshMethodList(){
        
        currentPages = 1
        
        self.manager.memoryStorage.removeAllItems()
        
        self.loadItems()
        
    }
    
    func loadItems(){
        
        let query = "User=\(self.CurrentOrder!.User!)&Currency=\(self.CurrentOrder!.Currency)&IsVerified=1&IsExpired=0&IsLocked=0&pagesize=20&page=\(currentPages)"
         DataManager<UserPayCard>.queryServer("selectall", filter: query) { (cards) in
            
                ChoosePaymentMethodObject.fromArray(self.CurrentOrder!, arrUserCard: cards, arrBusinessCard: nil, completion: { (items) in
                    if(items != nil && items!.count > 0){
                        self.manager.memoryStorage.addItems(items!)
                    }
                })
            
        }

        let query2 = "AssignedUser=\(self.CurrentOrder!.User!)&Currency=\(self.CurrentOrder!.Currency)&IsActivated=1&IsExpired=0&IsLocked=0&pagesize=20&page=\(currentPages)"
        DataManager<BusinessCardBudget>.queryServer("selectall", filter: query2) { (cards) in
            
            ChoosePaymentMethodObject.fromArray(self.CurrentOrder!, arrUserCard: nil, arrBusinessCard: cards, completion: { (items) in
                if(items != nil && items!.count > 0){
                    self.manager.memoryStorage.addItems(items!)
                }
            })

        }

    }
    
    func loadMoreItems(){
        
            currentPages += 1
            self.loadItems()
    }
    
    open override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        
        if ((indexPath.section == lastSectionIndex) && (indexPath.row == lastRowIndex)) {
           
            self.loadMoreItems()
        }
        
        
        let model = self.manager.storage.itemAtIndexPath(indexPath)! as! ChoosePaymentMethodObject
        (cell as! ChoosePaymentMethodCell).updateWithModel(model)
        
    }
    
    open override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return ChoosePaymentMethodCell.CellHeight
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
