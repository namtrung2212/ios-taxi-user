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


open class ChooseDriverTable : UITableViewController, DTTableViewManageable {
    
    open var parent: ChooseDriverView
    var currentPages = 1

    
    var CurrentOrder: TravelOrder! {
        
        get {
            return  self.parent.CurrentOrder
        }
    }
        

    public init(parent: ChooseDriverView){
        
        self.parent = parent
        super.init(nibName: nil, bundle: nil)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: #selector(ChooseDriverTable.refresh(_:)), for: .valueChanged)
        self.tableView.addSubview(self.refreshControl!)
        
        manager.startManagingWithDelegate(self)
        manager.registerCellClass(ChooseDriverCell)
        manager.cellSelection(ChooseDriverTable.selectedDriver)

    }

    open func initLayout(_ completion: (() -> ())?){
        
        self.parent.pnlDriverListArea.addSubview(self.tableView)
        self.tableView.widthAnchor.constraint(equalTo: self.parent.pnlDriverListArea.widthAnchor , constant : -20.0).isActive = true
        self.tableView.centerXAnchor.constraint(equalTo: self.parent.pnlDriverListArea.centerXAnchor, constant: 0).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.parent.pnlDriverListArea.topAnchor, constant: 40).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.parent.pnlDriverListArea.bottomAnchor, constant: -10).isActive = true
        
        
        completion?()
    }
    
   open func selectedDriver(_ cell: ChooseDriverCell, driverObject: ChooseDriverObject, indexPath: IndexPath) {
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        cell.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                        
                                        DriverProfileScreen.instance  =  DriverProfileScreen(_driverId: driverObject.driver!.id!)
                                        self.CurrentOrder.resetToOpen()
                                        DriverProfileScreen.instance!.setCurrentOrder(self.CurrentOrder!, bidding: driverObject.driverBidding)
                                        self.parent.parent.hideNavigationBar(false)
                                        self.parent.parent.navigationController?.pushViewController(DriverProfileScreen.instance!, animated:true)
                                        
                                    }) 
                                    
        })
        
        
    }
    
    func refresh(_ refreshControl: UIRefreshControl) {
        
        self.refreshDriverList()
        refreshControl.endRefreshing()
    }
    

    func refreshDriverList(){
        
        currentPages = 1
        
        self.manager.memoryStorage.removeAllItems()
        
        self.loadDrivers()
        
    }
    
    func loadDrivers(){
        
        if(self.CurrentOrder!.IsExpired()){
            return
        }
        
       self.loadBiddingDrivers()
       self.loadNearestDrivers()
    
    }
    
    func loadBiddingDrivers(){
        
        if(self.CurrentOrder!.IsExpired()){
            return
        }
        
        if(self.CurrentOrder!.isNew() == false){
            
            TravelOrderController.GetOrderBiddings(self.CurrentOrder!.id!) { (biddings) in
                
                ChooseDriverObject.fromArray(self.CurrentOrder, arrStatus: nil, arrBidding: biddings, completion: { (items) in
                    if( items.count > 0){
                        self.manager.memoryStorage.addItems(Array(items.values))
                    }
                })
                
            }
        }
    }

    func loadNearestDrivers(){
        
        if(self.CurrentOrder!.IsExpired()){
            return
        }
        
        
        if(self.CurrentOrder!.IsPickupNow()){
            
            DriverController.GetNearestDrivers(self.CurrentOrder!.OrderPickupLoc!.coordinate(),page: currentPages,pagesize: 20, serverHandler: { (driverStatuss) in
                
                ChooseDriverObject.fromArray(self.CurrentOrder, arrStatus: driverStatuss, arrBidding: nil, completion: { (items) in
                    if( items.count > 0){
                        self.manager.memoryStorage.addItems(Array(items.values))
                    }
                })
                
            })
            
        }
    }

    
    func loadMoreDrivers(){
        
        if(self.CurrentOrder!.IsPickupNow()){

            currentPages += 1
            self.loadNearestDrivers()
            
        }
    }
    
    open override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        
        if ((indexPath.section == lastSectionIndex) && (indexPath.row == lastRowIndex)) {
           
            self.loadMoreDrivers()
        }
        
        if((cell as! ChooseDriverCell).lblEstPrice!.text == ""){
            
            let model = self.manager.storage.itemAtIndexPath(indexPath)! as! ChooseDriverObject
            (cell as! ChooseDriverCell).updateEstPrice(model)
            
        }
    }
    
    open override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return ChooseDriverCell.CellHeight
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
