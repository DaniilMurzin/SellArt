import UIKit

class Separator: UIView {
    
    var thickness: CGFloat = 0.5 {
        didSet {
            setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .gray
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        frame.size.height = thickness
    }
}
