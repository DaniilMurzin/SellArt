import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let mainViewController = MainModuleBuilder.build()
        let mainNavigationController = UINavigationController(
            rootViewController: mainViewController
        )
        let favoritesViewController = FavoritesModuleBuilder.build()
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [mainNavigationController, favoritesViewController]
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}
