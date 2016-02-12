//
//  SwitchCell.swift
//  Yelp
//
//  Created by Lee Edwards on 2/8/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate {
    optional func switchCell(switchCell: SwitchCell, didChangeValue value: Bool)
}

class SwitchCell: UITableViewCell {
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var switchControl: UISwitch!
    
    weak var delegate: SwitchCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onSwitch(sender: AnyObject) {
        delegate?.switchCell?(self, didChangeValue: self.switchControl.on)
    }
    
    func switchValueChanged() {
        delegate?.switchCell?(self, didChangeValue: switchControl.on)
    }

}
