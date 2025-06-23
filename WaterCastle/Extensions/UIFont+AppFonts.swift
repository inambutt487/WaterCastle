import UIKit

extension UIFont {
    static func headingFont() -> UIFont {
        return .boldSystemFont(ofSize: 18)
    }
    
    static func bodyFont() -> UIFont {
        return .systemFont(ofSize: 14)
    }
    
    static func captionFont() -> UIFont {
        return .systemFont(ofSize: 12)
    }
    
    static func buttonFont() -> UIFont {
        return .boldSystemFont(ofSize: 16)
    }
} 