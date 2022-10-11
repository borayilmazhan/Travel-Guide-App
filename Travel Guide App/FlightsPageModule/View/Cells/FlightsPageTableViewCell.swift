//
//  FlightsPageTableViewCell.swift
//  Travel Guide App
//
//  Created by Bora Yilmazhan on 7.10.2022.
//

import UIKit

class FlightsPageTableViewCell: UITableViewCell {

    @IBOutlet weak var flightLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
