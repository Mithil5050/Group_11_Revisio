//
//  CreateFolderViewController.swift
//  Group_11_Revisio
//
//  Created by SDC-USER on 27/11/25.
//

import UIKit

class CreateFolderViewController: UIViewController {
    
    @IBOutlet var folderNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        guard let newFolderName = folderNameTextField.text, !newFolderName.isEmpty else {
               
                print("Folder name cannot be empty.")
                return
            }

            
            DataManager.shared.createNewSubjectFolder(name: newFolderName)

            self.dismiss(animated: true, completion: nil)
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
