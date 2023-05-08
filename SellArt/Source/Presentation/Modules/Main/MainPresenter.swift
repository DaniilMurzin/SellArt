import UIKit

protocol MainPresenterProtocol {
    func loadPaintings()
}

class MainPresenter {
    
    weak private var view: MainViewProtocol?
    private var paintings: [Paintings] = []
    
    func attachedView( _ view: MainViewProtocol) {
        self.view = view
    }
}

extension MainPresenter: MainPresenterProtocol {
    
    func loadPaintings() {
        paintings = PaintingsModel.paintings
        view?.updatePaintings(paintings)
    }
}
