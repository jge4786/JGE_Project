import UIKit

class CommonLabel: UILabel {
    enum FontType {
    case suit
    case system
    }
    
    
    func setCharacterSpacing(to spacing: CGFloat) {
        guard let text = text, !text.isEmpty else { return }
        let string = NSMutableAttributedString(string: text)
        string.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSRange(location: 0, length: string.length - 1))
        attributedText = string
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func getSUITFont(weight: UIFont.Weight) -> String {
        switch weight {
        case .bold:
            return "SUIT-Bold"
        case .semibold:
            return "SUIT-SemiBold"
        case .regular, _:
            return "SUIT-Regular"
        }
    }
    
    
    /// 라벨의 폰트 설정.
    /// 기본값: size: 14.0, weight: .regular, spacing: 0.0
    func setStyle(
        font: FontType = .system,
        weight: UIFont.Weight = .regular,
        size: CGFloat = 14.0,
        spacing: CGFloat = 0.0
    ) {
        switch font {
        case .system:
            self.font = .systemFont(ofSize: size, weight: weight)
        case .suit:
            self.font = UIFont(name: getSUITFont(weight: weight), size: size)
        }
        
        setCharacterSpacing(to: spacing)
    }
    
    func getFont() -> UIFont {
        return self.font
    }
}
