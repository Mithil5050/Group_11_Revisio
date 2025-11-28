import UIKit

// Place these structures at the very top of HomeViewController.swift
struct ContentItem: Hashable, Sendable {
    let title: String
    let iconName: String
    let itemType: String
}

struct GameItem: Hashable, Sendable {
    let title: String
    let imageAsset: String
}
// Define your Home Screen Sections
enum HomeSection: Int, CaseIterable {
    case hero = 0             // Hi Alex Card
    case uploadContent        // List of files/links
    case continueLearning     // List of learning items
    case quickGames           // Game grid
}

// Reuse Identifiers (Must match what is set in the XIB files' Identity Inspector)
let hiAlexCellID = "HiAlexCellID"
let uploadContentCellID = "UploadContentCellID"
let continueLearningCellID = "ContinueLearningCellID"
let quickGamesCellID = "QuickGamesCellID"
let headerID = "HeaderID" // For the section titles
// Make sure ContentItem and GameItem structs are here (outside the class)
// struct ContentItem: Hashable, Sendable { ... }
// struct GameItem: Hashable, Sendable { ... }

class HomeViewController: UIViewController, UICollectionViewDataSource {
    
    // Replace with your actual data source logic (using your custom structs)
    var heroData: [ContentItem] = []
    var uploadItems: [ContentItem] = []
    var learningItems: [ContentItem] = []
    var gameItems: [GameItem] = []

    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Load Dummy Data (Replace with real loading logic)
        // For demonstration, ensure your arrays are populated
        heroData = [ContentItem(title: "Hi Alex !", iconName: "", itemType: "Greeting")]
        uploadItems = [ContentItem(title: "Big Data.pdf", iconName: "", itemType: "PDF")]
        learningItems = [ContentItem(title: "Area under functions", iconName: "", itemType: "Topic")]
        gameItems = [GameItem(title: "Word Scramble", imageAsset: "")]

        // 2. Setup
        registerCustomCells()
        collectionView.collectionViewLayout = generateLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: - Layout Configuration (Adapt the generateLayout function to use your sections)

    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, env in
            
            let sectionType = HomeSection.allCases[sectionIndex]
            
            // Header definition
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(40))
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            
            // Reusable item size
            let listGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(60))
            let listItemLayout = NSCollectionLayoutItem(layoutSize: listGroupSize)

            switch sectionType {
            case .hero:
                // Full-width Hero Card
                let heroItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(180))
                let heroItem = NSCollectionLayoutItem(layoutSize: heroItemSize)
                let heroGroup = NSCollectionLayoutGroup.horizontal(layoutSize: heroItemSize, subitems: [heroItem])
                let section = NSCollectionLayoutSection(group: heroGroup)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20)
                return section
                
            case .uploadContent, .continueLearning:
                // Standard List Layout (single column)
                let listGroup = NSCollectionLayoutGroup.vertical(layoutSize: listGroupSize, subitems: [listItemLayout])
                let section = NSCollectionLayoutSection(group: listGroup)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20)
                section.boundarySupplementaryItems = [headerItem]
                return section
                
            case .quickGames:
                // Grid Layout (Example: two columns)
                let gameItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(150))
                let gameItem = NSCollectionLayoutItem(layoutSize: gameItemSize)
                gameItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10)

                let gameGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(150))
                let gameGroup = NSCollectionLayoutGroup.horizontal(layoutSize: gameGroupSize, subitem: gameItem, count: 2)
                let section = NSCollectionLayoutSection(group: gameGroup)
                section.boundarySupplementaryItems = [headerItem]
                return section
            }
        }
        return layout
    }

    func registerCustomCells() {
        // ⬇️ REGISTERING YOUR SPECIFIC XIB FILES ⬇️
        collectionView.register(UINib(nibName: "HiAlexCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: hiAlexCellID)
        collectionView.register(UINib(nibName: "UploadContentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: uploadContentCellID)
        collectionView.register(UINib(nibName: "ContinueLearningCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: continueLearningCellID)
        collectionView.register(UINib(nibName: "QuickGamesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: quickGamesCellID)
        
        // Register the reusable header view (assuming you have a generic Header XIB)
        collectionView.register(UINib(nibName: "HeaderViewCollectionReusableView", bundle: nil),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: headerID)
    }
    
    // MARK: - UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return HomeSection.allCases.count // Returns 4 sections
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = HomeSection.allCases[section]
        switch sectionType {
        case .hero: return heroData.count
        case .uploadContent: return uploadItems.count
        case .continueLearning: return learningItems.count
        case .quickGames: return gameItems.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = HomeSection.allCases[indexPath.section]
        
        switch sectionType {
        case .hero:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: hiAlexCellID, for: indexPath) as! HiAlexCollectionViewCell
            // cell.configure(with: heroData[indexPath.row])
            return cell
            
        case .uploadContent:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: uploadContentCellID, for: indexPath) as! UploadContentCollectionViewCell
            // cell.configure(with: uploadItems[indexPath.row])
            return cell
            
        case .continueLearning:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: continueLearningCellID, for: indexPath) as! ContinueLearningCollectionViewCell
            // cell.configure(with: learningItems[indexPath.row])
            return cell
            
        case .quickGames:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: quickGamesCellID, for: indexPath) as! QuickGamesCollectionViewCell
            // cell.configure(with: gameItems[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader else {
            fatalError("Unexpected supplementary view kind.")
        }
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                       withReuseIdentifier: headerID,
                                                                       for: indexPath) as! HeaderViewCollectionReusableView
        
        let sectionType = HomeSection.allCases[indexPath.section]
        
        let title: String
        switch sectionType {
        case .uploadContent: title = "Upload Content"
        case .continueLearning: title = "Continue Learning"
        case .quickGames: title = "Quick Games"
        default: title = "" // No header for hero section
        }
        
        // Assuming your HeaderViewCollectionReusableView has a configureHeader method
        headerView.configureHeader(with: title)
        
        return headerView
    }
}

// MARK: - UICollectionViewDelegate (For Taps)
extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = HomeSection.allCases[indexPath.section]
        
        switch sectionType {
        case .hero:
            print("Hero Card Tapped: Navigate to Profile/Tasks.")
        case .quickGames:
            print("Game Card Tapped: Start game at index \(indexPath.item)")
        default:
            break
        }
    }
}
