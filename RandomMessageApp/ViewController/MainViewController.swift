
import UIKit
import SnapKit


//MARK: - Properties
class MainViewController: UIViewController {
    
    
    private lazy var floatingButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemPink
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "plus")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))
        button.configuration = config
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        button.addTarget(self, action: #selector(didTapFloatingButton), for: .touchUpInside)
        return button
    }()
    private let writeButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemPink
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "pencil")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))
        button.configuration = config
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        button.alpha = 0.0
        button.addTarget(self, action: #selector(writeButtonTapped), for: .touchUpInside)
        return button
    }()
    private var isActive: Bool = false {
        didSet {
            showActionButtons()
        }
    }
    private var animation: UIViewPropertyAnimator?
    
    
}



//MARK: - View Cycle

extension MainViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(x: view.frame.size.width - 60 - 8 - 20, y: view.frame.size.height - 60 - 8 - 40, width: 60, height: 60)
        writeButton.frame = CGRect(x: view.frame.size.width - 60 - 8 - 20, y: view.frame.size.height - 60 - 80 - 8 - 40, width: 60, height: 60)
    }
}


//MARK: - Setup UI

extension MainViewController {
    
    func setupUI() {
        view.addSubview(floatingButton)
        view.addSubview(writeButton)
        
        
        setupConstraints()
        
    }
    
}
//MARK: - Constraints
extension MainViewController {
    func setupConstraints() {
        
        floatingButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-40)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
    }
}

//MARK: - Button Action
extension MainViewController {
    
    @objc private func didTapFloatingButton() {
        isActive.toggle()
    }
    
    @objc private func writeButtonTapped() {
        let sendMessageVC = SendMessageViewController()
        self.navigationController?.pushViewController(sendMessageVC, animated: true)
    }

    private func showActionButtons() {
        popButtons()
        rotateFloatingButton()
    }
    
    private func popButtons() {
        if isActive {
            writeButton.layer.transform = CATransform3DMakeScale(0.4, 0.4, 1)
            UIView.animate(withDuration: 0.3, delay: 0.2, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.3, options: [.curveEaseInOut], animations: { [weak self] in
                guard let self = self else { return }
                self.writeButton.layer.transform = CATransform3DIdentity
                self.writeButton.alpha = 1.0
            })
        } else {
            UIView.animate(withDuration: 0.15, delay: 0.2, options: []) { [weak self] in
                guard let self = self else { return }
                self.writeButton.layer.transform = CATransform3DMakeScale(0.4, 0.4, 0.1)
                self.writeButton.alpha = 0.0
            }
        }
    }
    
    private func rotateFloatingButton() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        let fromValue = isActive ? 0 : CGFloat.pi / 4
        let toValue = isActive ? CGFloat.pi / 4 : 0
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = 0.3
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        floatingButton.layer.add(animation, forKey: nil)
    }

}
