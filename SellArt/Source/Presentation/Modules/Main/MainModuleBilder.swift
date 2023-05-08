import UIKit

class MainModuleBuilder {
    
    static func build() -> UIViewController & MainViewProtocol {
        
        let presenter = MainPresenter()
        let viewController = MainViewController(presenter: presenter)
        
        viewController.presenter = presenter
        presenter.attachedView(viewController)
        
        return viewController 
    }
}
