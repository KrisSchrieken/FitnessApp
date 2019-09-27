//
//  PageViewController.swift
//  GymApp
//
//  Created by Kristopher Schrieken on 6/14/19.
//  Copyright © 2019 Kristopher Schrieken. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate,
UIPageViewControllerDataSource {
    
    /*@IBOutlet weak var dataLabel: UILabel!
     var dataObject: String = ""*/
    lazy var pages: [ UIViewController ] = {
        
        return [ self.newPage( viewController: "Calorie Counter" ),
                 self.newPage( viewController: "Workouts" ),
                 self.newPage( viewController: "Workout Schedule" ),
                 self.newPage( viewController: "Circuits" ) ]
                
    }()
    
    var pageControl = UIPageControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.dataSource = self
        if let firstVC = pages.first {
            setViewControllers( [firstVC], direction: .forward, animated: true, completion: nil)
            
        }
        
        // sets up the dots on bottom of screen
        self.delegate = self
        configurePageControl()
    }
    
    // creates dots on bottom of page to determine where user is within app
    func configurePageControl() {
        
        pageControl = UIPageControl( frame: CGRect( x: 0, y: UIScreen.main.bounds.maxY - 50,
                                                    width: UIScreen.main.bounds.width, height: 50 ))
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
        
    }
    
    func newPage( viewController: String) -> UIViewController {
        
        return UIStoryboard( name: "Main", bundle: nil ).instantiateViewController(withIdentifier:
            viewController)
        
    }
    
    // Function is to move previous page into the new page
    func pageViewController( _ pageViewController: UIPageViewController, viewControllerBefore
        viewController: UIViewController) -> UIViewController? {
        
        // gets index of current page
        guard let vcIndex = pages.firstIndex( of: viewController ) else {
            
            return nil
            
        }
        
        // check if on 0 page
        let prevIndex = vcIndex - 1
        
        // stops user from swiping to out of bounds pages
        guard prevIndex >= 0 else {
            
            return nil
            
        }
        
        // if passes their is no VC to swipe to
        guard pages.count > prevIndex else {
            
            return nil
            
        }
        
        return pages[ prevIndex ]
    }
    
    // Function is used to swipe new page on screen
    func pageViewController( _ pageViewController: UIPageViewController, viewControllerAfter
        viewController: UIViewController) -> UIViewController? {
        
        // gets index of current page
        guard let vcIndex = pages.firstIndex( of: viewController ) else {
            
            return nil
            
        }
        
        // check if on 0 page
        let nextIndex = vcIndex + 1
        
        // stops user from swiping out of bounds
        guard pages.count != nextIndex else {
            
            return nil
        }
        
        // if passes their is no VC to swipe to
        guard pages.count > nextIndex else {
            
            return nil
            
        }
        
        return pages[ nextIndex ]
    }
    
    // updates where page currently is to give correct location of dots
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        let pageContentVC = pageViewController.viewControllers![0]
        self.pageControl.currentPage = pages.firstIndex( of: pageContentVC )!
        
    }
    
    /* override func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear(animated)
     self.dataLabel!.text = dataObject
     }*/
    
    
}

