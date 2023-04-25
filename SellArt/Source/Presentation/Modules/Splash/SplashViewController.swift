import UIKit

protocol SplashViewProtocol: AnyObject {
    func setButtonTitle (_ title: String)
}

class SplashViewController: UIViewController {
    
    // MARK: public properties
    var presenter: SplashPresenterProtocol
    
    // MARK: private properties
    private lazy var button = ButtonView(state: .submitForm )
    
    private enum LocalConstants {
        static let rightInset: CGFloat = -16
        static let leftInset: CGFloat = 16
        static let bottomInset: CGFloat = -25
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
        
        setupView()
        setupConstraints()
    }
    
    // MARK: private methods
    func setupView() {
        view.backgroundColor = UIColor.mainBackgroundColor
        view.addSubview(button)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: LocalConstants.leftInset),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: LocalConstants.rightInset),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: LocalConstants.bottomInset)
        ])
    }
}

extension SplashViewController: SplashViewProtocol {
    
    func setButtonTitle(_ title: String) {
    }
    
}
