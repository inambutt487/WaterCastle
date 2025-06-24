import SwiftUICore

enum Constants {

    struct AppColor {
        static let primaryBlack = Color.init(hex: "07A9F0")
        static let secondaryBlack = Color.init(hex: "44C4FC")
        static let lightGrayColor = Color.init(hex: "F9F9F9")
        static let backgroundColor = Color.init(hex: "FFFFFF")
        static let primaryRed = Color.init(hex: "CB2D3E")
        static let secondaryRed = Color.init(hex: "EF473A")
        static let gradientRedHorizontal = LinearGradient(gradient: Gradient(colors: [Color.init(hex: "CB2D3E"), Color.init(hex: "EF473A")]), startPoint: .leading, endPoint: .trailing)
        static let gradientRedVertical = LinearGradient(gradient: Gradient(colors: [Color.init(hex: "CB2D3E"), Color.init(hex: "EF473A")]), startPoint: .bottom, endPoint: .top)
        static let shadowColor = Color.init(hex: "dddddd")
        static let lightGreen = Color.init(hex: "e8fbe8")
        static let accentTabColor = Color.init(hex: "DB3022") // For tab accent
        static let grayText = Color.init(hex: "bbbbbb") // For trash icon
        static let discountGreen = Color.init(hex: "036440") // For discount text
    }
    
    struct AppFont {
        static let extraBoldFont = "OpenSans-ExtraBold"
        static let boldFont = "OpenSans-Bold"
        static let semiBoldFont = "OpenSans-SemiBold"
        static let regularFont = "OpenSans-Regular"
        static let lightFont = "OpenSans-Light"
    }

    // MARK: - API URLs
    enum API {
        static let baseURL = "https://fgstg.berain.com.sa/berain_oms/api/v4"
        static let productsEndpoint = "/products"
        static let companySettingsEndpoint = "/companysetting"
        static let companySettingsAuthKey = "060fac9a80afec9b95eb292ad884c5f5"
    }
    
    // MARK: - UI Constants
    enum UI {
        static let defaultPadding: CGFloat = 16
        static let defaultMargin: CGFloat = 16
        static let cornerRadius: CGFloat = 8
        static let buttonHeight: CGFloat = 44
        static let defaultSpacing: CGFloat = 8
    }
    
    // MARK: - Spacing
    enum Spacing {
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
    }
    
    // MARK: - Animation
    enum Animation {
        static let defaultDuration: TimeInterval = 0.3
    }
    
    // MARK: - Cache
    enum Cache {
        static let maxCacheSize = 50 * 1024 * 1024 // 50MB
    }
}
