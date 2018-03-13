//
//  Main.CreateOrder.CustomOrder.Events.swift
//  User.iPhone
//
//  Created by Trung Dao on 6/3/16.
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


extension CustomOrderView {
    
    
    @IBAction public func btnCancelOrder_Clicked(_ sender: UIButton) {
        
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        sender.transform = CGAffineTransform.identity
                                    })
                                    UIView.animateWithDuration(0.25) {
                                        
                                        SCONNECTING.TaxiManager!.reset(true, completion: nil)
                                    }
                                    
        })
        
    }
    
    @IBAction public func btnCreateOrder_Clicked(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        sender.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                        
                                        self.parent.orderPhase = OrderPhase.chooseDriver
                                        
                                        SCONNECTING.TaxiManager!.invalidate(false, updateUI: true, completion: nil)
                                        
                                    }) 
                                    
        })
        
    }
    
    @IBAction public func btnReturn_Clicked(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        sender.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                        
                                        self.CurrentOrder!.OrderOneway = false
                                        self.invalidate(false,completion:  nil)
                                        
                                    }) 
                                    
        })
        
        
    }
    
    @IBAction public func btnOneWay_Clicked(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        sender.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                        
                                        self.CurrentOrder!.OrderOneway = true
                                        self.invalidate(false,completion:  nil)
                                    }) 
                                    
        })
        
    }
    
    
    @IBAction public func btnAllSeat_Clicked(_ sender: UIButton) {
        
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        sender.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                        
                                        self.CurrentOrder!.OrderSeater = 0
                                        self.invalidate(false,completion:  nil)
                                    }) 
                                    
        })
    }
    
    @IBAction public func btn4Seat_Clicked(_ sender: UIButton) {
        
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        sender.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                        
                                        self.CurrentOrder!.OrderSeater = 4
                                        self.invalidate(false,completion:  nil)
                                    }) 
                                    
        })
    }
    
    @IBAction public func btn7Seat_Clicked(_ sender: UIButton) {
        
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        sender.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                        
                                        self.CurrentOrder!.OrderSeater = 7
                                        self.invalidate(false,completion:  nil)
                                    }) 
                                    
        })
    }
    
    @IBAction public func btnPopular_Clicked(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        sender.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                        
                                        self.CurrentOrder!.OrderQuality = "Popular"
                                        
                                        self.invalidate(false,completion:  nil)
                                    }) 
                                    
        })
        
    }
    
    @IBAction public func btnLuxury_Clicked(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        sender.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                        
                                        self.CurrentOrder!.OrderQuality = "Luxury"
                                        self.invalidate(false,completion:  nil)
                                    }) 
                                    
        })
        
    }
    
    @IBAction public func btnEconomic_Clicked(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        sender.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                        
                                        self.CurrentOrder!.OrderQuality = "Economic"
                                        self.invalidate(false,completion:  nil)
                                    }) 
                                    
        })
        
    }
    
    @IBAction public func btnImmediately_Clicked(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        sender.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                        self.CurrentOrder!.OrderPickupTime = Date()
                                        self.invalidate(false,completion:  nil)
                                    }) 
                                    
        })
    }
    
    
    
    @IBAction public func lblPickupTime_Clicked(_ sender: UIButton) {
        
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        sender.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                        
                                        self.showChoosePickupTime()
                                        
                                    }) 
                                    
        })
        
        
        
    }
    
    @IBAction public func btnLater_Clicked(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1 ,
                                   animations: {
                                    sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
                                   completion: { finish in
                                    UIView.animate(withDuration: 0.1, animations: {
                                        sender.transform = CGAffineTransform.identity
                                    })
                                    UIView.animate(withDuration: 0.25, animations: {
                                        
                                        self.showChoosePickupTime()
                                        
                                    }) 
                                    
        })
        
    }
    
}
