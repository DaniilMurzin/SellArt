import UIKit

enum ButtonViewState {
    case submitForm
    case registration
    case purchase
}

class СustomButton: UIButton {
    
    // MARK: init
    init(state: ButtonViewState) {
        super.init(frame: .zero)
        
        setupView(style: state)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: private methods
    private func setupView(style: ButtonViewState) {
        
        let attributedTitle: NSAttributedString
        
        switch style {
        case .submitForm:
            attributedTitle =
            Strings.submitFormButtonTitle.toStyledAttributedString(
                withStyle: .buttons
            )
        case .registration:
            attributedTitle =
            Strings.registrationButtonTitle.toStyledAttributedString(
                withStyle: .buttons
            )
        case .purchase:
            attributedTitle =
            Strings.purchaseButtonTitle.toStyledAttributedString(
                withStyle: .buttons
            )
        }
        
        backgroundColor = UIColor.buttonEnableColor
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        
        setAttributedTitle(attributedTitle, for: .normal)
        tintColor = .mainFontColor
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addTarget(
            self,
            action: #selector(buttonTapped),
            for: .touchUpInside
        )
        addTarget(
            self,
            action: #selector(buttonTouchDown),
            for: .touchDown
        )
        addTarget(
            self,
            action: #selector(buttonTouchUpOutside),
            for: .touchUpOutside
        )
    }
    
    @objc private func buttonTapped() {
        backgroundColor = UIColor.buttonEnableColor
    }
    
    @objc private func buttonTouchDown() {
        backgroundColor = UIColor.buttonDisabledColor
    }
    
    @objc private func buttonTouchUpOutside() {
        backgroundColor = UIColor.buttonEnableColor
    }
}
