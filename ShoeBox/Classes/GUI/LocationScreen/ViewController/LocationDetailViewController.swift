//
//  LocationDetailViewController.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 11/26/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit

class LocationDetailViewController: UITableViewController {
    
    var location: Location?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK: UItableViewDataSouce
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = NSStringFromClass(UITableViewCell.self) as String
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell!
        
        if cell == nil {
            cell = UITableViewCell(style: .Value1, reuseIdentifier: cellIdentifier)
        }
        configureCell(cell, atIndexPath: indexPath)
        
        return cell
    }
    
    private func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        var title: String?
        
        switch indexPath.row {
        case 0:
            title = location?.address
            break
        case 1:
            title = location?.city
            break
        case 2:
            title = location?.country
            break
        case 3:
            title = String(location?.latitude)
            break
        case 4:
            title = String(location?.longitude)
            break
        case 5:
            title = location?.message
            break
        case 6:
            title = location?.postalCode
            break
        case 7:
            title = location?.state
            break
        case 8:
            title = location?.title
            break
        default:
            break
        }
        
        cell.textLabel?.text = title
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
