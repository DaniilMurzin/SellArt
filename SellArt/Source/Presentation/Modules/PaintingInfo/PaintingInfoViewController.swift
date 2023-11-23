import UIKit
import SnapKit

protocol PaintingInfoViewProtocol: AnyObject {
    func navigateToFormViewController()
}

class PaintingInfoViewController: UIViewController {
    
    // MARK: - Private Properties
    private(set) var presenter: PaintingInfoPresenterProtocol
    
    private var painting: Paintings
    
    private let buyButton = СustomButton(state: .purchase)
    private let favoriteButton = UserActionsButtons(type: .favorite)
    private let cartButton = UserActionsButtons(type: .cart)
    private let shareButton = UserActionsButtons(type: .share)
    
    private let separator =  Separator()
    private let separator2 = Separator()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .mainBackgroundColor
        
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .mainBackgroundColor
        
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = painting.image
        
        return imageView
    }()
    
    private lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        
        label.text = painting.artist
        label.font = UIFont.artNameFont
        label.textColor = UIColor.mainFontColor
        
        return label
    }()
    
    private lazy var artistLabel: UILabel = {
        let label = UILabel()
        
        label.text = painting.name
        label.font = UIFont.regularBaseFont
        label.textColor = UIColor.mainFontColor
        
        return label
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        
        label.text = painting.city
        label.font = UIFont.regularBaseFont
        label.textColor = UIColor.mainFontColor
        
        return label
    }()
    
    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Views \(painting.view)"
        label.font = UIFont.regularBaseFont
        label.textColor = UIColor.mainFontColor
        
        return label
    }()
    
    private lazy var paintingTypeLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.regularBaseFont
        label.textColor = UIColor.mainFontColor
        label.text = painting.type
        
        return label
    }()
    
    private lazy var materialLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.regularBaseFont
        label.textColor = UIColor.mainFontColor
        label.text = painting.material
        
        return label
    }()
    
    private lazy var dimensionsLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.regularBaseFont
        label.textColor = UIColor.mainFontColor
        label.text = painting.dimensions
        
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.regularBaseFont
        label.textColor = UIColor.mainFontColor
        label.text = presenter.formatPrice(painting.price)
        
        return label
    }()
    
    // MARK: StackViews properties
    private lazy var buttonsStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis  = NSLayoutConstraint.Axis.horizontal
        view.spacing = LocalConstants.buttonsStackViewSpacing
        view.addArrangedSubview(favoriteButton)
        view.addArrangedSubview(shareButton)
        view.addArrangedSubview(cartButton)
        
        return view
    }()
    
    private lazy var topLabelsStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .vertical
        view.spacing = LocalConstants.topLabelsStackViewSpacing
        view.addArrangedSubview(artistNameLabel)
        view.addArrangedSubview(artistLabel)
        view.addArrangedSubview(locationLabel)
        
        return view
    }()
    
    private lazy var paintingDetailsStackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .vertical
        view.spacing = 5
        view.addArrangedSubview(paintingTypeLabel)
        view.addArrangedSubview(materialLabel)
        view.addArrangedSubview(dimensionsLabel)
        view.addArrangedSubview(priceLabel)
        
        return view
    }()
    
    // MARK: - Init
    init(
        presenter: PaintingInfoPresenterProtocol,
        painting: Paintings
    ) {
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
        setupViews()
        setupConstraints()
    }
    // MARK: - Private Methods
    private func setupViews() {
        
        view.backgroundColor = .mainBackgroundColor
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(imageView)
        contentView.addSubview(topLabelsStackView)
        contentView.addSubview(viewsLabel)
        contentView.addSubview(buttonsStackView)
        contentView.addSubview(separator)
        contentView.addSubview(paintingDetailsStackView)
        contentView.addSubview(separator2)
        contentView.addSubview(buyButton)
    
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
        buyButton.addTarget(
            self,
            action: #selector(buyButtonPressed),
            for: .touchUpInside)
    }
    
    private func setupConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(LocalConstants.imageViewTop)
            make.leading.trailing.equalTo(contentView).inset(LocalConstants.imageViewHorizontalInset)
            make.height.equalTo(LocalConstants.imageViewHeight)
        }
        
        topLabelsStackView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(LocalConstants.topLabelsStackViewTop)
            make.leading.equalTo(contentView).offset(LocalConstants.topLabelsStackViewLeading)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.leading.equalTo(topLabelsStackView)
            make.top.equalTo(locationLabel.snp.bottom).offset(LocalConstants.buttonsStackViewTop)
        }
        
        viewsLabel.snp.makeConstraints { make in
            make.top.equalTo(topLabelsStackView.snp.bottom).offset(LocalConstants.viewsLabelTop)
            make.trailing.equalTo(contentView).offset(-LocalConstants.viewsLabelTrailing)
        }
        
        separator.snp.makeConstraints { make in
            make.top.equalTo(buttonsStackView.snp.bottom).offset(LocalConstants.separatorTop)
            make.leading.trailing.equalTo(contentView)
        }
        
        paintingDetailsStackView.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(LocalConstants.paintingDetailsStackViewTop)
            make.leading.equalTo(buttonsStackView)
        }
        
        separator2.snp.makeConstraints { make in
            make.top.equalTo(paintingDetailsStackView.snp.bottom).offset(LocalConstants.separator2Top)
            make.leading.trailing.equalTo(contentView)
        }
        
        buyButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView).inset(LocalConstants.buyButtonHorizontalInset)
            make.top.equalTo(separator2.snp.bottom).offset(LocalConstants.buyButtonTop)
            make.height.equalTo(LocalConstants.buyButtonHeight)
            make.bottom.equalTo(contentView).offset(-LocalConstants.buyButtonBottom)
        }
    }

    @objc func likeButtonAction() {
        showAlert(
            withTitle: Strings.addedTitle,
            message: Strings.addedMessage
        )
        presenter.likeButtonTapped()
    }
    
    @objc func cartButtonAction() {
        showAlert(
            withTitle: Strings.addedToCartTitle,
            message: Strings.addedToCartMessage
        )
        presenter.cartButtonTapped()
    }
    // может напрямую сделать @objc методы в презентере??? или не по архитектуре будет?
    @objc func buyButtonPressed() {
        presenter.buyButtonTapped()
    }
    
    private func showAlert(
        withTitle title: String,
        message: String
    ) {
        
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(
            title: Strings.ok,
            style: .default,
            handler: nil
        )
        
        alertController.addAction(okAction)
        present(
            alertController,
            animated: true,
            completion: nil
        )
    }
}

    // MARK: LocalConstants
    private enum LocalConstants {
        
        static let imageViewTop: CGFloat  = 10
        static let imageViewHorizontalInset: CGFloat = 10
        static let imageViewHeight: CGFloat = 300
        
        static let topLabelsStackViewTop: CGFloat = 30
        static let topLabelsStackViewLeading: CGFloat = 20
        static let topLabelsStackViewSpacing: CGFloat = 5
        
        static let buttonsStackViewTop: CGFloat = 10
        static let buttonsStackViewSpacing: CGFloat = 20
        
        static let viewsLabelTop: CGFloat = 10
        static let viewsLabelTrailing: CGFloat = -10
        
        static let separatorTop: CGFloat = 15
        
        static let paintingDetailsStackViewTop: CGFloat = 10
        
        static let separator2Top: CGFloat = 15
        
        static let buyButtonHorizontalInset: CGFloat = 20
        static let buyButtonTop: CGFloat = 20
        static let buyButtonHeight: CGFloat = 50
        static let buyButtonBottom: CGFloat = -20

     }
    // MARK: extension PaintingInfoViewController + PaintingInfoViewProtocol
extension PaintingInfoViewController: PaintingInfoViewProtocol {
    func navigateToFormViewController() {
        let formViewController = FormModuleBuilder.build()
  
//        formViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(
            formViewController,
            animated: true
        )
    }
}
