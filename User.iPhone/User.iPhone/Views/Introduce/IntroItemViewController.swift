//
//  IntroItemViewController.swift
//  User.iPhone
//
//  Created by Trung Dao on 5/4/16.
//  Copyright © 2016 SCONNECTING. All rights reserved.
//

import UIKit
import SClientData

class IntroItemViewController: UIViewController {

    
    var imageView: UIImageView!
    var titleLabel: UILabel!
    var pageIndex: Int!
    var titleText: String!
    var imageFile: String!

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        initControls()
                    
    }

    
    
    func initControls(){
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        titleLabel.font = titleLabel.font.withSize(15)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = self.titleText
        titleLabel.textAlignment = NSTextAlignment.center
       // titleLabel.backgroundColor = UIColor(white: 1, alpha: 0.5)
        self.view.addSubview(titleLabel)
        titleLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20.0).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        
        let image = ImageHelper.resize(UIImage(named: self.imageFile)!, newWidth: 170)
        imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -10.0).isActive = true
        
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
