import UIKit

protocol SplashViewProtocol: AnyObject {}

class SplashViewController: UIViewController {
    
    // MARK: public properties
    var presenter: SplashPresenterProtocol
    
    // MARK: private properties
    private let button = СustomButton(state: .submitForm )
 
    private let emailTextField = CustomTextField(style: .email)
    
    private let nameTextField = CustomTextField(style: .name)
    
    private let surnameTextField = CustomTextField(style: .surname)
    
    private let phoneNumberTextField = CustomTextField(style: .phoneNumber)
    
    private let addressTextField = CustomTextField(style: .address)
    
    private let stackView: UIStackView = {
           let stackView = UIStackView()
           stackView.axis = .vertical
           stackView.spacing = 10
           stackView.translatesAutoresizingMaskIntoConstraints = false
           return stackView
       }()
    
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
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(surnameTextField)
        stackView.addArrangedSubview(phoneNumberTextField)
        stackView.addArrangedSubview(addressTextField)
        
        view.addSubview(button)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: button.trailingAnchor),
            
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: LocalConstants.leftInset),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: LocalConstants.rightInset),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: LocalConstants.bottomInset)
        ])
    }
}

extension SplashViewController: SplashViewProtocol {}

private enum LocalConstants {
    static let rightInset: CGFloat = -16
    static let leftInset: CGFloat = 16
    static let bottomInset: CGFloat = -25
}
