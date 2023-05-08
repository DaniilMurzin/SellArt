import UIKit

class PaintingCollectionViewCell: UICollectionViewCell {
    
    // MARK: eternal properties
    static let identifier = "PaintingCollectionViewCell"
    
    // MARK: private properties
    private lazy var favoriteButton = UserActionsButtons(type: .favorite)
    
    private lazy var cartButton = UserActionsButtons(type: .cart)
    
    private let paintingImageView: UIImageView = {
        let image = UIImageView()
        
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let artNameLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.artNameFont
        label.textColor = UIColor.mainFontColor
        label.textColor = UIColor.mainFontColor
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let artist: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.regularBaseFont
        label.textColor = UIColor.mainFontColor
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let price: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.priceFont
        label.textColor = .mainFontColor
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: StackViews properties
    private let  artistArtPriceStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis  = NSLayoutConstraint.Axis.vertical
        view.spacing = LocalConstants.DescriptionStackViewSpacing
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var  buttonsStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis  = NSLayoutConstraint.Axis.horizontal
        view.spacing = LocalConstants.buttonsStackViewSpacing
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
     
        contentView.addSubview(buttonsStackView)
        
        buttonsStackView.addArrangedSubview(favoriteButton)
        buttonsStackView.addArrangedSubview(cartButton)
        
        contentView.addSubview(artistArtPriceStackView)
        
        artistArtPriceStackView.addArrangedSubview(artist)
        artistArtPriceStackView.addArrangedSubview(artNameLabel)
        artistArtPriceStackView.addArrangedSubview(price)
        
        contentView.addSubview(paintingImageView)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: public methods
    func setupCell(with painting: Paintings) {
        
        paintingImageView.image = painting.image
        artist.text = painting.artist
        artNameLabel.attributedText = painting.name.toStyledAttributedString(
            withStyle: .artName)
        
        price.text = String(
            format: "%.2f $",
            painting.price)
    }
    
    // MARK: private methods
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // MARK: Painting
            paintingImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor),
            
            paintingImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor),
            
            paintingImageView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor),
            
            paintingImageView.bottomAnchor.constraint(
                equalTo: buttonsStackView.topAnchor,
                constant: -LocalConstants.topInset),
            
            // MARK: Buttons
            buttonsStackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: LocalConstants.topInset),
            
            buttonsStackView.heightAnchor.constraint(equalToConstant: LocalConstants.buttonsHeight),
            
            // MARK: Picture description
            artistArtPriceStackView.topAnchor.constraint(
                equalTo: buttonsStackView.bottomAnchor,
                constant: LocalConstants.topInset),
            
            artistArtPriceStackView.leadingAnchor.constraint(
                equalTo: buttonsStackView.leadingAnchor)
        ])
    }
}

private enum LocalConstants {
    
    static let buttonsHeight: CGFloat = 20
    
    static let topInset: CGFloat = 10
    
    static let buttonsStackViewSpacing: CGFloat = 15
    
    static let DescriptionStackViewSpacing: CGFloat = 5
}
