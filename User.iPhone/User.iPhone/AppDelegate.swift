//
//  AppDelegate.swift
//  User.iPhone
//
//  Created by Trung Dao on 4/13/16.
//  Copyright © 2016 SCONNECTING. All rights reserved.
//

import UIKit
import SClientModel
import SClientData
import SClientModelControllers
import GooglePlaces
import GoogleMaps

@UIApplicationMain
open class AppDelegate: UIResponder, UIApplicationDelegate {
    
    open static var ServerURL: String =  "http://localhost:8000"
    open static var ChatSocketURL: String =  "http://localhost:4060"
    open static var TaxiNofifySocketURL: String =  "http://localhost:4050"
    open static var GoogleMapKey: String = "AIzaSyAusUO0JarHwoFFGeqVfOPHUEADDZQyTLs"
    open static var GooglePlaceKey: String = "AIzaSyBArZgCF0ZcAyHsIqVXbnVg-LbT-ySi6L0"
    
    open static var welcomeWindow: WelcomeWindow?
    open static var mainWindow: MainWindow?
    open static var introWindow: IntroduceWindow?
    open static var  activationWindow: ActivationWindow?
   
    open func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UIApplication.shared.isIdleTimerDisabled = true
        
        AppDelegate.welcomeWindow = WelcomeWindow(frame: UIScreen.main.bounds)
        AppDelegate.welcomeWindow?.makeKeyAndVisible()
        
        UserDefaults.standard.set(["vi"], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
        SClientData.ServerURL = AppDelegate.ServerURL
        ChatSocket.ServerURL = AppDelegate.ChatSocketURL
        TaxiSocket.ServerURL = AppDelegate.TaxiNofifySocketURL

        GMSPlacesClient.provideAPIKey(AppDelegate.GooglePlaceKey)
        GMSServices.provideAPIKey(AppDelegate.GoogleMapKey)

        SCONNECTING.Init{
        
            
                if UserDefaults.standard.string(forKey: "alreadyIntro") == nil{
                    
                    AppDelegate.introWindow = IntroduceWindow(frame: UIScreen.main.bounds)
                    AppDelegate.introWindow?.makeKeyAndVisible()
                
                }else{
                
                    
                    SCUserManager.isValidDevice({ (isValid) in
                        
                        if(isValid == false){
                            
                            AppDelegate.activationWindow = ActivationWindow(frame: UIScreen.main.bounds)
                            AppDelegate.activationWindow?.makeKeyAndVisible()
                            
                        }else{
                                                    
                            SCONNECTING.UserManager?.initCurrentUser{ isValidUser in
                                
                                if(isValidUser == false){
                                    
                                    AppDelegate.activationWindow = ActivationWindow(frame: UIScreen.main.bounds)
                                    AppDelegate.activationWindow?.makeKeyAndVisible()
                                    
                                }else{
                                    SCONNECTING.Start {
                                            
                                        if( AppDelegate.mainWindow  == nil){
                                            AppDelegate.mainWindow = MainWindow(frame: UIScreen.main.bounds)
                                            AppDelegate.mainWindow?.makeKeyAndVisible()
                                        }
                                       
                                    }
                                }
                            }
                            
                        }
                        
                    })
            }
        
        }
        

        
        /*UserController.RequestForActivationCode("84905798117", countryCode: "VN") { (requestId) in
             print(requestId)
            
        }
 */
        /*
        UserController.CheckForActivationCode("144", code: "2344", phoneNo: "84905798117") { (UserId, errorcode) in
             print(UserId)
        }
 */
        return true
    }
    
    
    open func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("DEVICE TOKEN = \(deviceToken)")
    }
  
    
    open func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }

    
   open func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        print(userInfo)
    }
    
    
    
    open func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    open func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

   open func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    open func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        if( AppDelegate.mainWindow != nil){
            AppDelegate.mainWindow!.mainViewCtrl?.taxiViewCtrl.mapView.shouldToMoveToCurrentLocaton = true
        }
    }

   open func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

