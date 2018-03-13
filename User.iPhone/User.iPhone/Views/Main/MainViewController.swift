//
//  MainViewController.swift
//  User.iPhone
//
//  Created by Trung Dao on 4/13/16.
//  Copyright © 2016 SCONNECTING. All rights reserved.
//
import UIKit
import Foundation
import ObjectMapper
import AlamofireObjectMapper
import SClientData
import SClientModel
import SClientUI
import CoreLocation
import RealmSwift
import GoogleMaps

open class MainViewController: UITabBarController,UITabBarControllerDelegate {
    
    
    open var taxiViewCtrl : TravelOrderScreen!
    open var taxiNAVCtrl : UINavigationController!
    
    open var tripMateViewCtrl : TripMateViewController!
    open var tripMateNAVCtrl : UINavigationController!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.initControls{
            self.delegate = self
        }
    }
    
    
    func initControls(_ completion: (() -> ())?){
        
        
        
        taxiViewCtrl =  TravelOrderScreen(nibName: nil, bundle: nil)
        taxiNAVCtrl = UINavigationController(rootViewController: taxiViewCtrl)
        taxiViewCtrl.navigationController?.isNavigationBarHidden = false
        taxiNAVCtrl.navigationBar.barStyle = .default
        taxiNAVCtrl.navigationBar.layer.shadowColor = UIColor.gray.cgColor
        taxiNAVCtrl.navigationBar.layer.shadowOpacity = 0.7
        taxiNAVCtrl.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 3)
        taxiNAVCtrl.navigationBar.layer.shadowRadius = 2.5
        taxiNAVCtrl.navigationBar.layer.shouldRasterize = true
        taxiNAVCtrl.navigationBar.layer.shadowPath = UIBezierPath(rect: taxiNAVCtrl.navigationBar.bounds).cgPath

        tripMateViewCtrl =  TripMateViewController(nibName: nil, bundle: nil)
        tripMateNAVCtrl = UINavigationController(rootViewController: tripMateViewCtrl)
        tripMateViewCtrl.navigationController?.isNavigationBarHidden = false
        tripMateNAVCtrl.navigationBar.barStyle = .default
        
        self.viewControllers = [taxiNAVCtrl,tripMateNAVCtrl]
        self.selectedIndex = 0
        
        completion?()
        
    }
    
    open func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // just return the custom TransitioningObject object that conforms to UIViewControllerAnimatedTransitioning protocol
        let animatedTransitioningObject = TransitioningObject()
        return animatedTransitioningObject
    }
    
    
    
    
}





open class TransitioningObject: NSObject, UIViewControllerAnimatedTransitioning {
    
   open  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromView: UIView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView: UIView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        transitionContext.containerView.addSubview(fromView)
        transitionContext.containerView.addSubview(toView)
        
        UIView.transition(from: fromView, to: toView, duration: transitionDuration(using: transitionContext), options: UIViewAnimationOptions.showHideTransitionViews) { finished in
            transitionContext.completeTransition(true)
        }
    }
    
   open  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
}
