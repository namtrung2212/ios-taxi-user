//
//  MainWindow.swift
//  User.iPhone
//
//  Created by Trung Dao on 5/4/16.
//  Copyright © 2016 SCONNECTING. All rights reserved.
//

import Foundation

import UIKit

open class IntroduceWindow: UIWindow{
    
    open var introViewCtrl : IntroduceViewController?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.bounds = UIScreen.main.bounds
        self.backgroundColor = UIColor.white
        
        introViewCtrl =  IntroduceViewController(nibName: "IntroduceViewController", bundle: nil)
       
        self.rootViewController = introViewCtrl
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.init()
    }
}
