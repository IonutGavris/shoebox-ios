//
//  LocationDetailViewController.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 11/26/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import GoogleMaps
import UIKit

class LocationDetailViewController: UITableViewController {
    
    var location: Location?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = location?.title
        initGoogleMaps(location!)
        //initPanorama(location!)
    }
    
    func initGoogleMaps(location: Location) {
        let camera = GMSCameraPosition.cameraWithLatitude(location.latitude!,longitude: location.longitude!, zoom: 16)
        let rect = tableView.tableHeaderView!.frame
        let mapView = GMSMapView.mapWithFrame(rect, camera: camera)
        mapView.mapType = GoogleMaps.kGMSTypeHybrid
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(location.latitude!, location.longitude!)
        marker.icon = GMSMarker.markerImageWithColor(UIColor.shoeBoxBlueColor(1.0))
        marker.opacity = 0.9
        marker.map = mapView
        tableView.tableHeaderView = mapView
    }
    
    func initPanorama(location: Location) {
        let panoView = GMSPanoramaView(frame: tableView.tableHeaderView!.frame)
        tableView.tableHeaderView = panoView
        panoView.moveNearCoordinate(CLLocationCoordinate2DMake((location.latitude)!, (location.longitude)!))
    }
    
    //MARK: UItableViewDataSouce
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return indexPath.row > 0 ? 44 : 120
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = indexPath.row > 0 ? "small" : "large"
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
            title = location?.messages
            break
        case 1:
            title = location?.address
            break
        case 2:
            title = location?.postalCode
            break
        case 3:
            title = location?.city
            break
        case 4:
            title = location?.state
            break
        case 5:
            title = location?.country
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
