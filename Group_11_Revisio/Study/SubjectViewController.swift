//
//  SubjectViewController.swift
//  Group_11_Revisio
//
//  Created by SDC-USER on 26/11/25.
//

import UIKit

class SubjectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // This property is set by StudyFolderViewController in prepare(for:sender:)
    var selectedSubject: String?
    var currentTopics: [Topic] = []
    
    @IBOutlet var materialsSegmentedControl: UISegmentedControl!
    @IBOutlet var topicsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure the UI using the selected subject if available
        if let selectedSubject {
            title = selectedSubject
            loadContentForSubject(selectedSubject)
            setupTableView()
        }

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
    }
    
    func setupTableView() {
        // Assign protocols
        topicsTableView.delegate = self
        topicsTableView.dataSource = self
        
        // Hides cell separators for clean card design
        topicsTableView.separatorStyle = .none
        
        // If using a nib for TopicCardCell, uncomment and ensure nib name matches
        // let nib = UINib(nibName: "TopicCardCell", bundle: nil)
        // topicsTableView.register(nib, forCellReuseIdentifier: "TopicCardCell")
        
        // If using a storyboard prototype cell, ensure the identifier is set to "TopicCardCell"
    }
    
    func loadContentForSubject(_ subject: String) {
        // Fetch the list of topics from the global DataStore
        if let topics = DataStore.subjectTopics[subject] {
            self.currentTopics = topics
        } else {
            self.currentTopics = []
        }
        topicsTableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentTopics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue your custom cell
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCardCell", for: indexPath) as? TopicCardCell {
            let topic = currentTopics[indexPath.row]
            cell.titleLabel.text = topic.name
            cell.subtitleLabel.text = "Last accessed: \(topic.lastAccessed)"
            cell.iconImageView.image = UIImage(systemName: topic.iconSystemName)
            cell.iconImageView.tintColor = .systemBlue
            cell.selectionStyle = .none
            // Optional: style the card container
            cell.cardContainerView.layer.cornerRadius = 12
            cell.cardContainerView.layer.masksToBounds = true
            return cell
        }
        
        // Fallback basic cell if the custom cell isn't available
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "FallbackCell")
        let topic = currentTopics[indexPath.row]
        cell.textLabel?.text = topic.name
        cell.detailTextLabel?.text = "Last accessed: \(topic.lastAccessed)"
        cell.imageView?.image = UIImage(systemName: topic.iconSystemName)
        cell.imageView?.tintColor = .systemBlue
        cell.selectionStyle = .none
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Handle topic selection if needed
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
