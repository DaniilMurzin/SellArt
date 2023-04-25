import UIKit

enum ButtonViewState {
    case submitForm
    case registration
    case purchase
}

class ButtonView: UIButton {
    
    // MARK: init
    init(state: ButtonViewState) {
        super.init(frame: .zero)
        
        setupView(state: state)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        addTarget(self, action: #selector(buttonTouchUpOutside), for: .touchUpOutside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: private methods
    private func setupView(state: ButtonViewState) {
        
        let attributedTitle: NSAttributedString
        
        switch state {
        case .submitForm:
            attributedTitle = Strings.submitFormButtonTitle.toStyledForButtonAttributedString()
        case .registration:
            attributedTitle = Strings.registrationButtonTitle.toStyledForButtonAttributedString()
        case .purchase:
            attributedTitle = Strings.purchaseButtonTitle.toStyledForButtonAttributedString()
        }
        
        backgroundColor = UIColor.buttonEnableColor
        
        setAttributedTitle(attributedTitle, for: .normal)
        tintColor = .buttonFontColor
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    @objc private func buttonTapped() {
        backgroundColor = UIColor.buttonEnableColor
    }
    
    @objc private func buttonTouchDown() {
        // Обработка нажатия вниз на кнопку
        backgroundColor = UIColor.buttonDisabledColor
    }
    
    @objc private func buttonTouchUpOutside() {
        // Обработка отпускания кнопки вне ее границ
        backgroundColor = UIColor.buttonEnableColor
    }
}
