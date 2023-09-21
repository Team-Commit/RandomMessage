

import UIKit


class GreetViewController: UIViewController   {
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.text = "너의 별명은 무엇이니"
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    private lazy var enrolledButton: UIButton = {
        let button = UIButton()
        
        
        button.backgroundColor = .brown
        button.addTarget(self, action: #selector(presentMainVC), for: .touchUpInside)
        
        
        
        return button
    }()
}


//MARK: - View Cycle

extension GreetViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupUI()
    }
}


//MARK: - Setup UI

extension GreetViewController {
    
    func setupUI() {
        view.addSubview(questionLabel)
        view.addSubview(textField)
        view.addSubview(enrolledButton)
        constraints()
        
    }
    
    func constraints() {
        
        questionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(80)
            make.width.equalTo(300)
        }
        
        
        enrolledButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
}


//MARK: - Transition Effect
extension GreetViewController {
    @objc func presentMainVC() {
        let fadeTransitioningDelegate = FadeTransitioningDelegate()
        let mainVC = MainViewController()
        let navVC = UINavigationController(rootViewController: mainVC)
        navVC.modalPresentationStyle = .fullScreen
        navVC.transitioningDelegate = fadeTransitioningDelegate
        self.present(navVC, animated: true) {
        }
    }
}
