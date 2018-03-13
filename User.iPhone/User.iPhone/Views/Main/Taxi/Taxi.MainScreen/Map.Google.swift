//
//  TravelOrderScreen.swift
//  User.iPhone
//
//  Created by Trung Dao on 4/13/16.
//  Copyright © 2016 SCONNECTING. All rights reserved.
//
import UIKit
import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper
import SClientData
import SClientModel
import CoreLocation
import RealmSwift
import SwiftyJSON
import GoogleMaps


open class MapView : NSObject, GMSMapViewDelegate{
    
    var parent: TravelOrderScreen
    
    var shouldToMoveToCurrentLocaton: Bool = true
    var shouldToHideControlWhenScroll: Bool = false

    var CurrentOrder: TravelOrder! {
        
        get {
            return SCONNECTING.TaxiManager!.currentOrder
        }
    }

    var currentSourceLoc: CLLocationCoordinate2D?
    var currentDestLoc: CLLocationCoordinate2D?
    
    var gmsMapView: GMSMapView!
    var btnMyLocation: UIButton!
    var pathPolyLine : GMSPolyline?
    
    var mSourceMarker : GMSMarker!
    var mDestinyMarker : GMSMarker!

    public init(parent: TravelOrderScreen){
        
        self.parent = parent
    }
    
    func initControls(_ completion: (() -> ())?){
        
        let scrRect = UIScreen.main.bounds
        let camera  = GMSCameraPosition.camera(withLatitude: 0.702812, longitude: 106.643604, zoom: 15)
        
        gmsMapView = GMSMapView.map(withFrame: CGRect(x: 0,y: 0,width: scrRect.size.width, height: scrRect.size.height), camera: camera)
        gmsMapView.isMyLocationEnabled = true
        gmsMapView.settings.myLocationButton = false
        gmsMapView.settings.scrollGestures = true
        gmsMapView.settings.zoomGestures = true
        gmsMapView.settings.tiltGestures = true
        gmsMapView.settings.rotateGestures = true
        
        gmsMapView.mapType = kGMSTypeNormal
        
        gmsMapView.delegate = self
        gmsMapView.padding = UIEdgeInsets(top: self.parent.topLayoutGuide.length, left: 0,bottom: 100, right: 0)
        self.parent.view.addSubview(gmsMapView)
        
        
        // My Location Button
        let imgLoc = ImageHelper.resize(UIImage(named: "MyLocation.png")!, newWidth: 32)
        btnMyLocation   = UIButton(type: UIButtonType.custom) as UIButton
        btnMyLocation.frame = CGRect(x: 32, y: 32, width: 32, height: 32)
        btnMyLocation.setImage(imgLoc, forState: .Normal)
        btnMyLocation.alpha = 0.6
        let imgHighlighted = ImageHelper.effectBlur(imgLoc)
        btnMyLocation.setImage(imgHighlighted, forState: .Highlighted)
        btnMyLocation.translatesAutoresizingMaskIntoConstraints = false
        self.parent.view.addSubview(btnMyLocation)              
        btnMyLocation.addTarget(self, action: #selector(MapView.btnMyLocation_Clicked(_:)), for:.touchUpInside)

        
        
        mSourceMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        mSourceMarker.title = "Điểm đi"
        let imgSourcePin =  ImageHelper.resize(UIImage(named: "sourcePin.png")!, newWidth: 40)
        let sourcePinView = UIImageView(image: imgSourcePin)
        mSourceMarker.iconView = sourcePinView
        mSourceMarker.groundAnchor = CGPoint(x: 0.5, y: 1);
        mSourceMarker.tracksViewChanges = true
       // mSourceMarker.map = self.gmsMapView
        
        mDestinyMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        mDestinyMarker.title = "Điểm đến"
        let imgDestinyPin =  ImageHelper.resize(UIImage(named: "destinyPin.png")!, newWidth: 40)
        let destinyPinView = UIImageView(image: imgDestinyPin)
        mDestinyMarker.iconView = destinyPinView
        mDestinyMarker.groundAnchor = CGPoint(x: 0.5, y: 1);
        mDestinyMarker.tracksViewChanges = true
        //mDestinyMarker.map = self.gmsMapView
        
        
        completion?()

    }
    
    func initLayout(_ completion: (() -> ())?){
        
       
        btnMyLocation.centerXAnchor.constraint(equalTo: self.parent.view.rightAnchor, constant: -30.0).isActive = true
        btnMyLocation.centerYAnchor.constraint(equalTo: self.parent.view.topAnchor, constant: 95.0).isActive = true
        
        completion?()
    }
    
    func invalidate(_ isFirstTime: Bool,completion: (() -> ())?){
        
       // self.gmsMapView.userInteractionEnabled = (self.parent.isChoosingLocationPhase ||  self.parent.isMonitoringPhase)
          gmsMapView.isMyLocationEnabled = !self.parent.isMonitoringPhase
        var sourceLoc: CLLocationCoordinate2D?
        var destinyLoc: CLLocationCoordinate2D?
        
        if( self.CurrentOrder.OrderPickupLoc != nil){
            sourceLoc = self.CurrentOrder.OrderPickupLoc!.coordinate()
        }
        
        if( self.CurrentOrder.ActPickupLoc != nil){
            sourceLoc = self.CurrentOrder.ActPickupLoc!.coordinate()
        }
        
        if( self.CurrentOrder.OrderDropLoc != nil){
            destinyLoc = self.CurrentOrder.OrderDropLoc!.coordinate()
        }
        
        if( self.CurrentOrder.ActDropLoc != nil){
            destinyLoc = self.CurrentOrder.ActDropLoc!.coordinate()
        }
        
        UIView.animate(withDuration: 1, animations: {
            
            self.mSourceMarker.iconView.isHidden = ( sourceLoc == nil )
            if( self.mSourceMarker.iconView.isHidden == false){
           
                self.mSourceMarker.map = self.gmsMapView
                self.mSourceMarker.position = sourceLoc!
                self.mSourceMarker.map?.selectedMarker = self.mSourceMarker
           
            }else{
                
                self.mSourceMarker.map = nil
            
            }
            
            self.mDestinyMarker.iconView.isHidden = ( destinyLoc == nil )
            if( self.mDestinyMarker.iconView.isHidden == false){
                
                self.mDestinyMarker.map = self.gmsMapView
                self.mDestinyMarker.position = destinyLoc!
                self.mDestinyMarker.map?.selectedMarker = self.mDestinyMarker
                
            }else{
                
                self.mDestinyMarker.map = nil
                
            }
            
            if(isFirstTime){
                
                self.parent.mapView.clearPathPolyLine{
                    if(sourceLoc != nil && destinyLoc != nil){
                        self.addPathPolyLine(true,srcLocation:  sourceLoc!, destLocation: destinyLoc!)
                    }
                }
                
            }else{
            
                if( sourceLoc != nil  &&  destinyLoc != nil ){
                        self.addPathPolyLine(false,srcLocation:  sourceLoc!, destLocation: destinyLoc!)
                }else{
                        self.parent.mapView.clearPathPolyLine(nil)
                }
            }
        
        }) 
        
        if(self.CurrentOrder == nil || self.CurrentOrder.IsStopped()){
            self.parent.mapMarkerManager.hideCars()
        }
        completion?()
        

        
    }
        
}


