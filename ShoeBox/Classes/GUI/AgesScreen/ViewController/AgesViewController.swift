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
        return "Alege varsta"
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        footerView.overview.removeFromSuperview()
        
        let allIndexPaths = tableView.indexPathsForVisibleRows
        
        for idxPath in allIndexPaths! {
            let newCell = tableView.cellForRowAtIndexPath(idxPath)
            newCell?.accessoryType = .None
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        cell.accessoryType = .Checkmark
    }
    
    //MARK: Prperty
    
    lazy var footerView: ShoeBoxAgesFooterView = {
        var footer = ShoeBoxAgesFooterView(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 50.0))
        footer.viewTapped = { [unowned self] () -> Void in
            self.performSegueWithIdentifier(self.suggestionSegueIdentifier, sender: self)
        }
    
        return footer
    }()
    
    
    //MARK: Private methods
    
    private func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        var title: String?
        
        switch indexPath.row {
        case 0:
            title = "4-6 ani"
            break
        case 1:
            title = "6-8 ani"
            break
        case 2:
            title = "8-10 ani"
            break
        case 3:
            title = "10-12 ani"
            break
        case 4:
            title = "Alta varsta"
            break
        default:
            break
        }
        
        cell.textLabel?.text = title
    }

}