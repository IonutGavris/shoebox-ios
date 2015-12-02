//
//  SuggestionDetailsViewController.swift
//  ShoeBox
//
//  Created by Gabriel Vermesan on 29/11/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit

class SuggestionDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var suggestion: String?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //MARK: UItableViewDataSouce
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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
         return .min
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .Checkmark
    }
    
    //MARK: Private methods
    
    private func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        var title: String?
        
        switch indexPath.row {
        case 0:
            title = "Ciocolata"
            break
        case 1:
            title = "Biscuiti"
            break
        case 2:
            title = "Napolitane"
            break
        default:
            break
        }
        
        cell.textLabel?.text = title
    }
}
