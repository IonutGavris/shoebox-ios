//
//  IntroViewController.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 11/26/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var buttonStart: ShoeBoxLocalizedButton!
    @IBOutlet weak var pageControl: UIPageControl!
    fileprivate var previousPageView: PageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let numberOCards = 3
        let screenBounds = UIScreen.main.bounds
        let width = screenBounds.width
        
        for i in 0..<numberOCards {
            let view = Bundle.main.loadNibNamed(String(describing: PageView.self),
                                                owner: self, options: nil)?.last as! PageView
            view.translatesAutoresizingMaskIntoConstraints = false
            updatePage(page: view, at: i)
            scrollView.addSubview(view)
            addLayoutConstraintsForView(view: view)
            previousPageView = view
        }

        scrollView.contentSize.width = CGFloat(numberOCards) * width
        scrollView.backgroundColor =  UIColor.shoeBoxRedColor(0.8)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: Action methods
    @IBAction func startAction(_ sender: AnyObject) {
        let preferences = UserDefaults.standard
        preferences.set(true, forKey: Constants.KEY_INTRO_COMPLETED)
        SwiftEventBus.post(Constants.GET_INVOLVED_KEY)
    }
    
    //MARK: UIScrollViewDelegate
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let screenBoudns = UIScreen.main.bounds
        let currentPage = self.scrollView.contentOffset.x / screenBoudns.width
        
        pageControl.currentPage = Int(ceil(currentPage))
        changePageBackgroundColor(at: Int(ceil(currentPage)))
    }
}

extension IntroViewController {

    //MARK: Private methods
    
    fileprivate func updatePage(page: PageView, at index: Int) {
        
        let imageNamed: String
        let labelText: String
        switch index {
        case 0:
            imageNamed = "girl_boy_image"
            labelText = NSLocalizedString("intro_slide_1", comment: "")
        case 1:
            imageNamed = "what_to_put_in_box"
            labelText = NSLocalizedString("intro_slide_2", comment: "")
        case 2:
            imageNamed = "where_to_leave_box"
            labelText = NSLocalizedString("intro_slide_3", comment: "")
        default:
            imageNamed = ""
            labelText = ""
            break
        }
        page.viewDetails = (text: labelText, pageIndex: index, imageNamed: imageNamed)
    }
    
    fileprivate func addLayoutConstraintsForView(view: PageView) {
        
        var constraint = NSLayoutConstraint(item: view, attribute: .width,
                                                 relatedBy: .equal, toItem: scrollView,
                                                 attribute: .width, multiplier: 1.0, constant: 0.0)
        scrollView.addConstraint(constraint)
        
        if let previousPageView = previousPageView {
            constraint = NSLayoutConstraint(item: view, attribute: .leading,
                                                 relatedBy: .equal, toItem: previousPageView,
                                                 attribute: .trailing, multiplier: 1.0, constant: 0.0)
            scrollView.addConstraint(constraint)
            
        } else {
            constraint = NSLayoutConstraint(item: view, attribute: .leading,
                                                 relatedBy: .equal, toItem: scrollView,
                                                 attribute: .leading, multiplier: 1.0, constant: 0.0)
            scrollView.addConstraint(constraint)
        }
        
        constraint = NSLayoutConstraint(item: view, attribute: .height,
                                             relatedBy: .equal, toItem: scrollView,
                                             attribute: .height, multiplier: 1.0, constant: 0.0)
        scrollView.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: view, attribute: .top,
                                             relatedBy: .equal, toItem: scrollView,
                                             attribute: .top, multiplier: 1.0, constant: 0.0)
        scrollView.addConstraint(constraint)
    }
    
    fileprivate func changePageBackgroundColor(at index: Int) {
        
        let scrollViewBgdColor: UIColor
        let buttonStartBgdColor: UIColor
        switch index {
        case 0:
            scrollViewBgdColor = UIColor.shoeBoxRedColor(0.8)
            buttonStartBgdColor = UIColor.shoeBoxRedColor(1.0)
        case 1:
            scrollViewBgdColor = UIColor.shoeBoxGreenColor(0.8)
            buttonStartBgdColor = UIColor.shoeBoxGreenColor(1.0)
        case 2:
            scrollViewBgdColor = UIColor.shoeBoxBlueColor(0.8)
            buttonStartBgdColor = UIColor.shoeBoxBlueColor(1.0)
        default:
            scrollViewBgdColor = .white
            buttonStartBgdColor = .white
            break
        }
        UIView.animate(withDuration: 1.0, delay: 0, options: .allowUserInteraction, animations: { () -> Void in
            self.scrollView.backgroundColor = scrollViewBgdColor
            self.buttonStart.backgroundColor = buttonStartBgdColor
        })
    }
}
