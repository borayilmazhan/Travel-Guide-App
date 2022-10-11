//
//  HotelsPageTableViewCell.swift
//  Travel Guide App
//
//  Created by Bora Yilmazhan on 7.10.2022.
//

import UIKit

class HotelsPageTableViewCell: UITableViewCell {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var hotelsImageView: UIImageView!
    @IBOutlet weak var hotelsNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
