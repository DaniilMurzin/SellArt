import UIKit

extension UIFont {
    static let buttonsFont = UIFont(name: "Quicksand-Medium", size: 20)
    static let regularBaseFont = UIFont(name: "RFTone-Regular", size: 13)
    static let regularSettingsFont = UIFont(name: "RFTone-Regular", size: 16)
    static let priceFont = UIFont(name: "RFTone-Bold", size: 16)
    static let artNameFont = UIFont (name: "RFTone-Regular", size: 16) // letter spacing 0.5
    static let alertOptions = UIFont(name: "SFProText-Semibold", size: 17)
}

extension String {
    func toStyledForButtonAttributedString() -> NSAttributedString {
        guard let font = UIFont.buttonsFont else {
            assertionFailure("Preinstalled font does not exist!")
            return NSAttributedString()
        }

        let letterSpacing = font.pointSize * 0.125
        let attributes: [NSAttributedString.Key: Any] = [
            .kern: letterSpacing,
            .font: font
        ]
        return NSAttributedString(string: self, attributes: attributes)
    }
}
