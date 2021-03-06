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
    fileprivate let suggestionSegueIdentifier = "ShowLocationDetailsScreenIdentifier"
    // data
    fileprivate var locationsData = [Location]()
    fileprivate var filteredLocations = [Location]()

    override func viewDidLoad() {
        super.viewDidLoad()

        FirebaseManager.extractAllLocations { (locations) in
            self.locationsData.removeAll()
            self.locationsData = locations
            self.filteredLocations = locations
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == suggestionSegueIdentifier {
            if let destination = segue.destination as? LocationDetailViewController{
                destination.location = sender as? Location
            }
        }
    }
    
    //MARK: Property
    
    fileprivate lazy var headerView: SheBoxLocationHeaderView = {
        let view = SheBoxLocationHeaderView(frame: CGRect(x: 0.0, y: 0.0, width: self.tableView.bounds.height, height: 44.0))
        view.closure = { (searchText) -> Void in
            guard let searchText = searchText else { return }
            
            if searchText.isEmpty {
                self.filteredLocations = self.locationsData
                self.tableView.reloadData()
                return
            }
            
            self.filteredLocations = self.locationsData.filter({ (location: Location) -> Bool in
                guard let title = location.title else { return false }
                guard let city = location.city else { return false }
                guard let country = location.country else { return false }
                
                let composedString = title + city + country
                
                return composedString.lowercased().contains(searchText.lowercased())
            })
            self.tableView.reloadData()
        }
        return view
    }()
}

extension LocationsViewController {

    //MARK: UItableViewDataSouce
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLocations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let location = filteredLocations[indexPath.row]
        // Populate cell as you see fit, like as below
        cell.textLabel?.text = location.title
        cell.detailTextLabel?.text = location.city! + ", " + location.country!
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    //MARK: UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLocation = filteredLocations[indexPath.row]
        self.performSegue(withIdentifier: suggestionSegueIdentifier, sender: selectedLocation)
    }
    
}


