import UIKit

enum TextFieldStyle {
    case email
    case name
    case surname
    case phoneNumber
    case address
}

class CustomTextField: UITextField {
    
    // MARK: init
    init(style: TextFieldStyle) {
        super.init(frame: .zero)
        setupTextField(style: style)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: private methods
    private func setupTextField(style: TextFieldStyle) {
        
        self.backgroundColor = .mainBackgroundColor
        self.font = UIFont.regularSettingsFont
        self.tintColor = .buttonFontColor
        
        switch style {
        case .email:
            self.keyboardType = .emailAddress
            self.textContentType = .emailAddress
            self.placeholder = Strings.emailTextField
            
        case .name:
            self.keyboardType = .default
            self.textContentType = .name
            self.placeholder = Strings.nameTextField
            
        case .surname:
            self.keyboardType = .default
            self.textContentType = .familyName
            self.placeholder = Strings.surnameTextField
            
        case .phoneNumber:
            self.keyboardType = .phonePad
            self.textContentType = .telephoneNumber
            self.placeholder = Strings.phoneNumber
            
        case .address:
            self.keyboardType = .default
            self.textContentType = .fullStreetAddress
            self.placeholder = Strings.addressTextField
        }
    }
}
