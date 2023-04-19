import UIKit

class TopTenTabButton  {
    @frozen enum TabButtonType {
        case bj
        case fan
        case team
    }
    func make(type: TabButtonType) -> UIButton {
        let factory = FontFactory()
        let result = UIButton()
        
        switch type {
        case .bj:
            result.titleLabel?.attributedText = factory.getFont(text: "BJ", font: .suit, weight: .semibold, size: 19,  spacing: -0.57)
        case .fan:
            result.titleLabel?.attributedText = factory.getFont(text: "FAN",font: .suit, weight: .semibold, size: 19,  spacing: -0.57)
        case .team:
            result.titleLabel?.attributedText = factory.getFont(text: "TEAM",font: .suit, weight: .semibold, size: 19,  spacing: -0.57)
        }
        
        return result
    }
}
