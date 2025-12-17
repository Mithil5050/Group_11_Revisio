//
//  ReviewDetailViewController.swift
//  Group_11_Revisio
//
//  Created by Ayaana Talwar on 14/12/25.
//

import UIKit

class ReviewDetailViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var reviewTableView: UITableView!
    
    var allQuestionDetails: [QuestionResultDetail] = []
    var filteredQuestionDetails: [QuestionResultDetail] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewTableView.dataSource = self
                reviewTableView.delegate = self
                
               
                title = "Review Summary"
                
               
                filterResults(for: segmentedControl.selectedSegmentIndex)
                
                
                reviewTableView.reloadData()

        
    }
    
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        filterResults(for: sender.selectedSegmentIndex)
                reviewTableView.reloadData()
    }
    func filterResults(for index: Int) {
            switch index {
            case 0:
                filteredQuestionDetails = allQuestionDetails
            case 1:
                
                filteredQuestionDetails = allQuestionDetails.filter { $0.wasCorrect == true }
            case 2:
               
                filteredQuestionDetails = allQuestionDetails.filter { $0.wasCorrect == false }
            default:
                filteredQuestionDetails = allQuestionDetails
            }
        }

        // MARK: - UITableViewDataSource Methods
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return filteredQuestionDetails.count
        }
        
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as? ReviewQuestionCell else {
           
            return UITableViewCell()
        }
        
        let detail = filteredQuestionDetails[indexPath.row]
        
        
        cell.configure(with: detail, index: indexPath.row)
        
        return cell
    }
        
        // MARK: - UITableViewDelegate Methods

        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }

        func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            
            return 80
        }
        
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
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
