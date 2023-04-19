import UIKit

class HeaderButton {
    @frozen enum ButtonAction {
        case store
        case ranking
        case message
        case alarm
    }
    
    enum HeaderButtonStyle: CaseIterable {
        case store
        case ranking
        case message
        case alarm
        
        var image: UIImage? {
            switch self {
            case .store: return UIImage(named: "btnStore")
            case .ranking: return UIImage(named: "btnRanking")
            case .message: return UIImage(named: "btnMessage")
            case .alarm: return UIImage(named: "btnAlarm")
            }
        }
        
        var action: () -> () {
            switch self {
            case .store: return { print("Store") }
            case .ranking: return { print("Store") }
            case .message: return { print("Store") }
            case .alarm: return { print("Store") }
            }
        }
//
//        static let store = UIImage(named: "btnStore")
//        static let ranking = UIImage(named: "btnRanking")
//        static let message = UIImage(named: "btnMessage")
//        static let alarm = UIImage(named: "btnAlarm")
    }
    
    func make(with style: HeaderButtonStyle) -> UIButton {
        let button = UIButton()
        
        button.tintColor = .white
        button.snp.makeConstraints {
            $0.width.height.equalTo(40)
        }
        
        button.setImage(style.image, for: .normal)
//        button.addTarget(self, action: #selector(tapAction(style)), for: .touchUpInside)
        
        return button
    }
    
//    @objc
//    func tapAction(_ style: HeaderButtonStyle) {
//        style.action
//    }
}
