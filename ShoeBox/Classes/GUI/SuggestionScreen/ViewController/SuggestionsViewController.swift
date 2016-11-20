//
//  SuggestionsViewController.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 11/26/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit
import SLExpandableTableView

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}


class SuggestionsViewController: UIViewController, SLExpandableTableViewDelegate, SLExpandableTableViewDatasource {
    
    var allSuggestions: [Suggestion] = []
    var agesDetails: [String : AnyObject]?
    
    @IBOutlet weak var tableView: SLExpandableTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        FirebaseManager.extractAllSuggestions { (suggestions) in
            self.allSuggestions.removeAll()
            self.allSuggestions = suggestions
            
            let age = self.agesDetails!["age"]
            let sex = self.agesDetails!["sex"] as! String
            
            self.allSuggestions = self.allSuggestions.filter {
                let isAgeMatched = ($0.minAge.intValue <= age?.intValue)
                let isSexMatched = ($0.sex == sex || $0.sex == "both")
                return isAgeMatched && isSexMatched
            }
            
            self.tableView.reloadData()
        }
    }
    
    //MARK: SLExpandableTableViewDatasource

    func tableView(_ tableView: SLExpandableTableView!, canExpandSection section: Int) -> Bool {
        return true
    }
    
    func tableView(_ tableView: SLExpandableTableView!, needsToDownloadDataForExpandableSection section: Int) -> Bool {
        return false
    }
    
    func tableView(_ tableView: SLExpandableTableView!, expandingCellForSection section: Int) -> UITableViewCell! {
        let cellIdentifier = NSStringFromClass(SuggestionsTableViewCell.self) as String
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! SuggestionsTableViewCell!
        
        if cell == nil {
            cell = SuggestionsTableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        let suggestion = allSuggestions[section - 1]
        cell?.textLabel?.text = suggestion.name
        cell?.shouldAddAccessoryView = suggestion.details.count > 0
        
        return cell
    }
    
    //MARK: UItableViewDataSouce
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.allSuggestions.count + 1

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
        
        let suggestion = allSuggestions[section - 1]
        let count = suggestion.details.count
        return count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = NSStringFromClass(UITableViewCell.self) as String
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as UITableViewCell!
        
        if cell == nil {
            cell = UITableViewCell(style: .value2, reuseIdentifier: cellIdentifier)
        }
        
        let suggestion = allSuggestions[indexPath.section - 1]
        let detail = suggestion.details[indexPath.row - 1]
        var string = detail.trimmingCharacters(in: CharacterSet.whitespaces)
        string = string.firstCharacterUppercased()
        
        cell?.detailTextLabel?.text = string.stringWithoutDot()
        cell?.detailTextLabel?.numberOfLines = 0
        cell?.detailTextLabel?.textColor = UIColor.darkGray
        cell?.selectionStyle = .none

        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String?
        if section == 0 {
            title = NSLocalizedString("shoeBox_suggestions_header_name", comment: "")
        }
        return title
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: SLExpandableTableView!, downloadDataForExpandableSection section: Int) {
        return
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = 44.0 as CGFloat
        if indexPath.row == 0 {
            return height
        }
        
        let suggestion = allSuggestions[indexPath.section - 1]
        let detail = suggestion.details[indexPath.row - 1] as NSString
        
        let font = UIFont(name: "HelveticaNeue", size: 15.0)
        let attributes = [NSFontAttributeName : font!] as [String : AnyObject]
        let attrString = NSAttributedString(string: detail as String, attributes: attributes)
        
        let rectSize = attrString.boundingRect(with: CGSize(width: tableView.bounds.width, height: .greatestFiniteMagnitude),
                                options: [.usesLineFragmentOrigin, .usesFontLeading],
                                context: nil)
        

        height = rectSize.height
        var multiplier = 2.4 as CGFloat
        if height > 35 {
            multiplier = 1.5
        }
        return height * multiplier
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 30.0
        }
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let count = allSuggestions.count + 1
        if section == count - 1 {
            return 40.0
        }
        return .leastNormalMagnitude
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        var view: UIView?
        let count = allSuggestions.count + 1

        if section == count - 1 {
            
            let offsetX = 35.0 as CGFloat
            view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: tableView.bounds.width, height: 40.0))
            
            let label = UILabel(frame: CGRect(x: offsetX, y: 0.0, width: tableView.bounds.width - 2 * offsetX, height: 40.0))
            label.font = UIFont(name: "HelveticaNeue", size: 12.0)
            label.textColor = UIColor.shoeBoxRedColor(1.0)
            label.numberOfLines = 2
            label.textAlignment = .center
            label.text = NSLocalizedString("shoeBox_sUggestion_Details_footer_name", comment: "")
            
            view!.addSubview(label)
        }

        
        return view
    }
    
    func tableView(_ tableView: SLExpandableTableView!, didCollapseSection section: UInt, animated: Bool) {
        let indexPath = IndexPath(row: 0, section: Int(section))
        tableView.scrollToRow(at: indexPath, at: .none, animated: true)
    }
    
}
