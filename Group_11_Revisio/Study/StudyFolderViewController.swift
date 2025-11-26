//
//  StudyFolderViewController.swift
//  Group_11_Revisio
//
//  Created by SDC-USER on 26/11/25.
//

import UIKit

class StudyFolderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let studyTableView = UITableView(frame: .zero, style: .plain)
        
    private let studyMaterials: [String] = [
        "Calculus",
        "Big Data",
        "MMA",
        "Swift Fundamentals",
        "Computer Networks"
    ]
        
    override func viewDidLoad() {
        super.viewDidLoad()
            
        view.backgroundColor = .systemBackground
            
        view.addSubview(studyTableView)
            
        studyTableView.translatesAutoresizingMaskIntoConstraints = false
            
        studyTableView.dataSource = self
        studyTableView.delegate = self
            
        studyTableView.register(UITableViewCell.self, forCellReuseIdentifier: "StudyCell")
            
        if #available(iOS 11.0, *) {
            studyTableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
            
        setupConstraints()
    }
    
    // MARK: - Navigation Data Transfer
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSubjectDetailProgrammatic" {
            // NOTE: Assuming your detail view controller is named SubjectDetailViewController,
            // I've corrected SubjectViewController to the standard naming convention used earlier.
            if let detailVC = segue.destination as? SubjectViewController {
                if let selectedSubject = sender as? String {
                    detailVC.selectedSubject = selectedSubject
                }
            }
        }
    }
        
    func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
            
        NSLayoutConstraint.activate([
            studyTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            studyTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            studyTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            studyTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
        
    // MARK: - UITableViewDataSource
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studyMaterials.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudyCell", for: indexPath)
            
        cell.textLabel?.text = studyMaterials[indexPath.row]
        cell.imageView?.image = UIImage(systemName: "folder")
        cell.imageView?.tintColor = UIColor.systemBlue
        cell.accessoryType = .disclosureIndicator
            
        return cell
    }
        
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            // Using a plain style table view, this provides the "Your Materials" header
            return "Your Materials"
        }
        return nil
    }
        
    // MARK: - UITableViewDelegate (Segue Trigger)
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect the row immediately for standard iOS behavior
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 1. Get the subject data for the selected row
        let selectedSubjectName = studyMaterials[indexPath.row]
        
        // 2. Trigger the segue defined in the Storyboard
        performSegue(withIdentifier: "ShowSubjectDetailProgrammatic", sender: selectedSubjectName)
    }
}
