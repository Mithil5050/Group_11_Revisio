//
//  GroupCodeViewController.swift
//  Group_11_Revisio
//
//  Created by Chirag Poojari on 27/11/25.
//

import UIKit

class GroupCodeViewController: UIViewController {

    @IBOutlet weak var groupCreatedLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!

    // Data passed in
    private var groupName: String = ""
    private var inviteCode: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateLabels()
    }

    // MARK: - Public configure function
        func configure(withGroupName name: String, code: String) {
            self.groupName = name
            self.inviteCode = code

            if isViewLoaded {
                updateLabels()
            }
        }

        // MARK: - UI Setup
        private func setupUI() {
            // Make buttons round
            copyButton.layer.cornerRadius = copyButton.bounds.height / 2
            copyButton.clipsToBounds = true

            shareButton.layer.cornerRadius = shareButton.bounds.height / 2
            shareButton.clipsToBounds = true
        }

        // MARK: - Update UI text
        private func updateLabels() {
            groupCreatedLabel.text = "Group \"\(groupName)\" Created"

            codeLabel.font = UIFont.monospacedSystemFont(ofSize: 16, weight: .semibold)
            codeLabel.text = inviteCode
        }

    // MARK: - Button Actions
    @IBAction func copyButtonTapped(_ sender: UIButton) {
        UIPasteboard.general.string = inviteCode

                // Temporary visual feedback
                let original = sender.title(for: .normal)
                sender.setTitle("Copied!", for: .normal)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    sender.setTitle(original, for: .normal)
                }
    }

    @IBAction func shareButtonTapped(_ sender: UIButton) {
        let shareText = "Join my group \"\(groupName)\" with invite code: \(inviteCode)"
                let ac = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)

                ac.popoverPresentationController?.sourceView = sender
                ac.popoverPresentationController?.sourceRect = sender.bounds

                present(ac, animated: true)
    }

    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
