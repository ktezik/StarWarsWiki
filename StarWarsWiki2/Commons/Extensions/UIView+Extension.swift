import UIKit

extension UIView {
    
    // MARK: - Public Properties
    
    static var identifier: String {
        return String(describing: self)
    }

    func applyShadow(
        shadowOffSet: CGSize = CGSize(width: 0, height: 0),
        shadowOpacity: Float = 12,
        shadowRadius: CGFloat = 12,
        color: UIColor = UIColor(hexString: "000014").withAlphaComponent(0.18)
    ) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        layer.shadowOffset = shadowOffSet
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}
