//
//  LocationsViewController.swift
//  ShoeBox
//
//  Created by Ionut Gavris on 11/26/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LocationsViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    // segue id
    private let suggestionSegueIdentifier = "ShowLocationDetailsScreenIdentifier"
    // data
    private var allLocations = [Location]()
    private var filteredLocations = [Location]()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirebaseManager.extractAllLocations { (locations) in
            self.allLocations.removeAll()
            self.allLocations = locations
            self.filteredLocations = locations
            self.setupTableViewDataSource()
        }
        
        setupSearchBar()
        setupTableViewDelegate()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == suggestionSegueIdentifier {
            if let destination = segue.destination as? LocationDetailViewController{
                destination.location = sender as? Location
            }
        }
    }
    
    //MARK: Private methods
    
    private func setupTableViewDataSource() {
        //Rx suggestion
        tableView.dataSource = nil
        
        let datasource = Observable<[Location]>.just(filteredLocations)
        datasource.bindTo(tableView.rx.items(cellIdentifier: "cell")) { index, location, cell in
            cell.textLabel?.text = location.title
            cell.detailTextLabel?.text = location.city! + ", " + location.country!
            cell.accessoryType = .disclosureIndicator
        }.addDisposableTo(disposeBag)
    }
    
    private func setupTableViewDelegate() {
        tableView.delegate = nil

        tableView
            .rx.modelSelected(Location.self)
            .subscribe(onNext: { [unowned self] (location) in
                self.performSegue(withIdentifier: self.suggestionSegueIdentifier, sender: location)
            })
            .addDisposableTo(disposeBag)
    }
    
    private func setupSearchBar() {
        searchBar.placeholder = NSLocalizedString("shoebox_list_search_placeHolder", comment: "")
        
        //Show cancel button
        searchBar
            .rx.textDidBeginEditing
            .subscribe { [unowned self] (query) in
                self.searchBar.setShowsCancelButton(true, animated: true)
            }
            .addDisposableTo(disposeBag)
        
        //Cancel button action
        searchBar.rx.cancelButtonClicked.subscribe { [unowned self] (event) in
            self.searchBar.text = nil
            self.resignSearchBarResponder()
            
            self.filteredLocations = self.allLocations
            self.setupTableViewDataSource()
            }.addDisposableTo(disposeBag)
        
        //Search button action
        searchBar.rx.searchButtonClicked.subscribe { [unowned self] (query) in
            self.resignSearchBarResponder()
            }
            .addDisposableTo(disposeBag)
        
        searchBar
            .rx.text
            .map { $0! }
            .debounce(0.3, scheduler: MainScheduler.instance) // Add delay
            .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old.
            .subscribe(onNext: { [unowned self] (query) in
                if query.isEmpty {
                    self.filteredLocations = self.allLocations
                    
                } else {
                    self.filteredLocations = self.allLocations.filter({ (location: Location) -> Bool in
                        let stringMatch = location.title!.range(of: query, options: .caseInsensitive)
                        
                        return stringMatch != nil
                    })
                }
                
                self.setupTableViewDataSource()
            })
            .addDisposableTo(disposeBag)
    }
    
    private func resignSearchBarResponder() {
        self.searchBar.resignFirstResponder()
        self.searchBar.setShowsCancelButton(false, animated: true)
    }
}
