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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        categories = yelpCategories()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as! SwitchCell
        
        cell.switchLabel.text = categories[indexPath.row]["name"]
        cell.switchControl.on = switchStates[indexPath.row] ?? false
        cell.delegate = self
        
        return cell
    }
    
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPathForCell(switchCell)!
        
        self.switchStates[indexPath.row] = value
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
}
