import UIKit

enum UserActionType {
    case favorite
    case cart
    case profile
    case share
    case close
}

class UserActionsButtons: UIButton {
    
    // MARK: private properties
    private var isFavoriteSelected = false
    private var isCartSelected = false
    
    // MARK: init
    init(type: UserActionType) {
        super.init(frame: .zero)
        
        setupButton(type: type)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: private methods
    private func setupButton(type: UserActionType ) {
        
        switch type {
            
        case .favorite:
            setImage(UIImage.favoriteUnselected,
                     for: .normal)
            addTarget(self,
                      action: #selector(favoriteButtonTapped),
                      for: .touchUpInside)
            
        case .cart:
            setImage(UIImage.cartUnselected,
                     for: .normal)
            addTarget(self,
                      action: #selector(cartButtonTapped),
                      for: .touchUpInside)
            
        case .profile:
            setImage(UIImage.profile,
                     for: .normal)
            
        case .share:
            setImage(UIImage.share,
                     for: .normal)
    
        case .close:
            setImage(UIImage.close,
                     for: .normal)
        }
    }

    @objc private func favoriteButtonTapped() {
        isFavoriteSelected.toggle()
        
        let image = isFavoriteSelected ? UIImage.favoriteSelected : UIImage.cartUnselected

        setImage(image,
                 for: .normal)
    }
    
    @objc private func cartButtonTapped() {
        isCartSelected.toggle()
        
        let image = isCartSelected ? UIImage.cartSelected : UIImage.cartUnselected
        
        setImage(image,
                 for: .normal)
    }
}
