import UIKit

enum TextFieldStyle {
    case email
    case name
    case surname
    case phoneNumber
    case address
}

class CustomTextField: UITextField {
    
    // MARK: - init
    init(style: TextFieldStyle) {
        super.init(frame: .zero)
        
        setupTextField(style: style)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -private methods
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
        
        backgroundColor = .mainBackgroundColor
        font = UIFont.regularSettingsFont
        tintColor = .mainFontColor
        translatesAutoresizingMaskIntoConstraints = false
        self.attributedPlaceholder = NSAttributedString(
              string: Strings.nameTextField,
              attributes: [
                  .foregroundColor: UIColor.mainFontColor,
                  .font: UIFont.regularSettingsFont!
              ]
        )
        
        switch style {
            
        case .email:
            keyboardType = .emailAddress
            textContentType = .emailAddress
            self.attributedPlaceholder = makeAttributedPlaceholder(
                for: Strings.emailTextField
            )
            
        case .name:
            keyboardType = .default
            textContentType = .name
            self.attributedPlaceholder = makeAttributedPlaceholder(
                for: Strings.nameTextField
            )
        case .surname:
            keyboardType = .default
            textContentType = .familyName
            self.attributedPlaceholder = makeAttributedPlaceholder(
                for: Strings.surnameTextField
            )
            
        case .phoneNumber:
            keyboardType = .phonePad
            textContentType = .telephoneNumber
            self.attributedPlaceholder = makeAttributedPlaceholder(
                for: Strings.phoneNumber
            )
        case .address:
            keyboardType = .default
            textContentType = .fullStreetAddress
            self.attributedPlaceholder = makeAttributedPlaceholder(
                for: Strings.addressTextField
            )
        }
    }
}
