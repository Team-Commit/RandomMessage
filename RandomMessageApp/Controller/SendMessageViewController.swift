//
//  SendMessageView.swift
//  RandomMessageApp
//
//  Created by ㅣ on 2023/09/18.
//

import UIKit
import SnapKit
import BonMot

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
    
    private lazy var background: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Home")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
}

//MARK: - View Cycle
extension SendMessageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
        
        setupTextView()
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupTextView() {
    }
}

//MARK: - Setup UI

private extension SendMessageViewController {
    func setupUI() {
        
        
        view.addSubview(background)
        view.addSubview(messageTextView)
        messageTextView.delegate = self
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
        
    }
    
}

//MARK: - Constraints
private extension SendMessageViewController {
    func setupConstraints() {
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
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
        return updatedText.count <= 500
    }
}



//MARK: - Bonmot

extension SendMessageViewController {
    
}
