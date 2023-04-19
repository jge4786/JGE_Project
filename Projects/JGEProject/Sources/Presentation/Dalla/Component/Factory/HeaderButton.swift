import UIKit

class HeaderButton {
    @frozen enum HeaderButtonStyle {
        case store
        case ranking
        case message
        case alarm
    }
    
    private enum ButtonImage {
        static let store = UIImage(named: "btnStore")
        static let ranking = UIImage(named: "btnRanking")
        static let message = UIImage(named: "btnMessage")
        static let alarm = UIImage(named: "btnAlarm")
    }
    
    private enum ButtonAction {
        static let store = { print("Store") }
        static let ranking = { print("ranking") }
        static let message = { print("message") }
        static let alarm = {print("alarm")}
    }
    
    func make(with style: HeaderButtonStyle) -> UIButton {
        let button = UIButton()
        
        button.tintColor = .white
        button.snp.makeConstraints {
            $0.width.height.equalTo(40)
        }
        
        switch style {
        case .store:
            button.setImage(ButtonImage.store, for: .normal)
        case .ranking:
            button.setImage(ButtonImage.ranking, for: .normal)
        case .message:
            button.setImage(ButtonImage.message, for: .normal)
        case .alarm:
            button.setImage(ButtonImage.alarm, for: .normal)
        }
        
        return button
    }
}
