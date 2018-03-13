//
//  IntroduceViewController.swift
//  User.iPhone
//
//  Created by Trung Dao on 5/4/16.
//  Copyright © 2016 SCONNECTING. All rights reserved.
//

import UIKit
import SClientData

open class IntroduceViewController: UIViewController, UIPageViewControllerDataSource {

    
    var pageViewController: UIPageViewController!
    var pageTitles: NSArray!
    var pageImages: NSArray!
    var btnGotIt : UIButton!
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        
        self.initControls()
        self.initLayout()
        self.initApperance()
    
    }
    
    
    func initControls(){
        self.view.bounds  = UIScreen.main.bounds
        
        self.pageTitles = NSArray(objects: "Intro1", "Intro2", "Intro3", "Intro4", "Intro5", "Intro6", "Intro7")
        self.pageImages = NSArray(objects: "Intro1", "Intro2", "Intro3", "Intro4", "Intro5", "Intro6", "Intro7")
        
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageViewController.dataSource = self
        
        let page = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.classForCoder() as! UIAppearanceContainer.Type])
        page.pageIndicatorTintColor = UIColor.lightGray
        page.currentPageIndicatorTintColor  = UIColor.gray
        
        self.pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        let startVC = self.viewControllerAtIndex(0) as IntroItemViewController
        let viewControllers = NSArray(object: startVC)
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .forward, animated: true, completion: nil)
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)
        
        self.btnGotIt = UIButton(type: .system)
        self.btnGotIt.setTitle("Got It", for: UIControlState())
        self.btnGotIt.heightAnchor.constraint(equalToConstant: 10)
        self.btnGotIt.translatesAutoresizingMaskIntoConstraints = false
        self.btnGotIt.isHidden = true
        self.btnGotIt.addTarget(self, action: #selector(IntroduceViewController.gotItClicked(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(self.btnGotIt)
        
    }
    
    
    func initApperance(){
        
        let page = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.classForCoder() as! UIAppearanceContainer.Type])
        page.pageIndicatorTintColor = UIColor.lightGray
        page.currentPageIndicatorTintColor  = UIColor.gray
        
    }
    
    func initLayout(){
        
        self.pageViewController.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.pageViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -60.0).isActive = true
        self.pageViewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.pageViewController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        self.btnGotIt.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.btnGotIt.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20.0).isActive = true

    }
    
    func gotItClicked(_ sender: AnyObject){
        
        UserDefaults.standard.setValue("true", forKey: "alreadyIntro")
        
        AppDelegate.activationWindow = ActivationWindow(frame: UIScreen.main.bounds)
        AppDelegate.activationWindow?.makeKeyAndVisible()
      
    }

    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func viewControllerAtIndex(_ index: Int) -> IntroItemViewController
    {
        if ((self.pageTitles.count == 0) || (index >= self.pageTitles.count)) {
            return IntroItemViewController()
        }
        
        let vc =  IntroItemViewController(nibName: "IntroItemViewController", bundle: nil)
        vc.imageFile = self.pageImages[index] as! String
        vc.titleText = self.pageTitles[index] as! String
        vc.pageIndex = index
        
        return vc
        
        
    }
    
    
    // MARK: - Page View Controller Data Source
    
    open func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        
        let vc = viewController as! IntroItemViewController
        var index = vc.pageIndex as Int
        
        if (index == 0 || index == NSNotFound)
        {
            return nil
        }
        
        index -= 1
        
        self.btnGotIt.isHidden =  (index != self.pageTitles.count)

        return self.viewControllerAtIndex(index)
        
    }
    
    open func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        let vc = viewController as! IntroItemViewController
        var index = vc.pageIndex as Int
        
        if (index == NSNotFound)
        {
            return nil
        }
        
        index += 1
        
        self.btnGotIt.isHidden =  (index != self.pageTitles.count)
        
        if (index == self.pageTitles.count)
        {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
        
    }
    
    open func presentationCount(for pageViewController: UIPageViewController) -> Int
    {
        return self.pageTitles.count
    }
    
    open func presentationIndex(for pageViewController: UIPageViewController) -> Int
    {
        return 0
    }

    
}
