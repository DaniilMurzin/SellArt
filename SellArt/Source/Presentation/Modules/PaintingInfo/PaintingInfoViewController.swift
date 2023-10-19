import UIKit

protocol PaintingInfoViewProtocol: AnyObject {}

class PaintingInfoViewController: UIViewController {
    
    // MARK: - Private Properties
    private(set) var presenter: PaintingInfoPresenterProtocol
    
    private var painting: Paintings
    
    private let buyButton = СustomButton(
        state: .purchase)
    private let favoriteButton = UserActionsButtons(
        type: .favorite)
    private let cartButton = UserActionsButtons(
        type: .cart)
    private let shareButton = UserActionsButtons(
        type: .share)
    private let separator =  Separator()
    private let separator2 = Separator()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .mainBackgroundColor
        
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .mainBackgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = painting.image
        
        return iv
    }()
    
    private lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = painting.artist
        label.font = UIFont.artNameFont
        label.textColor = UIColor.mainFontColor
        
        return label
    }()
    
    private lazy var artistLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = painting.name
        label.font = UIFont.regularBaseFont
        label.textColor = UIColor.mainFontColor
        
        return label
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = painting.city
        label.font = UIFont.regularBaseFont
        label.textColor = UIColor.mainFontColor
        
        return label
    }()
    
    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Views \(painting.view)"
        label.font = UIFont.regularBaseFont
        label.textColor = UIColor.mainFontColor
        
        return label
    }()
        
    private lazy var paintingTypeLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.regularBaseFont
        label.textColor = UIColor.mainFontColor
        label.text = painting.type
        
        return label
    }()

    private lazy var materialLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.regularBaseFont
        label.textColor = UIColor.mainFontColor
        label.text = painting.material
        
        return label
    }()

    private lazy var dimensionsLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.regularBaseFont
        label.textColor = UIColor.mainFontColor
        label.text = painting.dimensions
        
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.regularBaseFont
        label.textColor = UIColor.mainFontColor
        label.text = presenter.formatPrice(painting.price)
        
        return label
    }()
    
    // MARK: StackViews properties
    private lazy var buttonsStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis  = NSLayoutConstraint.Axis.horizontal
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addArrangedSubview(favoriteButton)
        view.addArrangedSubview(shareButton)
        view.addArrangedSubview(cartButton)
        
        return view
    }()
    
    private lazy var topLabelsStackView: UIStackView = {
        let view = UIStackView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 5
        view.addArrangedSubview(artistNameLabel)
        view.addArrangedSubview(artistLabel)
        view.addArrangedSubview(locationLabel)
        
        return view
    }()
    
    private lazy var paintingDetailsStackView: UIStackView = {
        let view = UIStackView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 5
        view.addArrangedSubview(paintingTypeLabel)
        view.addArrangedSubview(materialLabel)
        view.addArrangedSubview(dimensionsLabel)
        view.addArrangedSubview(priceLabel)
        
        return view
    }()
    
    // MARK: - Init
    init(presenter: PaintingInfoPresenterProtocol, painting: Paintings) {
        self.presenter = presenter
        self.painting = painting
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    private func setupView() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(imageView)
        contentView.addSubview(topLabelsStackView)
        contentView.addSubview(buttonsStackView)
        contentView.addSubview(viewsLabel)
        contentView.addSubview(separator)
        contentView.addSubview(paintingDetailsStackView)
        contentView.addSubview(separator2)
        contentView.addSubview(buyButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(
                equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(
                equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(
                equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(
                equalTo: scrollView.widthAnchor),
            
            imageView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: LocalConstants.imageViewTop),
            imageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: LocalConstants.imageViewLeading),
            imageView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: LocalConstants.imageViewTrailing),
            imageView.heightAnchor.constraint(
                equalToConstant: LocalConstants.imageViewHeight),
            
            topLabelsStackView.topAnchor.constraint(
                equalTo: imageView.bottomAnchor,
                constant: LocalConstants.topLabelsStackViewTop),
            topLabelsStackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: LocalConstants.topLabelsStackViewLeading),
            
            buttonsStackView.topAnchor.constraint(
                equalTo: locationLabel.bottomAnchor,
                constant: LocalConstants.buttonsStackViewTop),
            buttonsStackView.leadingAnchor.constraint(
                equalTo: artistNameLabel.leadingAnchor),
            
            viewsLabel.topAnchor.constraint(
                equalTo: buttonsStackView.topAnchor,
                constant: LocalConstants.viewsLabelTop),
            viewsLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: LocalConstants.viewsLabelTrailing),
            viewsLabel.bottomAnchor.constraint(
                equalTo: buttonsStackView.bottomAnchor),
            
            separator.topAnchor.constraint(
                equalTo: viewsLabel.bottomAnchor,
                constant: LocalConstants.separatorTop),
            separator.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor),
            separator.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor),
            
            paintingDetailsStackView.topAnchor.constraint(
                equalTo: separator.bottomAnchor,
                constant: LocalConstants.paintingDetailsStackViewTop),
            paintingDetailsStackView.leadingAnchor.constraint(
                equalTo: buttonsStackView.leadingAnchor),
            
            separator2.topAnchor.constraint(
                equalTo: paintingDetailsStackView.bottomAnchor,
                constant: LocalConstants.separator2Top),
            separator2.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor),
            separator2.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor),

            buyButton.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: LocalConstants.buyButtonLeading),
            buyButton.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: LocalConstants.buyButtonTrailing),
            buyButton.topAnchor.constraint(
                equalTo: separator2.bottomAnchor,
                constant: LocalConstants.buyButtonTop),
            buyButton.heightAnchor.constraint(
                equalToConstant: LocalConstants.buyButtonHeight),
            buyButton.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: LocalConstants.buyButtonBottom)
        ])
    }
}
    // MARK: LocalConstants
    private enum LocalConstants {
        
        static let imageViewTop: CGFloat  = 10
        static let imageViewLeading: CGFloat = 10
        static let imageViewTrailing: CGFloat = -10
        static let imageViewHeight: CGFloat = 300
        
        static let topLabelsStackViewTop: CGFloat = 30
        static let topLabelsStackViewLeading: CGFloat = 20
        
        static let buttonsStackViewTop: CGFloat = 10
        
        static let viewsLabelTop: CGFloat = 10
        static let viewsLabelTrailing: CGFloat = -10
        
        static let separatorTop: CGFloat = 15
        
        static let paintingDetailsStackViewTop: CGFloat = 10
        
        static let separator2Top: CGFloat = 15
        
        static let buyButtonLeading: CGFloat = 20
        static let buyButtonTrailing: CGFloat = -20
        static let buyButtonTop: CGFloat = 20
        static let buyButtonHeight: CGFloat = 50
        static let buyButtonBottom: CGFloat = -20
     }

    // MARK: extension PaintingInfoViewController + PaintingInfoViewProtocol
extension PaintingInfoViewController: PaintingInfoViewProtocol {
    
}
