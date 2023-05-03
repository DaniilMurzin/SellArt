import UIKit

protocol MainViewProtocol: AnyObject {}

class MainViewController: UIViewController {
    
    var presenter: MainPresenterProtocol
    
    // MARK: private properties
    
    private let profileButton = UserActionsButtons(type: .profile)
    
    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        
        layout.minimumInteritemSpacing = LocalConstants.minimumInterItemSpacing
        
        layout.minimumLineSpacing = LocalConstants.minimumLineSpacing
        
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout)
        
        view.register(
            PaintingCollectionViewCell.self,
            forCellWithReuseIdentifier: PaintingCollectionViewCell.identifier)
        
        view.delegate = self
        
        view.dataSource = self
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
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
    }
    
    // MARK: private methods
    func setupView() {
        
        view.backgroundColor = .mainBackgroundColor
        
        let profileBarItem = UIBarButtonItem(customView: profileButton)
        
        navigationItem.rightBarButtonItem = profileBarItem
        
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .mainBackgroundColor
        
    }
    
    func setupConstraints() {
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
extension MainViewController: MainViewProtocol {}

// MARK: extension MainViewController + UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDataSource,
                              UICollectionViewDelegateFlowLayout {
    
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
        
        if let paintingCell = cell as? PaintingCollectionViewCell {
            paintingCell.setPaintingImage(paintings[indexPath.item])
        } else {
            print("Downcast error")
        }
        
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let screenWidth = UIScreen.main.bounds.width
            let cellWidth = (screenWidth - LocalConstants.totalSpacing) / LocalConstants.numberOfColumns

            let imageHeight = cellWidth * LocalConstants.aspectRatio
            
            let cellHeight = imageHeight + LocalConstants.extraHeight
            
            return CGSize(width: cellWidth, height: cellHeight)
        }
}

private enum LocalConstants {
    
    static let rightInset: CGFloat = -16
 
    static let minimumInterItemSpacing: CGFloat = 5
    
    static let minimumLineSpacing: CGFloat = 10
    
    static let numberOfColumns: CGFloat = 2
    
    static let totalSpacing = (LocalConstants.numberOfColumns - 1) * 10 // 10 — это расстояние между ячейками, можно изменить на свое значение
    
    static let aspectRatio: CGFloat = 1.5 // можно изменить соотношение сторон на свое значение
    
    // Added extra height for buttons and labels
    static let extraHeight: CGFloat = 90 // можно изменить на свое значение
}



//func collectionView(
//    _ collectionView: UICollectionView,
//    layout collectionViewLayout: UICollectionViewLayout,
//    sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let numberOfColumns: CGFloat = 2
//        let totalSpacing = (numberOfColumns - 1) * 10 // 10 — это расстояние между ячейками, можно изменить на свое значение
//        let screenWidth = UIScreen.main.bounds.width
//        let cellWidth = (screenWidth - totalSpacing) / numberOfColumns
//
//        let aspectRatio: CGFloat = 1.5 // можно изменить соотношение сторон на свое значение
//        let imageHeight = cellWidth * aspectRatio
//
//        // Add extra height for buttons and labels
//        let extraHeight: CGFloat = 90 // можно изменить на свое значение
//        let cellHeight = imageHeight + extraHeight
//
//        return CGSize(width: cellWidth, height: cellHeight)
//}
