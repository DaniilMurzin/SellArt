import UIKit

protocol FormPresenterProtocol {}

class FormPresenter {
    
    weak private var view: FormViewProtocol?
    
    // MARK: open methods
    func attachedView( _ view: FormViewProtocol) {
        self.view = view
    }
}

extension FormPresenter: FormPresenterProtocol {}
