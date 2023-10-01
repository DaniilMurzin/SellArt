import UIKit

protocol MainPresenterProtocol {
    func loadPaintings(completion: @escaping ([Paintings]) -> Void)
}

class MainPresenter {
    
    weak private var view: MainViewProtocol?
    private var paintings: [Paintings] = []
    
    func attachedView( _ view: MainViewProtocol) {
        self.view = view
    }
}

extension MainPresenter: MainPresenterProtocol {
    
    func loadPaintings(completion: @escaping ([Paintings]) -> Void) {
        let paintings = PaintingsModel.paintings
        completion(paintings)
    }
}
