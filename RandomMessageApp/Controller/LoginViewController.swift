//
//  ViewController.swift
//  RandomMessageApp
//
//  Created by ㅣ on 2023/09/17.
//

import UIKit
import RiveRuntime
import SnapKit
import LocalAuthentication



//MARK: - Properties
class LoginViewController: UIViewController {
    let simpleVM = RiveViewModel(fileName: "login")
    let context = LAContext()
    var error: NSError? = nil
    let reason = "Please authenticate yourself to proceed."

    private lazy var riveView: RiveView = {
        let view = RiveView()
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "MainLabel"
        label.textAlignment = .center
        label.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.layer.borderWidth = 3
        label.layer.cornerRadius = 20
        return label
    }()
    
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.layer.cornerRadius = 20
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var background: UIImageView = {
        let background = UIImageView()
        return background
    }()
    
    
}

//MARK: - Button Action

extension LoginViewController{
    
    
    @objc func loginButtonTapped() {
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
            print("Device does not support Face ID / Touch ID.")
            return
        }
        
        context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "인증이 필요합니다") { [weak self] success, authenticationError in
            DispatchQueue.main.async {
                guard success else {
                    print("Authentication failed.")
                    return
                }
                
                // Generate UUID
                let userUUID = UUID().uuidString
                
                // Send UUID to server
                APIManager.shared.sendUserUUID(uuid: userUUID) { result in
                    switch result {
                    case .success(let token):
                        // Store token in Keychain
                        self?.storeTokenInKeychain(token: token)
                        
                        let mainVC = MainViewController()
                        let navVC = UINavigationController(rootViewController: mainVC)
                        navVC.modalTransitionStyle = .crossDissolve
                        navVC.modalPresentationStyle = .fullScreen
                        self?.present(navVC, animated: true)
                        print("Authentication was successful.")
                        
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }
            }
        }
    }
    
    func storeTokenInKeychain(token: String) {
        let tokenData = Data(token.utf8)
        let keychainQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "userToken",
            kSecValueData as String: tokenData
        ]
        
        SecItemAdd(keychainQuery as CFDictionary, nil)
    }
}




//MARK: - View Cycle

extension LoginViewController {
    
    override func viewDidLoad() {

        super.viewDidLoad()
        let riveView = simpleVM.createRiveView()
        view.addSubview(riveView)
        let width: CGFloat = 1000
        let height: CGFloat = 1000
        let x: CGFloat = (view.bounds.width - width) / 2
        let y: CGFloat = (view.bounds.height - height) / 2
        riveView.frame = CGRect(x: x, y: y, width: width, height: height)
        setupUI()
    }
}


//MARK: - Setup UI
extension LoginViewController {
    func setupUI() {
        view.addSubview(loginButton)
        view.addSubview(label)
        setupConstraints()
    }
    
    
    //MARK: - Constraints
    
    func setupConstraints() {
        
        label.snp.makeConstraints { make in
              make.centerX.equalToSuperview()
              make.top.equalToSuperview().offset(100)
            make.height.equalTo(50)
            make.width.equalTo(200)

             
          }
            
        loginButton.snp.makeConstraints { make in
              make.centerX.equalToSuperview()
              make.bottom.equalToSuperview().offset(-100)
              make.height.equalTo(50)
              make.width.equalTo(200)
          }
        
    }
}

extension LoginViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }
}


