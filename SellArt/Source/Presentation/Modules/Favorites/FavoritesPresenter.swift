import UIKit

protocol FavoritesPresenterProtocol {
    func loadPaintings(completion: @escaping ([Paintings]) -> Void)
    func formatPrice(_ price: Double) -> String
    func didSelectPainting(at index: Int)
    func likeButtonTapped(at indexPath: IndexPath)
    func cartButtonTapped(at indexPath: IndexPath)
}

class FavoritesPresenter {
    
    // MARK: private properties
    weak private var view: FavoritesViewProtocol?
    
    private var paintings: [Paintings] = PaintingsModel.paintings
    
    // MARK: open methods
    func attachView(_ view: FavoritesViewProtocol) {
        self.view = view
    }
}
// MARK: - FavoritesPresenter + FavoritesViewProtocol
extension FavoritesPresenter: FavoritesPresenterProtocol {
    
    func likeButtonTapped(at indexPath: IndexPath) {}
    
    func cartButtonTapped(at indexPath: IndexPath) {}
    
    func loadPaintings(completion: @escaping ([Paintings]) -> Void) {
    }
    
    func formatPrice(_ price: Double) -> String {
        return String(format: "%.2f $", price)
    }
    
    func didSelectPainting(at index: Int) {
        let painting = PaintingsModel.paintings[index]
        view?.navigateToPaintingDetails(with: painting)
    }
}
