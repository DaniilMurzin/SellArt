import UIKit

protocol MainPresenterProtocol {
    func loadPaintings(completion: @escaping ([Paintings]) -> Void)
    func formatPrice(_ price: Double) -> String
    func didSelectPainting(at index: Int)
    func likeButtonTapped(at indexPath: IndexPath)
    func cartButtonTapped(at indexPath: IndexPath)
}

class MainPresenter {

    // MARK: private properties
    weak private var view: MainViewProtocol?
    private var paintings: [Paintings] = []
    
    // MARK: open methods
    func attachedView( _ view: MainViewProtocol) {
        self.view = view
    }
    
    func fetchPaintings() -> [Paintings] {
        PaintingsModel.paintings
    }
    
}
    // MARK: extension MainPresenter + MainPresenterProtocol
extension MainPresenter: MainPresenterProtocol {
    
    func likeButtonTapped(at indexPath: IndexPath) {}
    
    func cartButtonTapped(at indexPath: IndexPath) {}
    
    func loadPaintings(completion: @escaping ([Paintings]) -> Void) {
        let paintings = fetchPaintings()
        completion(paintings)
    }
    
    func formatPrice(_ price: Double) -> String {
        return String(format: "%.2f $", price)
    }
    
    func didSelectPainting(at index: Int) {
        let painting = PaintingsModel.paintings[index]
        view?.navigateToPaintingDetails(with: painting)
    }
}
