import UIKit

protocol FormViewProtocol: AnyObject {}

class FormViewController: UIViewController {
    
    // MARK: - Private Properties
    private (set) var presenter: FormPresenterProtocol
    
    private var sendFormButton = СustomButton(state: .submitForm)
    
    private var nameTextField = CustomTextField(style: .name)
    private var surnameTextField = CustomTextField(style: .surname)
    private var emailTextField = CustomTextField(style: .email)
    private var phoneTextField = CustomTextField(style: .phoneNumber)
    private var addressTextField = CustomTextField(style: .address)
    
    private var personalDataLabel: UILabel = {
       let label = UILabel()
        label.text = Strings.personalDataAgreement
        label.font = UIFont.regularSettingsFont
        label.textColor = UIColor.mainFontColor
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var inputFieldsTextView: UIStackView = {
        let view = UIStackView()
        view.axis  = NSLayoutConstraint.Axis.vertical
        view.spacing = 30
        return view
    }()
    
    // MARK: - init
    init(presenter: FormPresenterProtocol) {
        self.presenter = presenter
        super.init(
            nibName: nil,
            bundle: nil
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - override methods
    override func viewDidLoad () {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
    }

    // MARK: - private methods
    private func setupView() {
        
        view.backgroundColor = .mainBackgroundColor
        title = Strings.form
        view.addSubview(inputFieldsTextView)
        
        personalDataLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(personalDataLabel)
        view.addSubview(sendFormButton)
        
        inputFieldsTextView.translatesAutoresizingMaskIntoConstraints = false
        inputFieldsTextView.addArrangedSubview(nameTextField)
        inputFieldsTextView.addArrangedSubview(surnameTextField)
        inputFieldsTextView.addArrangedSubview(emailTextField)
        inputFieldsTextView.addArrangedSubview(phoneTextField)
        inputFieldsTextView.addArrangedSubview(addressTextField)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            inputFieldsTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputFieldsTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            inputFieldsTextView.leadingAnchor.constraint(equalTo: sendFormButton.leadingAnchor),
            inputFieldsTextView.trailingAnchor.constraint(equalTo: sendFormButton.trailingAnchor),
            
            personalDataLabel.topAnchor.constraint(equalTo: inputFieldsTextView.bottomAnchor, constant: 140),
            personalDataLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            personalDataLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            sendFormButton.topAnchor.constraint(equalTo: personalDataLabel.bottomAnchor, constant: 15),
            sendFormButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            sendFormButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
}
    // MARK: - extension MainViewController + CustomCellDelegate
extension FormViewController: FormViewProtocol {}
