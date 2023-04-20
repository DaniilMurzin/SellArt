import UIKit

extension UIFont {
    static let fontForButtons = UIFont(name: "Quicksand-Medium", size: 20)
}

extension UIButton {
    func applyCustomFont(with letterSpacingPercentage: CGFloat) {
        guard let font = UIFont.fontForButtons, let currentTitle = self.currentTitle else { return }
        
        let letterSpacing = font.pointSize * letterSpacingPercentage / 100
        let attributes: [NSAttributedString.Key: Any] = [
            .kern: letterSpacing,
            .font: font
        ]
        
        let attributedTitle = NSAttributedString(string: currentTitle, attributes: attributes)
        self.setAttributedTitle(attributedTitle, for: .normal)
    }
}
