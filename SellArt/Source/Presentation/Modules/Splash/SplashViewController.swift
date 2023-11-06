import UIKit

protocol SplashViewProtocol: AnyObject {}

class SplashViewController: UIViewController {
    
    // MARK: public properties
    private (set) var presenter: SplashPresenterProtocol
    
    // MARK: init
    init(presenter: SplashPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SplashViewController: SplashViewProtocol {}
