//
//  GoogleMapUtil.swift
//  User.iPhone
//
//  Created by Trung Dao on 5/20/16.
//  Copyright © 2016 SCONNECTING. All rights reserved.
//

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

open class GoogleMapUtil{
    
    open static func getDistance(_ srcLocation: CLLocationCoordinate2D , destLocation: CLLocationCoordinate2D, completion: ((_ routes: [JSON]?) -> ())?){
        
        let url = SClientData.ServerURL + "/googlemap/distance?orgLat=\(srcLocation.latitude)&orgLong=\(srcLocation.longitude)&desLat=\(destLocation.latitude)&desLong=\(destLocation.longitude)"
        
        
        Alamofire.request(.GET, url, parameters: nil).responseJSON { response in
            
            switch response.result {
                
            case .Success(let data):
                
                let json = JSON(data)
                let errornum = json["error"]
                if (errornum == true){
                    
                    completion?(routes: nil)
                }else{
                    
                    let routes = json["routes"].array
                    completion!(routes: routes)
                    
                    
                }
                
            case .Failure(let error):
                
                completion?(routes: nil)
                print("Request failed with error: \(error)")
                
            }
        }
        
        
    }
    
    
    open static func getAddress(_ coordinate: CLLocationCoordinate2D, completion: ((_ address: String?, _ country: String?) -> ())?) {
        
        /*
        let geocoder = GMSGeocoder()
    
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let address = response?.firstResult() {
                
               let countryCode =  RegionalHelper.getCountryCodeFromName(address.country!)
                completion?(address: address.lines!.joinWithSeparator("\n"), country: countryCode)
            }else{
                completion?(address: nil,country : nil)
            }
        }
        
 */
        
        let url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(coordinate.latitude),\(coordinate.longitude)&key=\( AppDelegate.GooglePlaceKey)&language=vi&result_type=street_address"
        
        
        Alamofire.request(.GET, url, parameters: nil).responseJSON { response in
            
            switch response.result {
                
            case .success(let data):
                
                let json = JSON(data)
                let errornum = json["error"]
                if (errornum == true){
                    
                    completion?(address: nil,country : nil)

                }else{
                    
                    let results = json["results"].array!.first
                    
                    let address =   results?["formatted_address"].string
                    
                    let addArr = results?["address_components"].array!
                    var countryCode :String?
                    
                    addArr?.forEach({ (item) in
                    
                        item["types"].array!.forEach({ (type) in
                            
                            if(type.stringValue == "country"){
                                
                                countryCode = item["short_name"].stringValue
                                
                            }
                        })
                    
                    })
                    
                    completion?(address: address,country : countryCode)


                }
                
            case .failure(let error): break
            
            completion?(address: nil,country : nil)
            }
        }

        
    }
    
}
