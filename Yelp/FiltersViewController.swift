//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Lee Edwards on 2/8/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FiltersViewControllerDelegate {
    optional func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String:AnyObject])
}

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate  {
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: FiltersViewControllerDelegate?
    
    @IBAction func onCancelPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onSearchPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        var filters = [String:AnyObject]()
        
        var selectedCategories = [String]()
        for (row, isSelected) in switchStates {
            if isSelected {
                selectedCategories.append(categories[row]["code"]!)
            }
            if selectedCategories.count > 0 {
                filters["categories"] = selectedCategories
            }
        }
        
        delegate?.filtersViewController?(self, didUpdateFilters: filters)
    }
    
    var categories: [[String:String]]!
    var switchStates = [Int:Bool]()
    var dealState = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        categories = yelpCategories()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return categories.count
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as! SwitchCell
            cell.switchLabel.text = "Offering a Deal"
            cell.switchControl.on = dealState
            cell.delegate = self
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as! SwitchCell
            cell.switchLabel.text = categories[indexPath.row]["name"]
            cell.switchControl.on = switchStates[indexPath.row] ?? false
            cell.delegate = self
            return cell
            
        default:
            let cell = UITableViewCell()
            return cell
        }
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier("HeaderView")! as UITableViewHeaderFooterView
        let text: String
        
        switch section {
        case 0:
            text = "Yelp Deals"
        case 1:
            text = "Cuisine"
        case 2:
            text = "Sort By"
        case 3:
            text = "Category"
        default:
            text = "Error"
        }
        
        header.textLabel!.text = text
        header.detailTextLabel?.font = UIFont(name: "System", size: CGFloat(32.0))
        return header
    }
    
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPathForCell(switchCell)!
        switch indexPath.section {
        case 0:
            self.dealState = value
        case 1:
            self.switchStates[indexPath.row] = value
        default:
            return
        }
    }
    
    func yelpCategories() -> [[String:String]] {
        return [["name": "Afghani", "code": "afghani"],
            ["name": "African", "code": "african"],
            ["name": "American, New", "code": "newamerican"],
            ["name": "American, Traditional", "code": "tradamerican"],
            ["name": "Chinese", "code": "chinese"],
            ["name": "Cuban", "code": "cuban"],
            ["name": "French", "code": "french"],
            ["name": "Greek", "code": "greek"],
            ["name": "Italian", "code": "italian"],
            ["name": "Japanese", "code": "japanese"],
            ["name": "Korean", "code": "korean"],
            ["name": "Mexican", "code": "mexican"],
            ["name": "Sushi Bars", "code": "sushi"],
            ["name": "Thai", "code": "thai"],
        ]
    }
    
    func yelpDistances() -> [[String:String]] {
        return [["name": "0.1 miles", "value": "160"],
                ["name": "0.3 miles", "value": "480"],
                ["name": "0.5 miles", "value": "800"],
                ["name": "1 mile", "value": "1600"],
                ["name": "5 miles", "value": "8000"],
                ["name": "25 miles", "value": "40000"],
        ]
    }
    
    // Yelp Deals = on/off

    func yelpSort() -> [[String:String]] {
        return [["name": "Best Match", "value": "0"],
                ["name": "Distance", "value": "1"],
                ["name": "Highest Rated", "value": "2"],
        ]
    }
}
