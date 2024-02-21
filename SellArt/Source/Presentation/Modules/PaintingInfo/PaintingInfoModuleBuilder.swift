import UIKit

class PaintingInfoModuleBuilder {
    static func build(with painting: Paintings) -> UIViewController {
        
        let presenter = PaintingInfoPresenter(painting: painting)
        
        let paintingInfoViewController = PaintingInfoViewController(
            presenter: presenter,
            painting: painting
        )
        
        presenter.attachedView(paintingInfoViewController)
        
        return paintingInfoViewController
    }
}
