import UIKit

protocol MainPresenterProtocol {
    func loadPaintings(completion: @escaping ([Paintings]) -> Void)
    func formatPrice(_ price: Double) -> String
}

class MainPresenter {
    
    weak private var view: MainViewProtocol?
    private var paintings: [Paintings] = []
    
    func attachedView( _ view: MainViewProtocol) {
        self.view = view
    }
    
    func fetchPaintings() -> [Paintings] {
        PaintingsModel.paintings
    }
    
    func formatPrice(_ price: Double) -> String {
        return String(format: "%.2f $", price)
    }
}

extension MainPresenter: MainPresenterProtocol {
    
    func loadPaintings(completion: @escaping ([Paintings]) -> Void) {
        let paintings = fetchPaintings()
        completion(paintings)
    }
}
