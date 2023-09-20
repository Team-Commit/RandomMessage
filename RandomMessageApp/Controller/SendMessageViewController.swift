//
//  SendMessageView.swift
//  RandomMessageApp
//
//  Created by ㅣ on 2023/09/18.
//

import UIKit

//MARK: - Properties
class SendMessageViewController: UIViewController {
    
    private let messageTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.autocorrectionType = .no
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return textView
    }()
}

//MARK: - View Cycle
extension SendMessageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
        
        setupTextView()
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupTextView() {
        view.addSubview(messageTextView)
        messageTextView.delegate = self
        // Add constraints as needed. This is just an example.
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            messageTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            messageTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            messageTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15)
        ])
    }
}

//MARK: - UITextViewDelegate
extension SendMessageViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        // Ensure the character count is under the maximum limit.
        // Adjust the number 500 to whatever your desired limit is.
        return updatedText.count <= 500
    }
}
