import UIKit
import SnapKit

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
        view.addSubview(personalDataLabel)
        view.addSubview(sendFormButton)
        
        inputFieldsTextView.addArrangedSubview(nameTextField)
        inputFieldsTextView.addArrangedSubview(surnameTextField)
        inputFieldsTextView.addArrangedSubview(emailTextField)
        inputFieldsTextView.addArrangedSubview(phoneTextField)
        inputFieldsTextView.addArrangedSubview(addressTextField)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        inputFieldsTextView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalTo(sendFormButton)
        }
        
        personalDataLabel.snp.makeConstraints { make in
            make.top.equalTo(inputFieldsTextView.snp.bottom).offset(LocalConstants.personalDataLabelTopOffset)
            make.leading.trailing.equalToSuperview().inset(LocalConstants.horizontalInset)
        }
        
        sendFormButton.snp.makeConstraints { make in
            make.top.equalTo(personalDataLabel.snp.bottom).offset(LocalConstants.sendButtonTopOffset)
            make.leading.trailing.equalToSuperview().inset(LocalConstants.sendButtonHorizontalInset)
        }
    }
}
    // MARK: - extension MainViewController + CustomCellDelegate
extension FormViewController: FormViewProtocol {}

    // MARK: - Local Constants
private enum LocalConstants {
    static let inputFieldSpacing: CGFloat = 20
    static let personalDataLabelTopOffset: CGFloat = 140
    static let horizontalInset: CGFloat = 40
    static let sendButtonTopOffset: CGFloat = 15
    static let sendButtonHorizontalInset: CGFloat = 30
}
