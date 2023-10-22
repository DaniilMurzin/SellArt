import UIKit

protocol PaintingInfoPresenterProtocol {
    func formatPrice(_ price: Double) -> String
    func likeButtonTapped()
    func cartButtonTapped()
}

class PaintingInfoPresenter {
    
    // MARK: properties
    weak private var view: PaintingInfoViewProtocol?
    
    var painting: Paintings
    
    // MARK: Init
    init(painting: Paintings) {
        self.painting = painting
    }
    
    // MARK: open methods
    func attachedView( _ view: PaintingInfoViewProtocol) {
        self.view = view
    }
}
// MARK: extension PaintingInfoPresenter + PaintingInfoPresenterProtocol
extension PaintingInfoPresenter: PaintingInfoPresenterProtocol {
    
    func likeButtonTapped() {}
    
    func cartButtonTapped() {}
    
    func formatPrice(_ price: Double) -> String {
        return String(format: "%.2f $", price)
    }
}
