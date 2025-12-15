// QuickGamesCollectionViewCell.swift

import UIKit

class QuickGamesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Delegate Property
    weak var delegate: QuickGamesCellDelegate?
    
    // Card 1 Outlets (Word Fill)
    @IBOutlet weak var gameCard: UIView!
    @IBOutlet weak var gameImage1: UIImageView!
    @IBOutlet weak var gameTitle1: UILabel!
    
    // Card 2 Outlets (Connections)
    @IBOutlet weak var gameCard2: UIView!
    @IBOutlet weak var gameImage2: UIImageView!
    @IBOutlet weak var gameTitle2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // --- Setup UI/Design ---
        gameCard.layer.cornerRadius = 12
        gameCard.backgroundColor = UIColor(hex: "F0FFDB") // Light green/yellow aesthetic
        gameCard2.layer.cornerRadius = 12
        gameCard2.backgroundColor = UIColor(hex: "91C1EF", alpha: 0.25) // Light blue aesthetic
        
        // --- Tap Handling ---
        
        // 1. Ensure user interaction is enabled on the card views
        gameCard.isUserInteractionEnabled = true
        gameCard2.isUserInteractionEnabled = true
        
        // 2. Add tap gestures
        let wordFillTap = UITapGestureRecognizer(target: self, action: #selector(wordFillCardTapped))
        gameCard.addGestureRecognizer(wordFillTap)
        
        let connectionsTap = UITapGestureRecognizer(target: self, action: #selector(connectionsCardTapped))
        gameCard2.addGestureRecognizer(connectionsTap)
    }

    // MARK: - Tap Handlers
    
    @objc func wordFillCardTapped() {
        // Notify the HomeViewController that the 'Word Fill' game was selected
        delegate?.didSelectQuickGame(gameTitle: "Word Fill")
    }
    
    @objc func connectionsCardTapped() {
        // Notify the HomeViewController that the 'Connections' game was selected
        delegate?.didSelectQuickGame(gameTitle: "Connections")
    }
    
    // MARK: - Configuration
    
    // Configuration method for dynamic content for TWO items
    func configure(with item1: GameItem, and item2: GameItem) {
        
        // --- Configure Card 1 (Item 1: Word Fill) ---
        gameTitle1.text = item1.title.uppercased()
        
        if item1.imageAsset.contains(" ") == false && UIImage(systemName: item1.imageAsset) != nil {
            gameImage1.image = UIImage(systemName: item1.imageAsset)
        } else {
            // Assumes your image assets are in the Assets Catalog
            gameImage1.image = UIImage(named: item1.imageAsset)
        }

        // --- Configure Card 2 (Item 2: Connections) ---
        gameTitle2.text = item2.title.uppercased()

        if item2.imageAsset.contains(" ") == false && UIImage(systemName: item2.imageAsset) != nil {
            gameImage2.image = UIImage(systemName: item2.imageAsset)
        } else {
            gameImage2.image = UIImage(named: item2.imageAsset)
        }
    }
}
