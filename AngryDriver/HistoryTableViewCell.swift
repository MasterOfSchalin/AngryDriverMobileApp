//
//  HistoryTableViewCell.swift
//  AngryDriver
//
//  Created by David Prochazka on 02/04/16.
//  Copyright © 2016 David Prochazka. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var numberOfPoints: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
