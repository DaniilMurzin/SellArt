import UIKit

protocol MainViewProtocol: AnyObject {
    func navigateToPaintingDetails(with painting: Paintings)
}

class MainViewController: UIViewController {
    
    // MARK: private properties
    private(set) var presenter: MainPresenterProtocol
    
    private var paintings: [Paintings] = [] {
           didSet {
               collectionView.reloadData()
           }
       }
    
    private let profileButton = UserActionsButtons(type: .profile)
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = LocalConstants.minimumInterItemSpacing
        layout.minimumLineSpacing = LocalConstants.minimumLineSpacing

        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)
        
        collectionView.register(
            PaintingCollectionViewCell.self,
            forCellWithReuseIdentifier:
                PaintingCollectionViewCell.identifier)
        collectionView.backgroundColor = .mainBackgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()

    // MARK: init
    init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: override methods
    override func viewDidLoad () {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        presenter.loadPaintings { [weak self] paintings in
            self?.paintings = paintings
        }
    }
    
    // MARK: private methods
    private func setupView() {
        view.addSubview(collectionView)
        view.backgroundColor = .mainBackgroundColor
        
        let profileBarItem = UIBarButtonItem(customView: profileButton)
        navigationItem.rightBarButtonItem = profileBarItem
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            collectionView.centerXAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            collectionView.centerYAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            collectionView.heightAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.heightAnchor),
            collectionView.widthAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.widthAnchor)
        ])
    }
}

    // MARK: extension MainViewController + MainViewProtocol
extension MainViewController: MainViewProtocol {
    
    func navigateToPaintingDetails(
        with painting: Paintings) {
            
        let infoViewController = PaintingInfoBuilder.build(
            with: painting)
        infoViewController.hidesBottomBarWhenPushed = true
            
        self.navigationController?.pushViewController(
            infoViewController,
            animated: true)
        }
}

    // MARK: extension MainViewController + UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        UIEdgeInsets(top: 0,
                     left: LocalConstants.leftInset,
                     bottom: 0,
                     right: LocalConstants.rightInset)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection
        section: Int) -> Int {
            paintings.count
        }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PaintingCollectionViewCell.identifier,
                for: indexPath)
            
            guard let paintingCell = cell as? PaintingCollectionViewCell else {
                return cell
            }
            
            let painting = paintings[indexPath.item]
            let formattedPrice = presenter.formatPrice(painting.price)
            paintingCell.setupCell(with: painting, formattedPrice: formattedPrice)
            return paintingCell
        }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        presenter.didSelectPainting(at: indexPath.item)
    }
}
    // MARK: extension MainViewController + UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath)
        -> CGSize {
            
            let screenWidth = UIScreen.main.bounds.width
            let cellWidth = (screenWidth - LocalConstants.totalSpacing) /
            LocalConstants.numberOfColumns
            let imageHeight = cellWidth * LocalConstants.aspectRatio
            let cellHeight = imageHeight + LocalConstants.extraHeight
            
            return CGSize(width: cellWidth,
                          height: cellHeight)
        }
    }
    private enum LocalConstants {
        static let rightInset: CGFloat = 2
        
        static let leftInset: CGFloat = 2
        
        static let minimumInterItemSpacing: CGFloat = 5
        
        static let minimumLineSpacing: CGFloat = 10
        
        static let numberOfColumns: CGFloat = 2
        
        static let totalSpacing = (LocalConstants.numberOfColumns - 1) * 10
        static let aspectRatio: CGFloat = 1.9
        
        static let extraHeight: CGFloat = 20
    }
