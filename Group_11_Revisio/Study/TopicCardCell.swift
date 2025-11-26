//
//  TopicCardCell.swift
//  Group_11_Revisio
//
//  Created by SDC-USER on 26/11/25.
//

import UIKit

class TopicCardCell: UITableViewCell {
    
    
    @IBOutlet var cardContainerView: UIView!
    
    @IBOutlet var iconImageView: UIImageView!
    
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
