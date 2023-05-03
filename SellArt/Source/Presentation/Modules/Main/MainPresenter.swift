import UIKit

protocol MainPresenterProtocol {}

class MainPresenter {
    
    weak private var view: MainViewProtocol?
    
    func attachedView( _ view: MainViewProtocol) {
        self.view = view
    }
}

extension MainPresenter: MainPresenterProtocol {}
