//
//  BadgeCollectionViewCell.swift
//  Group_11_Revisio
//
//  Created by Ashika Yadav on 16/12/25.
//

import UIKit

class BadgeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var badgeCardView: UIView!
    
    @IBOutlet weak var badgeImageView: UIImageView!
    
    @IBOutlet weak var badgeTitleLabel: UILabel!
    
    @IBOutlet weak var badgeDetailLabel: UILabel!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            setupCardStyle()
        }
        
        // MARK: - Configuration Method
        
        func configure(with badge: Badge) {
            
            badgeTitleLabel.text = badge.title
            badgeDetailLabel.text = badge.detail
            badgeImageView.image = UIImage(named: badge.imageAssetName)
            
            // Apply visual states based on lock status
            if badge.isLocked {
                badgeImageView.alpha = 0.5
                badgeDetailLabel.textColor = .secondaryLabel
            } else {
                badgeImageView.alpha = 1.0
                badgeDetailLabel.textColor = .systemGray
            }
        }
        
        private func setupCardStyle() {
            
            let radius: CGFloat = 12
            
            
           badgeCardView.backgroundColor = .systemGray6
            badgeCardView.layer.cornerRadius = radius
            badgeCardView.layer.masksToBounds = true
            
          
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = 0.1
            self.layer.shadowOffset = CGSize(width: 0, height: 1)
            self.layer.shadowRadius = 3
            self.layer.masksToBounds = false
            self.layer.shouldRasterize = true
            self.layer.rasterizationScale = UIScreen.main.scale
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
           
            self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 12).cgPath
        }
    }
