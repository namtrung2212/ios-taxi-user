

import UIKit
import Foundation
import ObjectMapper
import AlamofireObjectMapper
import SClientData
import SClientModel
import CoreLocation
import RealmSwift
import GoogleMaps
import  SocketIOClientSwift

open class TaxiSocket  {
    
    
    open static var ServerURL: String = "http://localhost:4050"
    open var socket : SocketIOClient
    
    open var delegate: TaxiSocketDelegate?
    
    
    public init(){
        
        socket = SocketIOClient(socketURL: URL(string: TaxiSocket.ServerURL)!, options: [.log(true), .forcePolling(true)])
        socket.reconnects = true
        
        self.addHandlers()
    }
    
    open func connect(_ completion: (() -> ())?){
     
        socket.on("connect") {data, ack in
            self.loggin()
            completion?()
        }
        
        socket.connect()
        
    }
    
    
    open func addHandlers(){
        
        socket.on("disconnect") {data, ack in
            self.socket.connect()
        }

        socket.on("UserLogged") {data, ack in
            self.delegate?.onTaxiSocketLogged(data)
        }
        
        socket.on("DriverBidding") {data, ack in
            self.delegate?.onDriverBidding(data)
        }

        socket.on("DriverAccepted") {data, ack in
           self.delegate?.onDriverAccepted(data)
        }
        
        socket.on("DriverRejected") {data, ack in
            self.delegate?.onDriverRejected(data)
        }
        
        socket.on("CarUpdateLocation") {data, ack in
            self.delegate?.onCarUpdateLocation(data)
        }
        
        socket.on("DriverVoidedBfPickup") {data, ack in
            self.delegate?.onDriverVoidedBfPickup(data)
        }
        
        socket.on("DriverStartedTrip") {data, ack in
            self.delegate?.onDriverStartedTrip(data)
        }
        
        socket.on("DriverVoidedAfPickup") {data, ack in
            self.delegate?.onDriverVoidedAfPickup(data)
        }
        
        socket.on("DriverFinished") {data, ack in
            self.delegate?.onDriverFinished(data)
        }
        
        socket.on("DriverCashPaid") {data, ack in
            self.delegate?.onDriverCashPaid(data)
        }
                
    }
    
    
}
