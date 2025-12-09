//
//  CreateGroupViewController.swift
//  Group_11_Revisio
//
//  Created by Chirag Poojari on 27/11/25.
//

import UIKit

class CreateGroupViewController: UIViewController {

    @IBOutlet weak var groupNameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func generateButtonTapped(_ sender: UIButton) {
        // 1. Read group name or fallback to placeholder
                let groupName = groupNameTextField?.text?
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                    .isEmpty == false ? groupNameTextField!.text! : "New Group"

                // 2. Generate invite code
                let code = CreateGroupViewController.generateInviteCode()

                // 3. Load the modal VC
                let storyboard = UIStoryboard(name: "Groups", bundle: nil)
                guard let codeVC = storyboard.instantiateViewController(withIdentifier: "GroupCodeVC") as? GroupCodeViewController else {
                    print("ERROR: Storyboard does NOT contain GroupCodeVC")
                    return
                }

                // 4. Pass data
                codeVC.configure(withGroupName: groupName, code: code)

                // 5. Present as modal sheet
                codeVC.modalPresentationStyle = .pageSheet
                self.present(codeVC, animated: true, completion: nil)

    }

    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    static func generateInviteCode() -> String {
            let chars = Array("ABCDEFGHJKLMNPQRSTUVWXYZ23456789")
            func randomBlock() -> String {
                return String((0..<4).map { _ in chars.randomElement()! })
            }
            return "\(randomBlock())-\(randomBlock())"
        }
}
