//
//  SendMessageView.swift
//  RandomMessageApp
//
//  Created by ㅣ on 2023/09/18.
//

import UIKit


//MARK: - Properties
class SendMessageViewController: UIViewController {
    
}



//MARK: - View Cycle

extension SendMessageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))

        
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

}


