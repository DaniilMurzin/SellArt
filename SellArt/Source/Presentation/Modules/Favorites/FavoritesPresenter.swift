import UIKit

protocol FavoritesPresenterProtocol {
    func loadPaintings(completion: @escaping ([Paintings]) -> Void)
    func formatPrice(_ price: Double) -> String
    func didSelectPainting(at index: Int)
    func likeButtonTapped(at indexPath: IndexPath)
    func cartButtonTapped(at indexPath: IndexPath)
    func fetchFavorites() -> [Paintings]
    func toggleFavorite(for paintingId: Int)
    func attachView(_ view: FavoritesViewProtocol)
}

class FavoritesPresenter {
    
    // MARK: private properties
     weak private var view: FavoritesViewProtocol?
    
    private var paintings: [Paintings] = PaintingsModel.paintings
    
    // MARK: open methods
    func attachView(_ view: FavoritesViewProtocol) {
          self.view = view
      }
    
    func fetchPaintings() -> [Paintings] {
        PaintingsModel.paintings
    }
}

// MARK: - FavoritesPresenter + FavoritesViewProtocol
extension FavoritesPresenter: FavoritesPresenterProtocol {
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

extension FavoritesPresenter {
    func toggleFavorite(for paintingId: Int) {
        // Переключение состояния избранного для картины и сохранение изменений
        guard let index = paintings.firstIndex(where: { $0.id == paintingId }) else { return }
        paintings[index].isFavorite.toggle()
        saveFavorites()
    }

    private func saveFavorites() {
        // Сохранение избранных картин в UserDefaults
        // Сохраните состояние избранных картин
               let favoriteIds = paintings.filter { $0.isFavorite }.map { $0.id }
               UserDefaults.standard.set(favoriteIds, forKey: "favorites")
    }

    private func loadFavorites() {
        // Загрузка избранных картин из UserDefaults
        let favoriteIds = UserDefaults.standard.array(forKey: "favorites") as? [Int] ?? []
        paintings = paintings.filter { favoriteIds.contains($0.id) }
        }
    
    func fetchFavorites() -> [Paintings] {
        // Получение списка избранных картин
        return paintings

    }
}
