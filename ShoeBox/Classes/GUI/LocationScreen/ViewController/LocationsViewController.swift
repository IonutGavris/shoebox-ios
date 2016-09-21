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
    // data
    var locationsData = [Location]()
    var filteredLocations = [Location]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Get a reference to firebase locations endpoint
        let ref = Firebase(url: Constants.ENDPOINT_LOCATIONS)
        // Do any additional setup after loading the view, typically from a nib.
        ref.observeEventType(.Value, withBlock: { snapshot in
            guard let locations = snapshot.value as? NSArray else {
                return
            }
            self.locationsData.removeAll()
            for location in locations {
                self.locationsData.append(Location(dictionary: location as! [String : AnyObject]))
                
            }
            self.filteredLocations = self.locationsData
            
            self.tableView.reloadData()
            }, withCancelBlock: { error in
                print(error.description)
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == suggestionSegueIdentifier
        {
            if let destination = segue.destinationViewController as? LocationDetailViewController{
                destination.location = sender as? Location
            }
        }
    }
    
    //MARK: UItableViewDataSouce
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLocations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let location = filteredLocations[indexPath.row]
        // Populate cell as you see fit, like as below
        cell.textLabel?.text = location.title
        cell.detailTextLabel?.text = location.city! + ", " + location.country!
        cell.accessoryType = .DisclosureIndicator
        
        return cell
    }
    
    //MARK: UITableViewDelegate
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedLocation = filteredLocations[indexPath.row]
        self.performSegueWithIdentifier(suggestionSegueIdentifier, sender: selectedLocation)
    }
    
    //MARK: Property
    
    private lazy var headerView: SheBoxLocationHeaderView = {
        let view = SheBoxLocationHeaderView(frame: CGRectMake(0.0, 0.0, CGRectGetHeight(self.tableView.bounds), 44.0))
        view.closure = { (searchText) -> Void in
            if searchText!.isEmpty {
                self.filteredLocations = self.locationsData
                self.tableView.reloadData()
                return
            }
            
            self.filteredLocations = self.locationsData.filter({ (location: Location) -> Bool in
                let stringMatch = location.title!.rangeOfString(searchText!, options: .CaseInsensitiveSearch)
                
                return stringMatch != nil
            })
            self.tableView.reloadData()
        }
        return view
    }()
    
}
