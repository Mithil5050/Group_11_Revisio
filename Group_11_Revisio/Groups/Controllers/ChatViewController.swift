//
//  ChatViewController.swift
//  Group_11_Revisio
//
//  Created by Chirag Poojari on 10/12/25.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    // Will be set before pushing
    var groupName: String?

    // simple sample messages — in real app this comes from server / DB
    private var messages: [Message] = [
        Message(text: "Hey! Can you share the notes of Derivatives?", isOutgoing: false, date: Date()),
        Message(text: "Yes sure. Do you need the cheat sheet as well?", isOutgoing: true, date: Date()),
        Message(text: "Yes! That would be of great help.", isOutgoing: false, date: Date())
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Title
        title = groupName ?? "Chat"

        // TableView setup
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60

        // If prototype cell used, ensure reuse identifier matches
        // If using nib, register nib here.

        // Scroll to bottom initial
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.scrollToBottom(animated: false)
        }
    }

    // MARK: - Table Data Source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCellIdentifier", for: indexPath) as? MessageCell else {
            return UITableViewCell()
        }

        let message = messages[indexPath.row]
        cell.configure(with: message)
        cell.selectionStyle = .none
        return cell
    }

    // MARK: - Helpers

    func scrollToBottom(animated: Bool) {
        let last = messages.count - 1
        guard last >= 0 else { return }
        let ip = IndexPath(row: last, section: 0)
        tableView.scrollToRow(at: ip, at: .bottom, animated: animated)
    }
}
