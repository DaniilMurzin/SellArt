import UIKit

protocol MainViewProtocol: AnyObject {
    func updatePaintings(_ paintings: [Paintings])
}

class MainViewController: UIViewController {
    
    var presenter: MainPresenterProtocol
    
    // MARK: private properties
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

        $0.setCollectionViewLayout(layout, animated: false)
        $0.register(
            PaintingCollectionViewCell.self,
            forCellWithReuseIdentifier: PaintingCollectionViewCell.identifier)
        $0.backgroundColor = .mainBackgroundColor
        $0.delegate = self
        $0.dataSource = self
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()))
    
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
        presenter.loadPaintings()
    }
    
    // MARK: private methods
    func setupView() {
        view.addSubview(collectionView)
        view.backgroundColor = .mainBackgroundColor
        
        let profileBarItem = UIBarButtonItem(customView: profileButton)
        navigationItem.rightBarButtonItem = profileBarItem
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
extension MainViewController: MainViewProtocol {
    
    func updatePaintings(_ paintings: [Paintings]) {
        self.paintings = paintings
    }
}

// MARK: extension MainViewController + UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    
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
            paintingCell.setupCell(with: painting)
            
            return paintingCell
        }

}

// MARK: extension MainViewController + UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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
        
        static let aspectRatio: CGFloat = 1.9 // можно изменить соотношение сторон на свое значение
        
        // Added extra height for buttons and labels
        static let extraHeight: CGFloat = 150 // можно изменить на свое значение
    }

//  func collectionView(
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
//        let cellHeight = imageHeight + extraHeigh
//        return CGSize(width: cellWidth, height: cellHeight)
// }
