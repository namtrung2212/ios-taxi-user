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


open class MainMenu : UITableViewController, DTTableViewManageable {
    
    open var parent: LeftMenuViewController
    
    var rowHeights : [IndexPath: CGFloat] = [:]
    
    public init(parent: LeftMenuViewController){
        
        self.parent = parent
        super.init(style: .grouped)
            
        
        manager.startManagingWithDelegate(self)
        manager.registerCellClass(MenuItemCell)
        manager.registerNiblessHeaderClass(MenuHeaderCell)
        manager.cellSelection(MainMenu.selectedItem)
        
    }
    
    open func initControls(){
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.backgroundColor = UIColor.white
        self.tableView.isScrollEnabled = false
        
    }
    
    open func initLayout(){
        
        self.parent.scrollView.addSubview(self.tableView)
        self.tableView.widthAnchor.constraint(equalTo: self.parent.scrollView.widthAnchor , constant : 0.0).isActive = true
        self.tableView.centerXAnchor.constraint(equalTo: self.parent.lblUserName.centerXAnchor, constant: 0).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.parent.lblUserName.bottomAnchor, constant: 15).isActive = true
        self.tableView.heightAnchor.constraint(equalToConstant: 2000).isActive = true
       
        
    }
    
    open func invalidate( _ completion: (() -> ())?){
        
        self.rowHeights.removeAll()
        
        
        manager.memoryStorage.removeAllItems()
        
        manager.memoryStorage.sections.removeAll()
        
        manager.memoryStorage.setSectionHeaderModel(("Gọi Taxi","Taxi"), forSectionIndex: 0)
        
        manager.memoryStorage.addItem(MenuItemObject(caption: "Tạo hành trình", section: 0, index: 0,leffImage: "NewTravel" ), toSection: 0)
        manager.memoryStorage.addItem(MenuItemObject(caption: "Chưa khởi hành", section: 0, index: 1,leffImage: "NotYetPickup"), toSection: 0)
        manager.memoryStorage.addItem(MenuItemObject(caption: "Trong hành trình", section: 0, index: 2,leffImage: "OnTheWay"), toSection: 0)
        manager.memoryStorage.addItem(MenuItemObject(caption: "Chưa thanh toán", section: 0, index: 3,leffImage: "NotYetPaid"), toSection: 0)
        manager.memoryStorage.addItem(MenuItemObject(caption: "Lịch sử", section: 0, index: 4,leffImage: "History"), toSection: 0)
        
        
        manager.memoryStorage.setSectionHeaderModel(("Đi chung","TripMate"), forSectionIndex: 1)
        
        manager.memoryStorage.addItem(MenuItemObject(caption: "Tạo yêu cầu", section: 1, index: 0), toSection: 1)
        manager.memoryStorage.addItem(MenuItemObject(caption: "Cộng đồng", section: 1, index: 1), toSection: 1)
        manager.memoryStorage.addItem(MenuItemObject(caption: "Chưa có nhóm", section: 1, index: 2), toSection: 1)
        manager.memoryStorage.addItem(MenuItemObject(caption: "Đã có nhóm", section: 1, index: 3), toSection: 1)
        manager.memoryStorage.addItem(MenuItemObject(caption: "Tin nhắn", section: 1, index: 4), toSection: 1)
        manager.memoryStorage.addItem(MenuItemObject(caption: "Thông báo", section: 1, index: 5), toSection: 1)
        
        
        
        manager.memoryStorage.setSectionHeaderModel(("Thẻ thanh toán","PaymentMethod"), forSectionIndex: 2)
        
        manager.memoryStorage.addItem(MenuItemObject(caption: "Tạo thẻ mới", section: 2, index: 0), toSection: 2)
        manager.memoryStorage.addItem(MenuItemObject(caption: "Danh sách thẻ", section: 2, index: 1), toSection: 2)
        manager.memoryStorage.addItem(MenuItemObject(caption: "Tài khoản", section: 2, index: 2), toSection: 2)
        manager.memoryStorage.addItem(MenuItemObject(caption: "Cấp hạn mức", section: 2, index: 3), toSection: 2)
        manager.memoryStorage.addItem(MenuItemObject(caption: "Lịch sử dùng thẻ", section: 2, index: 4), toSection: 2)
        
        self.parent.resetScrollSize()
        
    }
    
    open func selectedItem(_ cell: MenuItemCell, item: MenuItemObject, indexPath: IndexPath) {
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        cell.transform = CGAffineTransform.identity
                                    })
                                    
                                    self.parent.menuItem_Clicked(item)
                                    
                                   
        })
        
        
    }

    open func getPreferedTableHeight() -> CGFloat{
        self.tableView.layoutIfNeeded()
        
        var height : CGFloat = 0
        manager.memoryStorage.sections.forEach { (section) in
            
            height += CGFloat(section.numberOfItems * 40)
            height += CGFloat(40)
        }
       return height
        
    }
    
    open override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{

        return 40
        
    }
    
    open override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
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
