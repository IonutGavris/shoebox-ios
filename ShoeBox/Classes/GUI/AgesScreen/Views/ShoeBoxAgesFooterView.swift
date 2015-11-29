//
//  ShoeBoxAgesFooterView.swift
//  ShoeBox
//
//  Created by Gabriel Vermesan on 29/11/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit

typealias ShoeBoxAgesFooterViewTapped = () -> Void

class ShoeBoxAgesFooterView: UIView {

    var viewTapped: ShoeBoxAgesFooterViewTapped!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(nextStepButton)
        self.addSubview(overview)
        
        addLayoutConstraintsForView(nextStepButton)
        addLayoutConstraintsForView(overview)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Action methods
    
    @IBAction func nextStepPressed(button : UIButton) {
        viewTapped()
    }
    
    //MARK: Property
    
    lazy var nextStepButton: UIButton = {
        var button = UIButton(frame: CGRectZero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.shoeBoxGreenColor(0.8)
        button.setTitle(NSLocalizedString("shoeBox_details_next_step", comment: ""), forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 17.0)
        button.addTarget(self, action: "nextStepPressed:", forControlEvents: .TouchUpInside)

        return button
    }()
    
    lazy var overview: UIView = {
        var view = UIView(frame: CGRectZero)
        view.backgroundColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: Layout methods
    
    private func addLayoutConstraintsForView(view: UIView) {
        var constraint = NSLayoutConstraint(item: view, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1.0, constant: 0.0)
        self.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: view, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1.0, constant: 0.0)
        self.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: view, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 0.0)
        self.addConstraint(constraint)
        
        constraint = NSLayoutConstraint(item: view, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        self.addConstraint(constraint)
        
    }
}
