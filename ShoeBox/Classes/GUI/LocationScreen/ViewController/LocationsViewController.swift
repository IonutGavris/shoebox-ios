//
//  LocationsViewController.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 11/26/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit

class LocationsViewController: UITableViewController {
    
    // segue id
    let suggestionSegueIdentifier = "ShowLocationDetailsScreenIdentifier"
    
    // Get a reference to firebase locations endpoint
    let locations = Firebase(url: "https://shoebox.firebaseio.com/locations")
    var dataSource: FirebaseTableViewDataSource!
    var selectedLocation: Location?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.dataSource = FirebaseTableViewDataSource(ref: locations, prototypeReuseIdentifier: "cell", view: self.tableView)
        self.dataSource.populateCellWithBlock { (cell: UITableViewCell, obj: NSObject) -> Void in
            let snap = obj as! FDataSnapshot
            let location = Location(dict: snap.value as! NSDictionary)
            
            // Populate cell as you see fit, like as below
            cell.textLabel?.text = location.title
            cell.detailTextLabel?.text = location.city! + ", " + location.country!
        }
        
        self.tableView.dataSource = self.dataSource
        self.tableView.delegate = self;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let snap = dataSource.array.objectAtIndex(UInt(indexPath.row)) as! FDataSnapshot
        selectedLocation = Location(dict: snap.value as! NSDictionary)
        self.performSegueWithIdentifier(suggestionSegueIdentifier, sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == suggestionSegueIdentifier
        {
            if let destination = segue.destinationViewController as? LocationDetailViewController{
                destination.location = selectedLocation
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
