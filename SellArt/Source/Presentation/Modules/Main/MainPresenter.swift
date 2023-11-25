import UIKit

protocol MainPresenterProtocol {
    func loadPaintings(completion: @escaping ([Paintings]) -> Void)
    func formatPrice(_ price: Double) -> String
    func didSelectPainting(at index: Int)
    func likeButtonTapped(at indexPath: IndexPath)
    func cartButtonTapped(at indexPath: IndexPath)
    func toggleFavorite(for paintingId: Int)
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

extension MainPresenter {
    private func saveFavorites() {
        // Сохранить id избранных картин
        let favoriteIds = paintings.filter { $0.isFavorite }.map { $0.id }
        UserDefaults.standard.set(favoriteIds, forKey: "favorites")
    }
}

extension MainPresenter {
    func toggleFavorite(for paintingId: Int) {
        guard let index = paintings.firstIndex(where: { $0.id == paintingId }) else { return }
        paintings[index].isFavorite.toggle()
        // Здесь может быть код для сохранения измененных данных, если это необходимо
    }
}
