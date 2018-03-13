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
import AlamofireObjectMapper
import SClientData
import SClientModel
import CoreLocation
import RealmSwift
import GoogleMaps


open class MapLocation : NSObject{
    
    var parent: TravelOrderScreen
    
    var CurrentOrder: TravelOrder! {
        
        get {
            return SCONNECTING.TaxiManager!.currentOrder
        }
    }
    
    public init(parent: TravelOrderScreen){
        
        self.parent = parent
    }
    
    open func onLocationAuthorized() {
        
            self.parent.mapView.gmsMapView.isMyLocationEnabled = true
    }
    
    open func changeLocation(_ location: CLLocation, isMoved : Bool) {
        
            if( self.parent.mapView.shouldToMoveToCurrentLocaton){
               // ravelView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
                self.parent.mapView.gmsMapView.animate(toLocation: location.coordinate)
                
                let northEast = CLLocationCoordinate2DMake(location.coordinate.latitude + 5, location.coordinate.longitude + 5)
                let southWest = CLLocationCoordinate2DMake(location.coordinate.latitude - 5, location.coordinate.longitude - 5)
                let bounds = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
               
                self.parent.placeSearcher.searchResultController.autocompleteBounds = bounds
                
                self.parent.mapView.shouldToMoveToCurrentLocaton = false
            }
            
        
    }
    
    
}
