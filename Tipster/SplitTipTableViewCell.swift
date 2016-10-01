//
//  SplitTipTableViewCell.swift
//  Tipster
//
//  Created by Ryan Chee on 9/30/16.
//  Copyright © 2016 ryanchee. All rights reserved.
//

import UIKit

class SplitTipTableViewCell: UITableViewCell {

    @IBOutlet weak var splitTabImageView: UIImageView!
    @IBOutlet weak var splitTipImageCell: UIImageView!
    @IBOutlet weak var totalSplitLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
