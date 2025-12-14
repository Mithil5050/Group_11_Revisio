//
//  GenerationViewController.swift
//  Group_11_Revisio
//
//  Created by Mithil on 27/11/25.
//

import UIKit

// Represents the different types of study material the user can generate.
enum GenerationType {
    case quiz
    case flashcards
    case notes
    case cheatsheet
    case none // Default state
}

// ⚠️ REQUIRED: Extension to provide a string representation for the 'Source' case data mapping.
extension GenerationType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .quiz: return "Quiz"
        case .flashcards: return "Flashcards"
        case .notes: return "Notes"
        case .cheatsheet: return "Cheatsheet"
        case .none: return "Material"
        }
    }
}


class GenerationViewController: UIViewController {
    
    // MARK: - Data Properties
    var currentGenerationType: GenerationType = .none
    var sourceItems: [Any]? // Data source (e.g., Topic or Source objects)
    var parentSubjectName: String? // Contextual name for the navigation bar/context
    
    // MARK: - IBOutlets
    
    // Main Action Button
    @IBOutlet weak var generateButton: UIButton!
    
    // Settings container views (These should overlap in the Storyboard)
    @IBOutlet weak var QuizSettingsView: UIView!
    @IBOutlet weak var FlashcardSettingsView: UIView!
    @IBOutlet weak var emptySettingsPlaceholder: UIView! // Used for types without custom settings (Notes/Cheatsheet)
    
    // Top Tab Buttons (Function as a segment control)
    @IBOutlet weak var quizButton: UIButton!
    @IBOutlet weak var flashcardsButton: UIButton!
    @IBOutlet weak var notesButton: UIButton!
    @IBOutlet weak var cheatsheetButton: UIButton!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup initial state: Select Quiz by default
        showSettingsView(QuizSettingsView)
        updateButtonHighlight(selectedButton: quizButton)
        
        // Initial button state (should be updated immediately by updateGenerateButton)
        updateGenerateButton(for: .quiz)
    }
    
    // MARK: - Private Configuration Methods
    
    /**
     Controls which settings view is visible to the user.
     - Parameter viewToShow: The specific settings container view to display.
     */
    private func showSettingsView(_ viewToShow: UIView) {
        // 1. Create an array of all settings views
        let allSettingsViews: [UIView?] = [
            QuizSettingsView,
            FlashcardSettingsView,
            emptySettingsPlaceholder
        ]
        
        // 2. Hide all views
        for view in allSettingsViews {
            view?.isHidden = true
        }
        
        // 3. Show the selected view
        viewToShow.isHidden = false
    }
    
    /**
     Updates the text and enabled state of the primary generation button.
     - Parameter type: The selected GenerationType.
     */
    private func updateGenerateButton(for type: GenerationType) {
        self.currentGenerationType = type
        
        let title: String
        let isEnabled: Bool
        
        if type == .none {
            title = "Generate"
            isEnabled = false
        } else {
            title = "Generate \(type.description)" // Uses the CustomStringConvertible extension
            isEnabled = true
        }
        
        generateButton.setTitle(title, for: .normal)
        generateButton.isEnabled = isEnabled
        
        // Apply professional, modern iOS 26 visual state
        generateButton.alpha = isEnabled ? 1.0 : 0.5
    }
    
    /**
     Manages the visual selection state of the tab buttons (iOS-style segmented appearance).
     - Parameter selectedButton: The button that was just tapped.
     */
    private func updateButtonHighlight(selectedButton: UIButton) {
        let allButtons: [UIButton?] = [
            quizButton,
            flashcardsButton,
            notesButton,
            cheatsheetButton
        ]
        
        // --- Define the Gray Aesthetic Colors (Based on iOS Semantic Colors) ---
        let unselectedBackground = UIColor.systemGray6 // Very light gray card
        let selectedBackground = UIColor.systemGray4   // Medium gray for subtle highlight
        let unselectedTitleColor = UIColor.darkGray    // Dark text for contrast
        let selectedTitleColor = UIColor.label         // Black text/icon for selected state
        let unselectedIconTint = UIColor.darkGray      // Dark gray icon color
        let selectedIconTint = UIColor.label           // Black icon color
        
        for button in allButtons {
            let isSelected = (button === selectedButton)
            
            if isSelected {
                // SELECTED STATE: Medium gray background, black text/icon.
                button?.backgroundColor = selectedBackground
                button?.setTitleColor(selectedTitleColor, for: .normal)
                button?.tintColor = selectedIconTint // Controls the icon color
            } else {
                // UNSELECTED STATE: Very light gray background, dark gray text/icon.
                button?.backgroundColor = unselectedBackground
                button?.setTitleColor(unselectedTitleColor, for: .normal)
                button?.tintColor = unselectedIconTint
            }
            
            // Apply standard iOS-style corner radius
            button?.layer.cornerRadius = 12
        }
    }
    
    // MARK: - Action Handlers (Button Taps)
    
    @IBAction func quizButtonTapped(_ sender: UIButton) {
        showSettingsView(QuizSettingsView)
        updateButtonHighlight(selectedButton: sender)
        updateGenerateButton(for: .quiz)
    }
    
    @IBAction func flashCardsButtonTapped(_ sender: UIButton) {
        showSettingsView(FlashcardSettingsView)
        updateButtonHighlight(selectedButton: sender)
        updateGenerateButton(for: .flashcards)
    }
    
    @IBAction func notesButtonTapped(_ sender: UIButton) {
        showSettingsView(emptySettingsPlaceholder)
        updateButtonHighlight(selectedButton: sender)
        updateGenerateButton(for: .notes)
    }
    
    @IBAction func cheatsheetButtonTapped(_ sender: UIButton) {
        showSettingsView(emptySettingsPlaceholder)
        updateButtonHighlight(selectedButton: sender)
        updateGenerateButton(for: .cheatsheet)
    }
    
    @IBAction func generateButtonTapped(_ sender: UIButton) {
        
        // 1. Validate source data availability
        guard let sourceItem = sourceItems?.first else {
            print("Error: No source item available to generate material from.")
            return
        }
        
        // 2. Determine the Topic/Data payload to pass to the next screen
        let topicToPass: Topic?
        if let topic = sourceItem as? Topic {
            // Case 1: Source item is already a Topic object
            topicToPass = topic
        } else if let source = sourceItem as? Source {
            // Case 2: Source item is a Source object, create a temporary Topic structure
            
            // ⭐️ MODIFICATION HERE: Use "Big Data" as the topic name regardless of source.name
            let fixedTopicName = "Big Data"
            topicToPass = Topic(name: fixedTopicName, lastAccessed: "N/A", materialType: currentGenerationType.description)
            
        } else {
            topicToPass = nil
        }
        
        // 3. Ensure valid Topic data exists
        guard let topic = topicToPass else {
            print("Error: Could not create valid Topic data to proceed.")
            return
        }
        
        // 4. Perform Segue based on the current generation type
        switch currentGenerationType {
        case .quiz:
            print("Initiating Quiz Generation and segue to Instructions...")
            performSegue(withIdentifier: "ShowQuizInstructionsFromGen", sender: topic)
            
        case .flashcards:
            print("Initiating Flashcard Generation and segue to Flashcard View...")
            performSegue(withIdentifier: "ShowFlashcardsFromGen", sender: topic)
            
        case .notes, .cheatsheet, .none:
            print("Generation type \(currentGenerationType.description) not yet fully implemented for segue.")
            break
        }
    }
    
    // MARK: - Navigation
    
    /**
     Prepares the destination view controller before the transition.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Ensure the sender is the expected Topic data structure
        guard let topicData = sender as? Topic else {
            if segue.identifier == "ShowQuizInstructionsFromGen" || segue.identifier == "ShowFlashcardsFromGen" {
                print("Prepare Error: Sender was not a Topic.")
            }
            return
        }
        
        if segue.identifier == "ShowQuizInstructionsFromGen" {
            // Target: InstructionViewController
            if let instructionVC = segue.destination as? InstructionViewController {
                // Pass contextual data to the Quiz Instructions screen
                instructionVC.quizTopic = topicData
                instructionVC.parentSubjectName = self.parentSubjectName
            }
        } else if segue.identifier == "ShowFlashcardsFromGen" {
            // Target: FlashcardViewController
            if let flashcardVC = segue.destination as? FlashcardViewController {
                // Pass contextual data to the Flashcard View Controller
                flashcardVC.flashcardTopicName = topicData.name
                flashcardVC.parentSubjectName = self.parentSubjectName
                // NOTE: In a production app, you would pass the actual generated flashcard array here.
            }
        }
    }
}
