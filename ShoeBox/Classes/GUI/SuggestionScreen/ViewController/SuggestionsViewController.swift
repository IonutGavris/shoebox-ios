//
//  SuggestionsViewController.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 11/26/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit

class SuggestionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let showDetailsScreenSequeIdentifier = "showDetailsScreenSegueIdentifier"
    var allSuggestions: [Suggestion] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        FirebaseManager.extractFirebaseDataForPath("suggestions") { [unowned self] (results) -> Void in
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == showDetailsScreenSequeIdentifier {
            if let viewController = segue.destinationViewController as? SuggestionDetailsViewController {
                viewController.suggestion = sender as? String
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
        cell.accessoryType = .DisclosureIndicator
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString("shoeBox_suggestions_header_name", comment: "")
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
            
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        let name = cell?.textLabel?.text
        self.performSegueWithIdentifier(showDetailsScreenSequeIdentifier, sender: name)
    }
}
