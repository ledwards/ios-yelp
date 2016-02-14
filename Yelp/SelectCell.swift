//
//  SelectCell.swift
//  Yelp
//
//  Created by Lee Edwards on 2/14/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SelectCellDelegate {
    optional func selectCell(selectCell: SelectCell, didChangeValue value: String)
}

class SelectCell: UITableViewCell {
    @IBOutlet weak var selectLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func labelTapped() {
        print("label tapped")
    }

}
