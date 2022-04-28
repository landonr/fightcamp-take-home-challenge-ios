import SwiftUI
import UIKit

// MARK: - Font

extension UIFont {

    /// Package title label font
    public static var title: UIFont = .init(
        name: .groteskSquare,
        size: 36)!

    /// Package description label & package accessories label & price title label
    public static var body: UIFont = .init(
        name: .graphikMedium,
        size: 16)!

    /// Price label font
    public static var price: UIFont = .init(
        name: .graphikMedium,
        size: 26)!

    /// CTA button font
    public static var button: UIFont = .init(
        name: .graphikMedium,
        size: 16)!
}

// MARK: - Fonts

extension Font {

    /// Package title label font
    public static var title: Font {

        #if DEBUG
        if ProcessInfo.isPreview {

            return .system(size: 36, weight: .bold, design: .default)
        }
        #endif

        return Font.custom(.groteskSquare, size: 36)
    }

    /// Package description label & package accessories label & price title label
    public static var body: Font {

        #if DEBUG
        if ProcessInfo.isPreview {

            return .system(size: 16, weight: .medium, design: .default)
        }
        #endif

        return Font.custom(.graphikMedium, size: 16)
    }

    /// Price label font
    public static var price: Font {

        #if DEBUG
        if ProcessInfo.isPreview {

            return .system(size: 26, weight: .medium, design: .default)
        }
        #endif

        return Font.custom(.graphikMedium, size: 26)
    }

    /// CTA button font
    public static var button: Font = body
}

// MARK: - Font names

extension String {

    fileprivate static let graphikMedium: String = "Graphik-Medium"
    fileprivate static let graphikRegular: String = "Graphik-Regular"
    fileprivate static let groteskSquare: String = "NewGroteskSquareFOUR"
}

extension ProcessInfo {

    static var isPreview: Bool {

        processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
