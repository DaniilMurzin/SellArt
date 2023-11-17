import UIKit

enum TextFieldStyle {
    case email
    case name
    case surname
    case phoneNumber
    case address
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .email:
            return .emailAddress
        case .phoneNumber:
            return .phonePad
        default:
            return .default
        }
    }
    
    var textContentType: UITextContentType {
        switch self {
        case .email:
            return .emailAddress
        case .name:
            return .name
        case .surname:
            return .familyName
        case .phoneNumber:
            return .telephoneNumber
        case .address:
            return .fullStreetAddress
        }
    }
    
    var attributedPlaceholder: String {
        switch self {
        case .email:
            return Strings.emailTextField
        case .name:
            return Strings.nameTextField
        case .surname:
            return Strings.surnameTextField
        case .phoneNumber:
            return Strings.phoneNumber
        case .address:
            return Strings.addressTextField
        }
    }
}

class CustomTextField: UITextField {
    
    // MARK: - init
    init(style: TextFieldStyle) {
        super.init(frame: .zero)
        
        backgroundColor = .mainBackgroundColor
        font = UIFont.regularSettingsFont
        tintColor = .mainFontColor
        translatesAutoresizingMaskIntoConstraints = false
        
        setupTextField(style: style)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private methods
    private func makeAttributedPlaceholder(for text: String) -> NSAttributedString {
        return NSAttributedString(
            string: text,
            attributes: [
                .foregroundColor: UIColor.mainFontColor.withAlphaComponent(0.5),
                .font: UIFont.regularSettingsFont!
            ]
        )
    }
    
    private func setupTextField(style: TextFieldStyle) {
        attributedPlaceholder = NSAttributedString(
              string: Strings.nameTextField,
              attributes: [
                  .foregroundColor: UIColor.mainFontColor,
                  .font: UIFont.regularSettingsFont!
              ]
        )
        
        keyboardType = style.keyboardType
        textContentType = style.textContentType
        attributedPlaceholder = makeAttributedPlaceholder(for: style.attributedPlaceholder)
    }
}
