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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.arrowImageView.transform = selected ? CGAffineTransform(rotationAngle: CGFloat(M_PI)) : CGAffineTransform.identity
        }) 
    }
    
    //MARK: UIExpendingTableViewCell delegate
    
    func setExpansionStyle(_ style: UIExpansionStyle, animated: Bool) {
        
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
        arrowView.frame = CGRect(x: 0.0, y: 0.0, width: 14.0, height: 14.0)
        arrowView.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
        
        return arrowView
    }()

}
