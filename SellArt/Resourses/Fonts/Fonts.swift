import UIKit

extension UIFont {
    static let fontForButtons = UIFont(name: "Quicksand-Medium", size: 20)
    static let regularBaseFont = UIFont(name: "RFTone-Regular", size: 13)
    static let regularSettingsFont = UIFont(name: "RFTone-Regular", size: 16)
    static let priceFont = UIFont(name: "RFTone-Bold", size: 16)
    static let artNameFont = UIFont (name: "RFTone-Regular", size: 16) // letter spacing 0.5
    static let alertOptions = UIFont(name: "SFProText-Semibold", size: 17)
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
