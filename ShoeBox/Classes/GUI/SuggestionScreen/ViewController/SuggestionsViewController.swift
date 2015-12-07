//
//  SuggestionsViewController.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 11/26/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit

class SuggestionsViewController: UIViewController, SLExpandableTableViewDelegate, SLExpandableTableViewDatasource {
    
    var allSuggestions: [Suggestion] = []
    var agesDetails: [String : AnyObject]?
    
    @IBOutlet weak var tableView: SLExpandableTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        FirebaseManager.extractFirebaseDataForPath("suggestions") { (results) -> Void in
            self.allSuggestions.removeAll()
            
            for dict in results! {
                if dict as! NSObject == NSNull() {
                    continue
                }
                let suggestion = Suggestion(dictionary: dict as! [String : AnyObject])
                self.allSuggestions.append(suggestion)
            }
            
            let age = self.agesDetails!["age"]
            let sex = self.agesDetails!["sex"] as! String

            self.allSuggestions = self.allSuggestions.filter {
                let isAgeMatched = ($0.minAge.integerValue <= age?.integerValue)
                let isSexMatched = ($0.sex == sex || $0.sex == "both")
                return isAgeMatched && isSexMatched
            }

            self.tableView.reloadData()
        }
    }
    
    //MARK: SLExpandableTableViewDatasource

    func tableView(tableView: SLExpandableTableView!, canExpandSection section: Int) -> Bool {
        return true
    }
    
    func tableView(tableView: SLExpandableTableView!, needsToDownloadDataForExpandableSection section: Int) -> Bool {
        return false
    }
    
    func tableView(tableView: SLExpandableTableView!, expandingCellForSection section: Int) -> UITableViewCell! {
        let cellIdentifier = NSStringFromClass(SuggestionsTableViewCell.self) as String
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! SuggestionsTableViewCell!
        
        if cell == nil {
            cell = SuggestionsTableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        }
        let suggestion = allSuggestions[section - 1]
        cell.textLabel?.text = suggestion.name
        cell.shouldAddAccessoryView = suggestion.details.count > 0
        
        return cell
    }
    
    //MARK: UItableViewDataSouce
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.allSuggestions.count + 1

    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
        
        let suggestion = allSuggestions[section - 1]
        let count = suggestion.details.count
        return count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = NSStringFromClass(UITableViewCell.self) as String
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell!
        
        if cell == nil {
            cell = UITableViewCell(style: .Value2, reuseIdentifier: cellIdentifier)
        }
        
        let suggestion = allSuggestions[indexPath.section - 1]
        let detail = suggestion.details[indexPath.row - 1]
        let string = detail.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        cell.detailTextLabel?.text = string.firstCharacterUppercased()
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.textColor = UIColor.darkGrayColor()
        cell.selectionStyle = .None

        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String?
        if section == 0 {
            title = NSLocalizedString("shoeBox_suggestions_header_name", comment: "")
        }
        return title
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(tableView: SLExpandableTableView!, downloadDataForExpandableSection section: Int) {
        return
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height = 44.0 as CGFloat
        if indexPath.row == 0 {
            return height
        }
        
        let suggestion = allSuggestions[indexPath.section - 1]
        let detail = suggestion.details[indexPath.row - 1] as NSString
        
        let font = UIFont(name: "HelveticaNeue", size: 15.0)
        let attributes = [NSFontAttributeName : font!] as [String : AnyObject]
        let attrString = NSAttributedString(string: detail as String, attributes: attributes)
        
        let rectSize = attrString.boundingRectWithSize(CGSizeMake(CGRectGetWidth(tableView.bounds), .max),
                                options: [.UsesLineFragmentOrigin, .UsesFontLeading],
                                context: nil)
        

        height = CGRectGetHeight(rectSize)
        var multiplier = 2.4 as CGFloat
        if height > 35 {
            multiplier = 1.5
        }
        return height * multiplier
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 30.0
        }
        return .min
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let count = allSuggestions.count + 1
        if section == count - 1 {
            return 40.0
        }
        return .min
    }
    
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        var view: UIView?
        let count = allSuggestions.count + 1

        if section == count - 1 {
            
            let offsetX = 35.0 as CGFloat
            view = UIView(frame: CGRectMake(0.0, 0.0, CGRectGetWidth(tableView.bounds), 40.0))
            
            let label = UILabel(frame: CGRectMake(offsetX, 0.0, CGRectGetWidth(tableView.bounds) - 2 * offsetX, 40.0))
            label.font = UIFont(name: "HelveticaNeue", size: 12.0)
            label.textColor = UIColor.shoeBoxRedColor(1.0)
            label.numberOfLines = 2
            label.textAlignment = .Center
            label.text = NSLocalizedString("shoeBox_sUggestion_Details_footer_name", comment: "")
            
            view!.addSubview(label)
        }

        
        return view
    }
    
    func tableView(tableView: SLExpandableTableView!, didCollapseSection section: UInt, animated: Bool) {
        let indexPath = NSIndexPath(forRow: 0, inSection: Int(section))
        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .None, animated: true)
    }
    
}
