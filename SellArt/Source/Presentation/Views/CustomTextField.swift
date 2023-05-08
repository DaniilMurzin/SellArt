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
        
        backgroundColor = .mainBackgroundColor
        font = UIFont.regularSettingsFont
        tintColor = .mainFontColor
        
        switch style {
            
        case .email:
            keyboardType = .emailAddress
            textContentType = .emailAddress
            placeholder = Strings.emailTextField
            
        case .name:
            keyboardType = .default
            textContentType = .name
            placeholder = Strings.nameTextField
            
        case .surname:
            keyboardType = .default
            textContentType = .familyName
            placeholder = Strings.surnameTextField
            
        case .phoneNumber:
            keyboardType = .phonePad
            textContentType = .telephoneNumber
            placeholder = Strings.phoneNumber
            
        case .address:
            keyboardType = .default
            textContentType = .fullStreetAddress
            placeholder = Strings.addressTextField
        }
    }
}
