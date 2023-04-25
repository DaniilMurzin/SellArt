import UIKit

protocol SplashViewProtocol: AnyObject {
    func setButtonTitle (_ title: String)
}

class SplashViewController: UIViewController {
    
    // MARK: public properties
    var presenter: SplashPresenterProtocol
    
    // MARK: private properties
    private lazy var  button: ButtonView = {
        let btn = ButtonView()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    private enum LocalConstants {
        static let buttonWidth: CGFloat = 250
    }
    
    // MARK: init
    init(presenter: SplashPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: override methods
    override func viewDidLoad () {
        super.viewDidLoad()
        
        view.addSubview(button)
        setupView()
        setupConstraints()
    }
    
    // MARK: private methods
    func setupView() {
        view.backgroundColor = UIColor.mainBackgroundColor
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -52)
        ])
    }
    
}

extension SplashViewController: SplashViewProtocol {
    
    func setButtonTitle(_ title: String) {
    }
    
}
