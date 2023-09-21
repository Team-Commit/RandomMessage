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
    
    private lazy var messageTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = UIFont.systemFont(ofSize: 50)
        textView.autocorrectionType = .no
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return textView
    }()
    
    private lazy var letterView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Home")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var sendButton:UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 3
        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.setTitle("Send", for: .normal)
        return button
    }()
}

//MARK: - View Cycle
extension SendMessageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavButton()
        setupTextView()
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupTextView() {
        
        
    }
}


extension SendMessageViewController {
    func setupNavButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
        
        navigationItem.rightBarButtonItem
    }
}



//MARK: - Setup UI

private extension SendMessageViewController {
    func setupUI() {
        
        view.backgroundColor = .white
        view.addSubview(letterView)
        view.addSubview(messageTextView)
        view.addSubview(sendButton)
        messageTextView.delegate = self
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
        
    }
    
}

//MARK: - Constraints
private extension SendMessageViewController {
    func setupConstraints() {
        letterView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().multipliedBy(0.2)
            make.height.equalTo(letterView.snp.width)
        }
        
        
        sendButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(messageTextView.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(50) // Set to desired button height
        }
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
