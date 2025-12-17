import UIKit

struct Question {
    let text: String
    let options: [String]
    let correctAnswer: String
}

class WordFillViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var optionButtons: [UIButton]!

    @IBOutlet var Gamecard: UIView!
    // MARK: - Properties
    private var questions: [Question] = []
    private var currentQuestionIndex = 0
    private var timer: Timer?
    private var secondsRemaining = 60
    private var isProcessingAnswer = false // Prevents double-tapping during transitions

    override func viewDidLoad() {
        super.viewDidLoad()
        setupQuestions()
        setupUI()
        loadQuestion()
        startTimer()
        Gamecard.layer.cornerRadius = 20
        Gamecard.backgroundColor = UIColor(hex: "E3EFFB")
    }

    private func setupQuestions() {
        questions = [
            Question(text: "A column, or set of columns, that uniquely identifies every tuple in a relation is formally known as a ________",
                     options: ["Candidate Key", "Super Key", "Primary Key", "Foreign Key"],
                     correctAnswer: "Super Key"),
            Question(text: "The ACID property that guarantees committed changes remain permanently recorded is called ________",
                     options: ["Atomicity", "Consistency", "Isolation", "Durability"],
                     correctAnswer: "Durability"),
            Question(text: "In a relational database, a ________ is a column that creates a link between data in two tables.",
                     options: ["Primary Key", "Composite Key", "Foreign Key", "Unique Key"],
                     correctAnswer: "Foreign Key"),
            Question(text: "The process of organizing data to minimize redundancy is known as Data ________",
                     options: ["Normalization", "Indexing", "Abstraction", "Encapsulation"],
                     correctAnswer: "Normalization"),
            Question(text: "Which SQL command is used to remove all records from a table without deleting the table structure?",
                     options: ["DELETE", "DROP", "REMOVE", "TRUNCATE"],
                     correctAnswer: "TRUNCATE")
        ]
    }

    private func setupUI() {
        for button in optionButtons {
            button.layer.cornerRadius = 20
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.systemGray5.cgColor
            button.titleLabel?.numberOfLines = 0 // Allows text wrapping
            button.titleLabel?.textAlignment = .center
            // Optional improvements for multi-line layout:
            // button.titleLabel?.lineBreakMode = .byWordWrapping
            // button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        }
    }

    private func loadQuestion() {
        isProcessingAnswer = false
        let currentQuestion = questions[currentQuestionIndex]
        
        questionLabel.text = currentQuestion.text
        progressLabel.text = "Question \(currentQuestionIndex + 1)/\(questions.count)"
        progressView.setProgress(Float(currentQuestionIndex + 1) / Float(questions.count), animated: true)
        
        for (index, button) in optionButtons.enumerated() {
            button.setTitle(currentQuestion.options[index], for: .normal)
            button.backgroundColor = .systemBackground
            button.layer.borderColor = UIColor.systemGray5.cgColor
            button.isEnabled = true
            button.setTitleColor(.label, for: .normal)
        }
    }

    // MARK: - Actions
    @IBAction func optionTapped(_ sender: UIButton) {
        guard !isProcessingAnswer else { return }
        isProcessingAnswer = true
        
        let userAnswer = sender.titleLabel?.text
        let correctAnswer = questions[currentQuestionIndex].correctAnswer
        
        // Disable all buttons so user can't click others during the delay
        optionButtons.forEach { $0.isEnabled = false }

        if userAnswer == correctAnswer {
            // Correct Answer Styling
            sender.backgroundColor = .systemGreen
            sender.setTitleColor(.white, for: .normal)
        } else {
            // Wrong Answer Styling
            sender.backgroundColor = .systemRed
            sender.setTitleColor(.white, for: .normal)
            
            // Optionally highlight the correct one as well
            highlightCorrectAnswer(correctAnswer)
        }
        
        // Brief pause (0.8 seconds) so the user sees the feedback
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.moveToNextQuestion()
        }
    }

    private func highlightCorrectAnswer(_ answer: String) {
        for button in optionButtons {
            if button.titleLabel?.text == answer {
                button.layer.borderColor = UIColor.systemGreen.cgColor
                button.layer.borderWidth = 3
            }
        }
    }

    private func moveToNextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            loadQuestion()
        } else {
            showFinalResults()
        }
    }

    private func showFinalResults() {
        timer?.invalidate()
        questionLabel.text = "Quiz Complete!"
        // Add logic here to navigate to a results screen or reset
    }

    // MARK: - Timer Logic
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.secondsRemaining > 0 {
                self.secondsRemaining -= 1
                let minutes = self.secondsRemaining / 60
                let seconds = self.secondsRemaining % 60
                self.timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
            } else {
                self.timer?.invalidate()
                self.showFinalResults()
            }
        }
    }
}
