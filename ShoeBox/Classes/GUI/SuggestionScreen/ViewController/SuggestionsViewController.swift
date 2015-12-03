//
//  SuggestionsViewController.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 11/26/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit

class SuggestionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var allSuggestions: [Suggestion] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomViewOverview: UIView!
    
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
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: UItableViewDataSouce
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allSuggestions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = NSStringFromClass(UITableViewCell.self) as String
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell!
        
        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: cellIdentifier)
        }
        
        let suggestion = allSuggestions[indexPath.row]
        cell.textLabel?.text = suggestion.name
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString("shoeBox_suggestions_header_name", comment: "")
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let offsetX = 35.0 as CGFloat
        let view = UIView(frame: CGRectMake(0.0, 0.0, CGRectGetWidth(tableView.bounds), 40.0))
        
        let label = UILabel(frame: CGRectMake(offsetX, 0.0, CGRectGetWidth(tableView.bounds) - 2 * offsetX, 40.0))
        label.font = UIFont(name: "HelveticaNeue", size: 12.0)
        label.textColor = UIColor.shoeBoxRedColor(1.0)
        label.numberOfLines = 2
        label.textAlignment = .Center
        label.text = NSLocalizedString("shoeBox_sUggestion_Details_footer_name", comment: "")
        
        view.addSubview(label)
        
        return view
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
}
