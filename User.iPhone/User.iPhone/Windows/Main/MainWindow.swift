//
//  MainWindow.swift
//  User.iPhone
//
//  Created by Trung Dao on 5/4/16.
//  Copyright © 2016 SCONNECTING. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper
import SClientData
import SClientModel
import SClientUI
import CoreLocation
import RealmSwift
import SwiftyJSON
import GoogleMaps

open class MainWindow: UIWindow, UITabBarControllerDelegate{
    
    
    open var leftMenu : SlideMenuController!
    open var leftViewCtrl : LeftMenuViewController!
    
    open var newsFeedViewCtrl : UIViewController!
    open var newsFeedNAVCtrl : UINavigationController!
    
    open var messageViewCtrl : UIViewController!
    open var messageNAVCtrl : UINavigationController!
    
    open var mainViewCtrl : MainViewController!
    
    open var notificationViewCtrl : UIViewController!
    open var notificationNAVCtrl : UINavigationController!
    
    
    open var otherViewCtrl : UIViewController!
    open var otherNAVCtrl : UINavigationController!

    open var rootTabCtrl : UITabBarController!

    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initAppearance()
        
        self.bounds = UIScreen.main.bounds
        self.backgroundColor = UIColor.white
        
        
        newsFeedViewCtrl =  UIViewController(nibName: nil , bundle: nil)
        newsFeedNAVCtrl = UINavigationController(rootViewController: newsFeedViewCtrl)
        newsFeedViewCtrl.navigationController?.isNavigationBarHidden = false
        
        messageViewCtrl =  UIViewController(nibName: nil, bundle: nil)
        messageNAVCtrl = UINavigationController(rootViewController: messageViewCtrl)
        messageViewCtrl.navigationController?.isNavigationBarHidden = false
        
        mainViewCtrl =  MainViewController(nibName: nil, bundle: nil)
        
        notificationViewCtrl =  UIViewController(nibName: nil, bundle: nil)
        notificationNAVCtrl = UINavigationController(rootViewController: notificationViewCtrl)
        notificationViewCtrl.navigationController?.isNavigationBarHidden = false
        
        otherViewCtrl =  UIViewController(nibName: nil, bundle: nil)
        otherNAVCtrl = UINavigationController(rootViewController: otherViewCtrl)
        otherViewCtrl.navigationController?.isNavigationBarHidden = false
        
        rootTabCtrl = UITabBarController()
        rootTabCtrl.viewControllers = [newsFeedNAVCtrl,messageNAVCtrl,mainViewCtrl,notificationNAVCtrl,otherNAVCtrl]
        rootTabCtrl.selectedIndex = 2
        
        
        leftViewCtrl =  LeftMenuViewController(nibName: nil, bundle: nil)
        leftMenu = SlideMenuController(mainViewController: rootTabCtrl, leftMenuViewController: leftViewCtrl)
        leftMenu.delegate = leftViewCtrl
        
        self.rootViewController = leftMenu
        
        let image1 = ImageHelper.resize(UIImage(named: "Newsfeed.png")!, newWidth: 27)
        newsFeedNAVCtrl.tabBarItem = UITabBarItem( title: "Bảng tin", image: image1, tag: 1)
        //newsFeedNAVCtrl.tabBarItem.setFAIcon(FAType.FANewspaperO)
        
        let image2 = ImageHelper.resize(UIImage(named: "Message.png")!, newWidth: 27)
        messageNAVCtrl.tabBarItem = UITabBarItem( title: "Tin nhắn", image: image2, tag: 2)
       // messageNAVCtrl.tabBarItem.setFAIcon(FAType.FACommentO)
        
      //  let image3 = ImageHelper.resize(UIImage(named: "Map.png")!, newWidth: 30)
        mainViewCtrl.tabBarItem = UITabBarItem( title: "", image: nil, tag: 3)
        mainViewCtrl.tabBarItem.setFAIcon(FAType.faStreetView, size: 45)
        mainViewCtrl.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        
        
        let image4 = ImageHelper.resize(UIImage(named: "Info.png")!, newWidth: 27)
        notificationNAVCtrl.tabBarItem = UITabBarItem( title: "Thông báo", image: image4, tag: 4)
      //  notificationNAVCtrl.tabBarItem.setFAIcon(FAType.FAExclamationCircle)
        
        let image5 = ImageHelper.resize(UIImage(named: "Other.png")!, newWidth: 27)
        otherNAVCtrl.tabBarItem = UITabBarItem( title: "Khác", image: image5, tag: 5)
       // otherNAVCtrl.tabBarItem.setFAIcon(FAType.FAEllipsisH, size: 30)
        
        rootTabCtrl.tabBar.layer.shadowColor = UIColor.gray.cgColor
        rootTabCtrl.tabBar.layer.shadowOpacity = 0.7
        rootTabCtrl.tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        rootTabCtrl.tabBar.layer.shadowRadius = 2.5
        rootTabCtrl.tabBar.layer.shadowPath = UIBezierPath(rect: rootTabCtrl.tabBar.bounds).cgPath
        rootTabCtrl.tabBar.layer.shouldRasterize = true
        rootTabCtrl.delegate = self
        
        newsFeedNAVCtrl.navigationBar.barStyle = .default
        messageNAVCtrl.navigationBar.barStyle = .default
        notificationNAVCtrl.navigationBar.barStyle = .default
        otherNAVCtrl.navigationBar.barStyle = .default
        
        newsFeedNAVCtrl.navigationBar.layer.shadowColor = UIColor.gray.cgColor
        newsFeedNAVCtrl.navigationBar.layer.shadowOpacity = 0.7
        newsFeedNAVCtrl.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 3)
        newsFeedNAVCtrl.navigationBar.layer.shadowRadius = 2.5
        newsFeedNAVCtrl.navigationBar.layer.shouldRasterize = true
        newsFeedNAVCtrl.navigationBar.layer.shadowPath = UIBezierPath(rect: newsFeedNAVCtrl.navigationBar.bounds).cgPath
        
        
        messageNAVCtrl.navigationBar.layer.shadowColor = UIColor.gray.cgColor
        messageNAVCtrl.navigationBar.layer.shadowOpacity = 0.7
        messageNAVCtrl.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 3)
        messageNAVCtrl.navigationBar.layer.shadowRadius = 2.5
        messageNAVCtrl.navigationBar.layer.shouldRasterize = true
        messageNAVCtrl.navigationBar.layer.shadowPath = UIBezierPath(rect: newsFeedNAVCtrl.navigationBar.bounds).cgPath
        

        
        notificationNAVCtrl.navigationBar.layer.shadowColor = UIColor.gray.cgColor
        notificationNAVCtrl.navigationBar.layer.shadowOpacity = 0.7
        notificationNAVCtrl.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 3)
        notificationNAVCtrl.navigationBar.layer.shadowRadius = 2.5
        notificationNAVCtrl.navigationBar.layer.shouldRasterize = true
        notificationNAVCtrl.navigationBar.layer.shadowPath = UIBezierPath(rect: newsFeedNAVCtrl.navigationBar.bounds).cgPath
        
        
        otherNAVCtrl.navigationBar.layer.shadowColor = UIColor.gray.cgColor
        otherNAVCtrl.navigationBar.layer.shadowOpacity = 0.7
        otherNAVCtrl.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 3)
        otherNAVCtrl.navigationBar.layer.shadowRadius = 2.5
        otherNAVCtrl.navigationBar.layer.shouldRasterize = true
        otherNAVCtrl.navigationBar.layer.shadowPath = UIBezierPath(rect: newsFeedNAVCtrl.navigationBar.bounds).cgPath
        
        
        
        rootTabCtrl.tabBar.isHidden = true
        newsFeedNAVCtrl.tabBarController?.tabBar.isHidden = true
        messageNAVCtrl.tabBarController?.tabBar.isHidden = true
        mainViewCtrl.tabBarController?.tabBar.isHidden = true
        notificationNAVCtrl.tabBarController?.tabBar.isHidden = true
        otherNAVCtrl.tabBarController?.tabBar.isHidden = true
        
        
        mainViewCtrl.taxiNAVCtrl.tabBarController?.tabBar.isHidden = true
        mainViewCtrl.tripMateNAVCtrl.tabBarController?.tabBar.isHidden = true

    }
    
    func initAppearance(){
        
        
        UITabBar.appearance().tintColor = UIColor(red: 69/255, green: 151/255, blue: 227/255, alpha: 1)
        UITabBar.appearance().barTintColor = UIColor.white
        
        UITabBarItem.appearance().setTitleTextAttributes([
           // NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 11)!
            ], for: UIControlState())
    
        
        
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().barTintColor =  UIColor(red: 73.0/255.0, green: 139.0/255.0, blue: 199.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().tintColor =  UIColor.white
        
        UINavigationBar.appearance().layer.shadowColor = UIColor.gray.cgColor
        UINavigationBar.appearance().layer.shadowOpacity = 0.7
        UINavigationBar.appearance().layer.shadowOffset = CGSize(width: 0, height: 3)
        UINavigationBar.appearance().layer.shadowRadius = 2.5
        UINavigationBar.appearance().layer.shadowPath = UIBezierPath(rect: UINavigationBar.appearance().bounds).cgPath
        UINavigationBar.appearance().layer.shouldRasterize = true
        
        let attrs = [
            NSForegroundColorAttributeName : UIColor.white,
            NSFontAttributeName : UIFont(name: "HelveticaNeue-Bold", size: 15)!
        ]
        
        UINavigationBar.appearance().titleTextAttributes = attrs
        
        
        UILabel.appearance().font = UIFont(name: "HelveticaNeue-Light", size: 12)
        
       // UIButton.appearance().titleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 12)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
          self.init()
    }
    
    
    open func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController){
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                   tabBarController.tabBar.subviews[viewController.tabBarItem.tag].transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                         tabBarController.tabBar.subviews[viewController.tabBarItem.tag].transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                        
                                    }) 
                                    
        })

        
    }

}
