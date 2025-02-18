import UIKit
import CoreGraphics
import CoreText

public enum FontManager {

    public enum FontName: String, CaseIterable {
        case black = "SF-Pro-Rounded-Black"
        case bold = "SF-Pro-Rounded-Bold"
        case heavy = "SF-Pro-Rounded-Heavy"
        case light = "SF-Pro-Rounded-Light"
        case medium = "SF-Pro-Rounded-Medium"
        case regular = "SF-Pro-Rounded-Regular"
        case semibold = "SF-Pro-Rounded-Semibold"
        case thin = "SF-Pro-Rounded-Thin"
        case ultraLight = "SF-Pro-Rounded-Ultralight"

        var filename: String {
            return self.rawValue
        }

        var fontName: String {
            switch self {
            case .black: return "SFProRounded-Black"
            case .bold: return "SFProRounded-Bold"
            case .heavy: return "SFProRounded-Heavy"
            case .light: return "SFProRounded-Light"
            case .medium: return "SFProRounded-Medium"
            case .regular: return "SFProRounded-Regular"
            case .semibold: return "SFProRounded-Semibold"
            case .thin: return "SFProRounded-Thin"
            case .ultraLight: return "SFProRounded-Ultralight"
            }
        }
    }

    public static func setupFonts() {
        let registeredFonts = Set(UIFont.familyNames.flatMap { UIFont.fontNames(forFamilyName: $0) })

        FontName.allCases.forEach { font in
            if registeredFonts.contains(font.fontName) {
                print("✅ Font already registered: \(font.fontName)")
            } else {
                registerFont(font: font)
            }
        }

        // Проверка после регистрации
        printAvailableFonts()
    }

    private static func isFontRegistered(_ postScriptName: String) -> Bool {
        UIFont(name: postScriptName, size: 12) != nil
    }

    private static func registerFont(font: FontName) {
        let bundle = Bundle.module

        // Меняем путь к файлам - теперь ищем в папке Fonts
        guard let fontURL = bundle.url(forResource: font.filename, withExtension: "otf", subdirectory: "Fonts") else {
            print("❌ Font file not found: \(font.filename) - checked in Fonts directory")
            return
        }

        guard let fontData = try? Data(contentsOf: fontURL) else {
            print("Failed to load font data")
            return
        }

        guard let provider = CGDataProvider(data: fontData as CFData),
              let font = CGFont(provider) else {
            print("Failed to create font")
            return
        }

        var error: Unmanaged<CFError>?
        if CTFontManagerRegisterGraphicsFont(font, &error) {
//            print("✅ Successfully registered font: \(font)")
        } else {
            if let error = error?.takeRetainedValue() {
                let description = CFErrorCopyDescription(error)
                print("❌ Error registering font: \(String(describing: description))")
            }
        }
    }

    public static func printAvailableFonts() {
        FontName.allCases.forEach { font in
            if isFontRegistered(font.fontName) {
                print("✅ Available: \(font.fontName)")
            } else {
                print("❌ Not available: \(font.fontName)")
            }
        }
    }
}
