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
        count++
        return viewControllerAtIndex(count)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        count--
        return viewControllerAtIndex(count)
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController? {
        if (index > 0 && index < 2) {
            return self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController")
        }
        return nil
    }
    
}

