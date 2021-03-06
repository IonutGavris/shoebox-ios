//
//  SheBoxLocationHeaderView.swift
//  ShoeBox
//
//  Created by Gabriel Vermesan on 02/12/15.
//  Copyright © 2015 ShoeBox. All rights reserved.
//

import UIKit

typealias SheBoxLocationHeaderViewTextClosure = (String?) -> Void

class SheBoxLocationHeaderView: UISearchBar, UISearchBarDelegate {

    var closure: SheBoxLocationHeaderViewTextClosure?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.placeholder = NSLocalizedString("shoebox_list_search_placeHolder", comment: "")
        self.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        closure?(searchText)
        searchBar.becomeFirstResponder()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil;
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        closure?(searchBar.text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
}
