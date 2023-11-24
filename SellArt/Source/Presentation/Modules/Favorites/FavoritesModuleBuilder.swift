import UIKit

class FavoritesModuleBuilder {
    
    static func build() -> UIViewController {
        let presenter = FavoritesPresenter()
        
        let favoritesViewController = FavoritesViewController(presenter: presenter)
        presenter.attachView(favoritesViewController)
        favoritesViewController.tabBarItem.image = UIImage.favoriteSelected
        favoritesViewController.tabBarItem.selectedImage = UIImage.favoriteUnselected
        favoritesViewController.tabBarItem.title = Strings.tabBarGallery
        
        return favoritesViewController
    }
}
