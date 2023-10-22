import UIKit

class MainModuleBuilder {
    
    static func build() -> UIViewController {
        
        let presenter = MainPresenter()
        let mainViewController = MainViewController(presenter: presenter)

        presenter.attachedView(mainViewController)
        mainViewController.tabBarItem.image = UIImage.galerySelected
        mainViewController.tabBarItem.selectedImage = UIImage.galery
        mainViewController.tabBarItem.title = Strings.tabBarGallery
    
        return mainViewController
    }
}
