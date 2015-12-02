//
//  AgesViewController.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 11/26/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit

class AgesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let suggestionSegueIdentifier = "ShowSuggestionScreenIdentifier"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topBarView: ShoeBoxAgesTopView!
    @IBOutlet weak var tableOverview: UIView!
    @IBOutlet weak var bottomViewOverview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        topBarView.girlBoyTappedCompletion = {[unowned self] () -> Void in
            self.tableOverview.removeFromSuperview()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    //MARK: UItableViewDataSouce
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = NSStringFromClass(UITableViewCell.self) as String
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell!
        
        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: cellIdentifier)
        }
        configureCell(cell, atIndexPath: indexPath)
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString("shoeBox_details_header_name", comment: "")
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        bottomViewOverview.removeFromSuperview()
        let allIndexPaths = tableView.indexPathsForVisibleRows
        
        for idxPath in allIndexPaths! {
            let newCell = tableView.cellForRowAtIndexPath(idxPath)
            newCell?.accessoryType = .None
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        cell.accessoryType = .Checkmark
    }
    
    
    //MARK: Private methods
    
    private func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        var title: String?
        
        let age = NSLocalizedString("shoeBox_details_years", comment: "")
        switch indexPath.row {
        case 0:
            title = "4-6 \(age)"
            break
        case 1:
            title = "6-8 \(age)"
            break
        case 2:
            title = "8-10 \(age)"
            break
        case 3:
            title = "10-12 \(age)"
            break
        case 4:
            title = NSLocalizedString("shoeBox_details_choose_another_age", comment: "")
            break
        default:
            break
        }
        
        cell.textLabel?.text = title
    }

}