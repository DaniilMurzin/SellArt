import UIKit

protocol MainViewProtocol: AnyObject {
    func navigateToPaintingDetails(with painting: Paintings)
}

class MainViewController: UIViewController {
    
    // MARK: - private properties
    private(set) var presenter: MainPresenterProtocol
    
    private var paintings: [Paintings] = [] {
           didSet {
               collectionView.reloadData()
           }
       }
    
    private let profileButton = UserActionsButtons(type: .profile)
    
    private lazy var collectionView: UICollectionView = {
        let layout = PinterestLayout()
        layout.delegate = self
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.register(
            PaintingCollectionViewCell.self,
            forCellWithReuseIdentifier: PaintingCollectionViewCell.identifier
        )
        collectionView.backgroundColor = .mainBackgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()

    // MARK: - init
    init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
        super.init(
            nibName: nil,
            bundle: nil
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - override methods
    override func viewDidLoad () {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        presenter.loadPaintings { [weak self] paintings in
            self?.paintings = paintings
        }
    }
    
    // MARK: - private methods
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true

        let attributes: [NSAttributedString.Key: Any]
        = [
            .font: UIFont.largeTitleFont,
            .foregroundColor: UIColor.mainFontColor
        ]

        navigationController?.navigationBar.largeTitleTextAttributes = attributes
    }
    
    private func setupView() {
        view.addSubview(collectionView)
        view.backgroundColor = .mainBackgroundColor
        title = Strings.tabBarGallery
        setupNavigationBar()
        let profileBarItem = UIBarButtonItem(customView: profileButton)
        navigationItem.rightBarButtonItem = profileBarItem
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            collectionView.centerXAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.centerXAnchor
            ),
            collectionView.centerYAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.centerYAnchor
            ),
            collectionView.heightAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.heightAnchor
            ),
            collectionView.widthAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.widthAnchor
            )
        ])
    
    }
}

    // MARK: - extension MainViewController + MainViewProtocol
extension MainViewController: MainViewProtocol {
    
    func navigateToPaintingDetails(with painting: Paintings) {
        let infoViewController = PaintingInfoModuleBuilder.build(with: painting)
        infoViewController.hidesBottomBarWhenPushed = true
            
        self.navigationController?.pushViewController(
            infoViewController,
            animated: true
        )
    }
}

    // MARK: - extension MainViewController + UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        
        UIEdgeInsets(
            top: 0,
            left: LocalConstants.leftInset,
            bottom: 0,
            right: LocalConstants.rightInset
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        paintings.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PaintingCollectionViewCell.identifier,
            for: indexPath
        )
                
        guard let paintingCell = cell as? PaintingCollectionViewCell else {
            return cell
        }
        
        paintingCell.delegate = self
        paintingCell.indexPath = indexPath
        let painting = paintings[indexPath.item]
        let formattedPrice = presenter.formatPrice(painting.price)
        paintingCell.setupCell(
            with: painting,
            formattedPrice: formattedPrice
        )
        return paintingCell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
    presenter.didSelectPainting(at: indexPath.item)
    }
}

    // MARK: - extension MainViewController + CustomCellDelegate
extension MainViewController: CustomCellDelegate {
    
    func likeButtonTapped(at indexPath: IndexPath) {
        showAlert(
            withTitle: Strings.addedTitle,
            message: Strings.addedMessage
        )
        presenter.likeButtonTapped(at: indexPath)
    }
    
    func cartButtonTapped(at indexPath: IndexPath) {
        showAlert(
            withTitle: Strings.addedToCartTitle,
            message: Strings.addedToCartMessage
        )
        presenter.cartButtonTapped(at: indexPath)
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
    // MARK: - extension MainViewController + UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {}

    // MARK: - extension MainViewController + PinterestLayoutDelegate
extension MainViewController: PinterestLayoutDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath: IndexPath
    ) -> CGFloat {
        
        let painting = paintings[indexPath.item]
        
        // Расчет высоты изображения.
        let cellWidth =
        collectionView.bounds.width / LocalConstants.numberOfColumns
        
        let imageHeight =
        painting.image.size.height * (cellWidth / painting.image.size.width)
        
        // Расчет высоты лейблов.
        let labelWidth =
        cellWidth - (LocalConstants.leftInset + LocalConstants.rightInset)
        
        let artNameHeight = painting.name.height(
            withConstrainedWidth: labelWidth,
            font: UIFont.artNameFont!
        )
        let artistHeight = painting.artist.height(
            withConstrainedWidth: labelWidth,
            font: UIFont.regularBaseFont!
        )
        let priceHeight = presenter.formatPrice(painting.price).height(
            withConstrainedWidth: labelWidth,
            font: UIFont.priceFont!
        )
        let additionalSpacing = LocalConstants.additionalSpacing
        
        // Расчет высоты кнопок.
        let buttonsHeight = LocalConstants.buttonsHeight
        
        // Суммируем все высоты и добавляем вертикальные отступы.
        let totalVerticalSpacing = LocalConstants.minimumLineSpacing * 4 //
        
        let totalHeight = imageHeight + artNameHeight + artistHeight +
        priceHeight + buttonsHeight + totalVerticalSpacing + additionalSpacing
        
        return totalHeight
    }
}
    // MARK: - extension MainViewController + CustomCellDelegate
    private enum LocalConstants {
        static let rightInset: CGFloat = 2
        
        static let leftInset: CGFloat = 2
        
        static let minimumInterItemSpacing: CGFloat = 5
        
        static let minimumLineSpacing: CGFloat = 10
        
        static let numberOfColumns: CGFloat = 2
        
        static let totalSpacing = (LocalConstants.numberOfColumns - 1) * 10
        
        static let aspectRatio: CGFloat = 1.9
        
        static let extraHeight: CGFloat = 20
        
        static let buttonsHeight: CGFloat = 30
        
        static let additionalSpacing: CGFloat = 20
}
