import UIKit

class PaintingCollectionViewCell: UICollectionViewCell {
    
    // MARK: eternal properties
    static let identifier = "PaintingCollectionViewCell"

    // MARK: private properties
    private var image: UIImage?
    private var heightImageConstraint: NSLayoutConstraint?

    private var favoriteButton = UserActionsButtons(type: .favorite)
    
    private var cartButton = UserActionsButtons(type: .cart)
    
    private let paintingImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let artNameLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.artNameFont
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
        
        view.axis  = .vertical
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: override methods
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        image = nil
        heightImageConstraint?.isActive = false
        heightImageConstraint = nil
    }

    // MARK: public methods
    func setupCell(with painting: Paintings, formattedPrice: String) {
        self.image = painting.image
        paintingImageView.image = painting.image
        artist.text = painting.artist
        artNameLabel.attributedText = painting.name.toStyledAttributedString(
            withStyle: .artName)
        price.text = formattedPrice

        layoutIfNeeded()
    }
    
    // MARK: private methods
    private func setupConstraints() {
        let image = image?.copy(newWidth: bounds.width)

        heightImageConstraint?.isActive = false
        heightImageConstraint = paintingImageView.heightAnchor.constraint(
            equalToConstant: image?.size.height ?? 0)

        guard let heightImageAnchor = heightImageConstraint else { return }

        NSLayoutConstraint.activate([
            
            // MARK: Painting
            paintingImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor),
            paintingImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor),

            heightImageAnchor,
            paintingImageView.widthAnchor.constraint(
                equalToConstant: bounds.width),
            paintingImageView.bottomAnchor.constraint(
                equalTo: buttonsStackView.topAnchor,
                constant: -LocalConstants.topInset),

            // MARK: Buttons
            buttonsStackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: LocalConstants.topInset),
            buttonsStackView.heightAnchor.constraint(
                equalToConstant: LocalConstants.buttonsHeight),
            
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

private extension UIImage {
    func copy(newWidth: CGFloat, retina: Bool = true) -> UIImage? {
        let multiplier = newWidth / size.width
        let newHeight = size.height * multiplier + 40
        let newSize = CGSize(width: newWidth,
                             height: newHeight)

        UIGraphicsBeginImageContextWithOptions(
            newSize,
            false,
            retina ? 0 : 1
        )
        defer { UIGraphicsEndImageContext() }

        self.draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
