import UIKit

protocol SplashPresenterProtocol {
    func attachView( _ view: SplashViewProtocol)
}

class SplashPresenter {
    
    // MARK: private properties
    private weak var view: SplashViewProtocol?
}

// MARK: extension SplashPresenter + SplashPresenterProtocol
extension SplashPresenter: SplashPresenterProtocol {
    
    func attachView(_ view: SplashViewProtocol) {
        self.view = view
    }
}
