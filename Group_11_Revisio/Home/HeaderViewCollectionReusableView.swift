//
//  HeaderViewCollectionReusableView.swift
//  Group_11_Revisio
//
//  Created by Mithil on 28/11/25.
//

import UIKit

class HeaderViewCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var TitleName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureHeader(with title: String) {
            // Implement the logic to set the title text
            TitleName.text = title.uppercased() // Using uppercased for prominence
        }
    
}
