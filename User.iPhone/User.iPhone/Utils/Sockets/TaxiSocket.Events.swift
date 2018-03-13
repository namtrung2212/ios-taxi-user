//
//  TaxiSocket.Actions.swift
//  Driver.iPhone
//
//  Created by Trung Dao on 6/19/16.
//  Copyright © 2016 SCONNECTING. All rights reserved.
//

import Foundation


public protocol TaxiSocketDelegate {
    
    func onTaxiSocketLogged(_ data : [AnyObject])
    
    func onDriverBidding(_ data : [AnyObject])
    
    func onDriverAccepted(_ data : [AnyObject])
    
    func onDriverRejected(_ data : [AnyObject])
    
    func onCarUpdateLocation(_ data : [AnyObject])
    
    func onDriverVoidedBfPickup(_ data : [AnyObject])
    
    func onDriverStartedTrip(_ data : [AnyObject])
    
    func onDriverVoidedAfPickup(_ data : [AnyObject])
    
    func onDriverFinished(_ data : [AnyObject])
    
    func onDriverCashPaid(_ data : [AnyObject])
    
}


extension TaxiSocket {
    
    
    
    
}
