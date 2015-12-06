//
//  IntroViewController.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 11/26/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit

class IntroViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.shoeBoxGreenColor(1)
        self.dataSource = self
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController")
        self.setViewControllers([viewController!], direction: .Forward, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 3
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PageViewController).pageIndex
        index++
        if (index == 0) {
            return nil
        }
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PageViewController).pageIndex
        if (index == 0) {
            return nil
        }
        index--
        return viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController? {
        if (index >= 0 && index <= 2) {
            let controller = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! PageViewController
            controller.pageIndex = index
            return controller
        }
        return nil
    }
    
}

