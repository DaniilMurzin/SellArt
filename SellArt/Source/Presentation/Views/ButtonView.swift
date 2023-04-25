import UIKit

class ButtonView: UIView {
    
    // MARK: private properties
    private lazy var button: UIButton = {
        let button = UIButton()
        let attributedTitle = Strings.buttonTitle.toStyledForButtonAttributedString()
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.tintColor = .buttonFontColor
        button.backgroundColor = .buttonEnableColor
        button.translatesAutoresizingMaskIntoConstraints =  false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: init
    init() {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: private methods
    private func setupView() {
        backgroundColor = UIColor.mainBackgroundColor
        addSubview(button)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    @objc private func buttonTapped() {
        print("Button tapped")
    }
}
