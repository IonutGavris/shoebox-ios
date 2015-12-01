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
    let ref = Firebase(url: "https://shoebox.firebaseio.com/locations")
    let locationsData = NSMutableArray()
    var selectedLocation: Location?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ref.observeEventType(.Value, withBlock: { snapshot in
            guard let locations = snapshot.value as? NSArray else {
                return
            }
            self.locationsData.removeAllObjects();
            for location in locations {
                self.locationsData.addObject(Location(dict: location as! NSDictionary))
            }
            self.tableView.reloadData()
            }, withCancelBlock: { error in
                print(error.description)
        })
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationsData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let location = locationsData.objectAtIndex(indexPath.row) as! Location;
        // Populate cell as you see fit, like as below
        cell.textLabel?.text = location.title
        cell.detailTextLabel?.text = location.city! + ", " + location.country!
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedLocation = locationsData.objectAtIndex(indexPath.row) as? Location;
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
