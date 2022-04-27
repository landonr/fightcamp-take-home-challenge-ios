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

// MARK: - Font names

extension String {

    fileprivate static let graphikMedium: String = "Graphik-Medium"
    fileprivate static let graphikRegular: String = "Graphik-Regular"
    fileprivate static let groteskSquare: String = "NewGroteskSquareFOUR"
}
