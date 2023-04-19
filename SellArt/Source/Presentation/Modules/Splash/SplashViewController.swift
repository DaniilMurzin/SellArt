import UIKit

protocol SplashViewProtocol: AnyObject {
    func setButtonTitle (_ title: String)
}

class SplashViewController: UIViewController {
    
    // MARK: public properties
    var presenter: SplashPresenterProtocol

    // MARK: private properties
    private enum LocalConstants {
        static let buttonWidth: CGFloat = 250
    }
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Strings.buttonTitle, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemOrange
        button.translatesAutoresizingMaskIntoConstraints =  false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: init
    init(presenter: SplashPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(button)
        setupView()
        setupConstraints()
        
        presenter.attachView(self) // это здесь нужно?
    }
    
    //MARK: private methods
    func setupView(){
        view.backgroundColor = .cyan
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: LocalConstants.buttonWidth)
        ])
    }
    
    @objc private func buttonTapped(){
        print("Button taped")
    }
    
    
}
extension SplashViewController: SplashViewProtocol {
    func setButtonTitle(_ title: String) {
    }

}
