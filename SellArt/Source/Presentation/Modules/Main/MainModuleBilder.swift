import UIKit

class MainModuleBuilder {
    
    static func build() -> UITabBarController {
        
        let presenter = MainPresenter()
        let mainViewController = MainViewController(presenter: presenter)
        presenter.attachedView(mainViewController)
        
        mainViewController.tabBarItem.image = UIImage.galerySelected
        mainViewController.tabBarItem.selectedImage = UIImage.galery
        mainViewController.tabBarItem.title = "Gallery"
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [mainViewController]
        return tabBarController
    }
}
