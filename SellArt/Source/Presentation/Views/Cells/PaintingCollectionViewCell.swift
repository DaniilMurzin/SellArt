import UIKit

protocol CustomCellDelegate: AnyObject {
    func likeButtonTapped(at indexPath: IndexPath)
    func cartButtonTapped(at indexPath: IndexPath)
}

class PaintingCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: CustomCellDelegate?
    
    var indexPath: IndexPath?
    
    // MARK: - private properties
    private var image: UIImage?
    
    private var heightImageConstraint: NSLayoutConstraint?
    
    private let favoriteButton = UserActionsButtons(type: .favorite)
    private let cartButton = UserActionsButtons(type: .cart)
    
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
    private lazy var artistArtPriceStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis  = .vertical
        view.spacing = LocalConstants.DescriptionStackViewSpacing
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addArrangedSubview(artist)
        view.addArrangedSubview(artNameLabel)
        view.addArrangedSubview(price)
        return view
    }()
    
    private lazy var  buttonsStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis  = NSLayoutConstraint.Axis.horizontal
        view.spacing = LocalConstants.buttonsStackViewSpacing
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addArrangedSubview(favoriteButton)
        view.addArrangedSubview(cartButton)
        return view
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(buttonsStackView)
        contentView.addSubview(artistArtPriceStackView)
        contentView.addSubview(paintingImageView)
        
        favoriteButton.addTarget(
            self,
            action: #selector(likeButtonAction),
            for: .touchUpInside
        )
            cartButton.addTarget(
                self,
                action: #selector(cartButtonAction),
                for: .touchUpInside
            )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - override methods
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
    
    // MARK: - public methods
    func setupCell(with painting: Paintings,
                   formattedPrice: String) {
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
            
            buttonsStackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: LocalConstants.topInset),
            buttonsStackView.heightAnchor.constraint(
                equalToConstant: LocalConstants.buttonsHeight),
            
            artistArtPriceStackView.topAnchor.constraint(
                equalTo: buttonsStackView.bottomAnchor,
                constant: LocalConstants.topInset),
            artistArtPriceStackView.leadingAnchor.constraint(
                equalTo: buttonsStackView.leadingAnchor)
        ])
    }
    
    // MARK: - @objc methods
    @objc func likeButtonAction() {
        if let indexPath = indexPath {
            delegate?.likeButtonTapped(at: indexPath)
        }
    }
    
    @objc func cartButtonAction() {
        if let indexPath = indexPath {
            delegate?.cartButtonTapped(at: indexPath)
        }
    }
}

private enum LocalConstants {
    
    static let buttonsHeight: CGFloat = 20
    
    static let topInset: CGFloat = 10
    
    static let buttonsStackViewSpacing: CGFloat = 20
    
    static let DescriptionStackViewSpacing: CGFloat = 5
}

private extension UIImage {
    func copy(
        newWidth: CGFloat,
        retina: Bool = true
    ) -> UIImage? {
        
        let multiplier = newWidth / size.width
        let newHeight = size.height * multiplier + 40
        let newSize = CGSize(
            width: newWidth,
            height: newHeight
        )
        
        UIGraphicsBeginImageContextWithOptions(
            newSize,
            false,
            retina ? 0 : 1
        )
        defer { UIGraphicsEndImageContext() }
        
        self.draw(
            in: CGRect(
                origin: .zero,
                size: newSize
            )
        )
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
