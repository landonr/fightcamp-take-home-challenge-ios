import UIKit

// MARK: - Colors

extension UIColor {

    /// Brand red color
    public static var brandRed: UIColor = .init(hex: "#D73C4B")

    /// Label color
    public static var label: UIColor = .dynamicColor(
        light: .black,
        dark: .white)

    /// Disabled label color (excluded acessories)
    public static var disabledLabel: UIColor = .dynamicColor(
        light: .gray(level: 2),
        dark: .gray(level: 5))

    /// CTA button title color
    public static var buttonTitle: UIColor = .white

    /// CTA button background color
    public static var buttonBackground: UIColor = .brandRed

    /// Primary background color (package view)
    public static var primaryBackground: UIColor = .dynamicColor(
        light: .white,
        dark: .black)

    /// Secondary background color (view controller)
    public static var secondaryBackground: UIColor = .dynamicColor(
        light: .gray(level: 1),
        dark: .gray(level: 6))

    /// Thumbnaild color according to the selection status
    /// - Parameter selected: `true` if the thumbnail is selected
    /// - Returns: border color
    public static func thumbnailBorder(selected: Bool) -> UIColor {

        switch selected {
        case true: return .brandRed
        case false: return .gray(level: 2)
        }
    }

    /// FightCamp gray color according to the level
    /// - Parameter level: 1 to 6, light to dark scale
    /// - Returns: gray color
    private static func gray(level: Int) -> UIColor {

        switch max(level, 1) {
        case 1: return .init(hex: "#DDDFE1")
        case 2: return .init(hex: "#B4B9BE")
        case 3: return .init(hex: "#91989E")
        case 4: return .init(hex: "#4F555C")
        case 5: return .init(hex: "#31363B")
        default: return .init(hex: "#14171A")
        }
    }
}

// MARK: - Utility

extension UIColor {

    /// Initialize a color according to the hexadecimal string value
    /// - Parameters:
    ///     - hex: string representing the color in hexadecimal format
    ///     - alpha: alpha value of the color to be generated
    /// - Note: the hexadecimal string must be valid (including `#` and `6` hexadecimal digits
    public convenience init(hex: String, alpha: CGFloat = 1) {

        guard hex.hasPrefix("#") else { fatalError() }

        let start = hex.index(hex.startIndex, offsetBy: 1)
        let hexColor = String(hex[start...])

        guard hexColor.count == 6 else { fatalError() }

        let scanner = Scanner(string: hexColor)

        var hexNumber: UInt64 = 0

        guard scanner.scanHexInt64(&hexNumber) else { fatalError() }

        let r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
        let g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255
        let b = CGFloat((hexNumber & 0x0000FF) >> 0) / 255

        self.init(displayP3Red: r, green: g, blue: b, alpha: alpha)
    }

    /// Generate a dynamic color that changes according to the operating system dark/light mode
    /// - Parameters:
    ///     - light: color for light mode
    ///     - dark: color for dark mode
    /// - Returns: dynamic color
    public class func dynamicColor(
        light: UIColor,
        dark: UIColor) -> UIColor {

        if #available(iOS 13.0, *) {

            return UIColor {
                switch $0.userInterfaceStyle {
                case .dark: return dark
                default: return light
                }
            }

        } else {

            return light
        }
    }
}
