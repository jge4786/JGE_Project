import UIKit

class FontFactory {
    enum FontType {
        case suit
        case system
        case noto
    }
    
    func getSUITFont(weight: UIFont.Weight) -> String {
        switch weight {
        case .bold:
            return "SUIT-Bold"
        case .semibold:
            return "SUIT-SemiBold"
        case .medium:
            return "SUIT-Medium"
        case .regular, _:
            return "SUIT-Regular"
        }
    }
    
    func getNotoFont(weight: UIFont.Weight) -> String {
        switch weight {
        case .regular, _:
            return "NotoSansKR-Regular"
        }
    }
    
    /// 라벨의 폰트 설정.
    /// 기본값: size: 14.0, weight: .regular, spacing: 0.0
    func getFont(
        font: FontType,
        weight: UIFont.Weight,
        size: CGFloat
    ) -> UIFont {
        var result: UIFont
        switch font {
        case .system:
            result = .systemFont(ofSize: size, weight: weight)
        case .suit:
            result = UIFont(name: getSUITFont(weight: weight), size: size)!
        case .noto:
            result = UIFont(name: getNotoFont(weight: weight), size: size)!
        }
        
        return result
        
    }
    
    /// spacing을 적용한 AttributedString 반환
    func getFont(
        text: String            = "",
        font: FontType          = .system,
        weight: UIFont.Weight   = .regular,
        size: CGFloat           = 14.0,
        color: UIColor          = .black,
        spacing: CGFloat        = 0.0
    ) -> NSAttributedString {
        
        let attributes: [NSAttributedString.Key : Any] = [
            .font: getFont(font: font, weight: weight, size: size),
            .foregroundColor: color,
            .kern: spacing
        ]
        
        let string = NSAttributedString(string: text, attributes: attributes)
        
//        string.addAttribute(.font, value: getFont(font: font, weight: weight, size: size), range: range)
//        string.addAttribute(.foregroundColor, value: color, range: range)
//        string.addAttribute(NSAttributedString.Key.kern, value: spacing, range: range)
        
        return string
    }
}
