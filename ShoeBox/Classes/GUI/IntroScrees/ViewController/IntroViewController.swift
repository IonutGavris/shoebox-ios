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
    var nextIndex = 0
    weak var parent: ContainerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.shoeBoxRedColor(0.8)
        self.delegate = self
        self.dataSource = self
        self.setViewControllers([viewControllerAtIndex(0)!], direction: .Forward, animated: true, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        parent = self.parentViewController as? ContainerViewController
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 3
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PageViewController).pageIndex
        index += 1
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
        index -= 1
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        let index = (pendingViewControllers[0] as! PageViewController).pageIndex
        nextIndex = index
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if (completed) {
            switch nextIndex {
            case 0:
                UIView.animateWithDuration(1.0, delay: 0, options: .AllowUserInteraction, animations: { () -> Void in
                    self.view.backgroundColor = UIColor.shoeBoxRedColor(0.8)
                    self.parent!.buttonStart.backgroundColor = UIColor.shoeBoxRedColor(1)
                    }, completion: nil)
                break
            case 1:
                UIView.animateWithDuration(1.0, delay: 0, options: .AllowUserInteraction, animations: { () -> Void in
                    self.view.backgroundColor = UIColor.shoeBoxGreenColor(0.8)
                    self.parent!.buttonStart.backgroundColor = UIColor.shoeBoxGreenColor(1)
                    }, completion: nil)
                break
            case 2:
                UIView.animateWithDuration(1.0, delay: 0, options: .AllowUserInteraction, animations: { () -> Void in
                    self.view.backgroundColor = UIColor.shoeBoxBlueColor(0.8)
                    self.parent!.buttonStart.backgroundColor = UIColor.shoeBoxBlueColor(1)
                    }, completion: nil)
                break
            default:
                break
            }
        }
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController? {
        if (index >= 0 && index <= 2) {
            let controller = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! PageViewController
            switch index {
            case 0:
                controller.imageName = "girl_boy_image"
                controller.labelText = NSLocalizedString("intro_slide_1", comment: "")
                break
            case 1:
                controller.imageName = "what_to_put_in_box"
                controller.labelText = NSLocalizedString("intro_slide_2", comment: "")
                break
            case 2:
                controller.imageName = "where_to_leave_box"
                controller.labelText = NSLocalizedString("intro_slide_3", comment: "")
                break
            default:
                break
            }
            controller.pageIndex = index
            return controller
        }
        return nil
    }
    
}

