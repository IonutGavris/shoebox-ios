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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == suggestionSegueIdentifier {
            if let viewController = segue.destinationViewController as? SuggestionsViewController {
                viewController.agesDetails = ["sex" : childSex!, "age" : NSNumber(integer: selectedAge!)]
            }
        }
    }
    
    //MARK: UItableViewDataSouce
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
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
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString("shoeBox_details_header_name", comment: "")
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        bottomViewOverview.hidden = true
        selectedAge = nil
        
        removeAllCheckmarkIndicators()
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        cell.accessoryType = .Checkmark

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
    
    private func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
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
                title = title! + " - \(age) " + NSLocalizedString("shoeBox_suggestions_age", comment: "")
            }
            break
        default:
            break
        }
        
        cell.textLabel?.text = title
    }
    
    private func removeAllCheckmarkIndicators() {
        let allIndexPaths = tableView.indexPathsForVisibleRows
        
        for idxPath in allIndexPaths! {
            let newCell = tableView.cellForRowAtIndexPath(idxPath)
            newCell?.accessoryType = .None
        }
    }
    
    private func displayPickerView() {
        var allAges: [Int] = []
        for i in 0...18 {
            allAges.append(i)
        }
        
        ActionSheetStringPicker.showPickerWithTitle(NSLocalizedString("shoeBox_suggestions_select_age", comment: ""), rows: allAges, initialSelection: 0,
            doneBlock: { [unowned self] (picker, selectedIndex, selectedValue) -> Void in
                self.selectedAge = selectedValue as? Int
                self.tableView.reloadData()
                
            }, cancelBlock: { (picker) -> Void in
                self.removeAllCheckmarkIndicators()
                self.bottomViewOverview.hidden = false
        }, origin: self.view)
    }

}