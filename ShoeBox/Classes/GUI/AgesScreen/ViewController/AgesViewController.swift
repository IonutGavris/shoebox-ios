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
    var selectedAge: Int?
    var childSex: String?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topBarView: ShoeBoxAgesTopView!
    @IBOutlet weak var tableOverview: UIView!
    @IBOutlet weak var bottomViewOverview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        topBarView.girlBoyTappedCompletion = {[unowned self] (sex) -> Void in
            self.tableOverview.removeFromSuperview()
            self.childSex = sex
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == suggestionSegueIdentifier {
            if let viewController = segue.destination as? SuggestionsViewController {
                viewController.agesDetails = ["sex" : childSex! as AnyObject, "age" : NSNumber(value: selectedAge! as Int)]
            }
        }
    }
    
    //MARK: UItableViewDataSouce
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = NSStringFromClass(UITableViewCell.self) as String
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as UITableViewCell!
        
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellIdentifier)
        }
        configureCell(cell!, atIndexPath: indexPath)
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString("shoeBox_details_header_name", comment: "")
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        bottomViewOverview.isHidden = true
        selectedAge = nil
        
        removeAllCheckmarkIndicators()
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        cell.accessoryType = .checkmark

        if indexPath.row == 4 {
            displayPickerView()
        } else {
            let text = cell.textLabel?.text
            let firstAge = text!.stringBeforeCharacter("-")
            selectedAge = Int(firstAge)! as Int
            selectedAge = selectedAge! + 1
        }
    }
    
    
    //MARK: Private methods
    
    fileprivate func configureCell(_ cell: UITableViewCell, atIndexPath indexPath: IndexPath) {
        var title: String?
        
        let age = NSLocalizedString("shoeBox_details_years", comment: "")
        switch indexPath.row {
        case 0:
            title = "4-6 \(age)"
            break
        case 1:
            title = "6-8 \(age)"
            break
        case 2:
            title = "8-10 \(age)"
            break
        case 3:
            title = "10-12 \(age)"
            break
        case 4:
            title = NSLocalizedString("shoeBox_details_choose_another_age", comment: "")
            if let age = selectedAge {
                title = title! + " - " + "\(age)" + " "  + NSLocalizedString("shoeBox_suggestions_age", comment: "")
            }
            break
        default:
            break
        }
        
        cell.textLabel?.text = title
    }
    
    fileprivate func removeAllCheckmarkIndicators() {
        let allIndexPaths = tableView.indexPathsForVisibleRows
        
        for idxPath in allIndexPaths! {
            let newCell = tableView.cellForRow(at: idxPath)
            newCell?.accessoryType = .none
        }
    }
    
    fileprivate func displayPickerView() {
        var allAges: [Int] = []
        for i in 0...18 {
            allAges.append(i)
        }
        
        ActionSheetStringPicker.show(withTitle: NSLocalizedString("shoeBox_suggestions_select_age", comment: ""), rows: allAges, initialSelection: 0,
            doneBlock: { [unowned self] (picker, selectedIndex, selectedValue) -> Void in
                self.selectedAge = selectedValue as? Int
                self.tableView.reloadData()
                
            }, cancel: { (picker) -> Void in
                self.removeAllCheckmarkIndicators()
                self.bottomViewOverview.isHidden = false
        }, origin: self.view)
    }

}
