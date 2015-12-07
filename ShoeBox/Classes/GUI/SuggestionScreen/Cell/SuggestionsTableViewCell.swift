//
//  SuggestionsTableViewCell.swift
//  ShoeBox
//
//  Created by Gabriel Vermesan on 06/12/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit

class SuggestionsTableViewCell: UITableViewCell {

    var shouldAddAccessoryView: Bool? {
        didSet {
            self.accessoryView = shouldAddAccessoryView! ? arrowImageView : nil
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        UIView.animateWithDuration(0.4) { () -> Void in
            self.arrowImageView.transform = selected ? CGAffineTransformMakeRotation(CGFloat(M_PI)) : CGAffineTransformIdentity
        }
    }
    
    //MARK: UIExpendingTableViewCell delegate
    
    func setExpansionStyle(style: UIExpansionStyle, animated: Bool) {
        
    }
    
    var loading: Bool {
        set {}
        
        get {
            return self.loading
        }
    }
    
    var expansionStyle: UIExpansionStyle {
        get {
            return self.expansionStyle
        }
    }
    
    //MARK: Property
    
    lazy var arrowImageView: UIImageView = {
        var arrowView = UIImageView(image: UIImage(named: "suggestion_Arrow"))
        arrowView.frame = CGRectMake(0.0, 0.0, 14.0, 14.0)
        arrowView.autoresizingMask = [.FlexibleLeftMargin, .FlexibleTopMargin]
        
        return arrowView
    }()

}
