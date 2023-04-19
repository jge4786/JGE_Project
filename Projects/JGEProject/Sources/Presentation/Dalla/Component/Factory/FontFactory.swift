import UIKit

class FontFactory {
    enum FontType {
        case suit
        case system
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
    ) -> NSMutableAttributedString {
        let string = NSMutableAttributedString(string: text),
            range = NSRange(location: 0, length: text.count)
        
        string.addAttribute(.font, value: getFont(font: font, weight: weight, size: size), range: range)
        string.addAttribute(.foregroundColor, value: color, range: range)
        string.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSRange(location: 0, length: string.length - 1))
        
        return string
    }
}
