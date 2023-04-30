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
    private var isFavoriteSelected: Bool = false
    private var isCartSelected: Bool = false
    
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
            setImage(UIImage(named: "Favorite Unselected"), for: .normal)
            addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
            
        case .cart:
            setImage(UIImage(named: "Cart Unselected"), for: .normal)
            addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
            
        case .profile:
            setImage(UIImage(named: "Profile"), for: .normal)
            
        case .share:
            setImage(UIImage(named: "Share"), for: .normal)
    
        case .close:
            setImage(UIImage(named: "Close Button"), for: .normal)
        
        }
    }

    @objc private func favoriteButtonTapped() {
        isFavoriteSelected.toggle()
        let imageName = isFavoriteSelected ? "Favorite Selected" : "Favorite Unselected"
        setImage(UIImage(named: imageName), for: .normal)
    }
    
    @objc private func cartButtonTapped() {
        isCartSelected.toggle()
        let imageName = isCartSelected ? "Cart Selected" : "Cart Unselected"
        setImage(UIImage(named: imageName), for: .normal)
    }
}
