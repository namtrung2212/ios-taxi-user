//
//  Driver.Profile.Comment.swift
//  User.iPhone
//
//  Created by Trung Dao on 6/1/16.
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


open class CommentView : UITableViewController, DTTableViewManageable {
    
    open var parent: DriverProfileScreen
    
    var currentPages = 1
    var rowHeights : [IndexPath: CGFloat] = [:]
    
    public init(parent: DriverProfileScreen){
        
        self.parent = parent
        super.init(nibName: nil, bundle: nil)
        
        
        manager.startManagingWithDelegate(self)
        manager.registerCellClass(CommentCell)
        // manager.cellSelection(ChooseDriverUI.selectedDriver)
        
    }
    
    open func initControls(){
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.isScrollEnabled = false

    }
    
    open func initLayout(){
        
        self.parent.containerView.addSubview(self.tableView)
        self.tableView.widthAnchor.constraint(equalTo: self.parent.profileView.pnlProfileArea.widthAnchor , constant : 0.0).isActive = true
        self.tableView.centerXAnchor.constraint(equalTo: self.parent.profileView.pnlProfileArea.centerXAnchor, constant: 0).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.parent.lblStatus.bottomAnchor, constant: 55).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.parent.containerView.bottomAnchor, constant: -10).isActive = true
        

    }
    
    open func invalidate(){
        
        currentPages = 1
        self.rowHeights.removeAll()
        
        TravelOrderController.GetOrderComments(self.parent.driver!.id!,page: currentPages, pagesize: 10) { (orders) in
            self.manager.memoryStorage.removeAllItems()
            self.manager.memoryStorage.addItems(orders)
            
            self.loadMoreComments()
            
            self.parent.resetScrollSize()

        }
        
    }
    
    
    open func loadMoreComments(){
        
        
        if(currentPages < 0){
            return
        }
        
        //self.parent.btnLoadMore.hidden = (currentPages <= 0)
        currentPages += 1
        
        TravelOrderController.GetOrderComments(self.parent.driver!.id!,page: currentPages, pagesize: 10) { (orders) in
            if(orders.count > 0){
                self.manager.memoryStorage.addItems(orders)
                self.parent.resetScrollSize()
                self.parent.btnLoadMore.hidden = false

            }else{
                self.currentPages = -1
                self.parent.btnLoadMore.hidden = true

            }
        }
        
    }
    

    
    
    open func getPreferedTableHeight() -> CGFloat{
        self.tableView.layoutIfNeeded()
        
        var sumHeight: CGFloat = 0
        self.rowHeights.values.forEach { (height) in
            sumHeight += height
        }
        return sumHeight
    }
    
    open override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        let scrRect = UIScreen.main.bounds
        
        let model = self.manager.storage.itemAtIndexPath(indexPath)! as! TravelOrder
        
        let height = UILabel.appearance().font.fontWithSize(12).sizeOfJustifiedString(model.Comment!, constrainedToWidth: CommentCell.CommentLabelWidth).height + 60
        
        self.rowHeights[indexPath] = height
        
        return height
        
    }
    
    open override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        
        if ((indexPath.section == lastSectionIndex) && (indexPath.row == lastRowIndex)) {
            
            
        }
        
    }

    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
