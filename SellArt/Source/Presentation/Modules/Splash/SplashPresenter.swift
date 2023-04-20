import UIKit

protocol SplashPresenterProtocol {}

class SplashPresenter {
    
    // MARK: private properties
    private weak var view: SplashViewProtocol?
    
    func attachView(_ view: SplashViewProtocol) {
        self.view = view
    }
}
    // MARK: extension SplashPresenter + SplashPresenterProtocol
    extension SplashPresenter: SplashPresenterProtocol {}
