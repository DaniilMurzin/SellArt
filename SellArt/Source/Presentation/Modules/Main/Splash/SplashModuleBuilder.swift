import UIKit

class SplashModuleBuilder {
    static func build() -> UIViewController & SplashViewProtocol {
        
        let presenter = SplashPresenter()
        let viewController = SplashViewController(presenter: presenter)
        
        viewController.presenter = presenter
        presenter.attachView(viewController)
        
        return viewController
    }
}
