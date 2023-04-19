import UIKit

class LiveStatusImage  {
    @frozen enum ButtonType {
        case live
        case listen
    }
    func make(type: ButtonType) -> UIImageView {
        let result = UIImageView()
        
        switch type {
        case .live:
            result.image = UIImage(named: "btnMiniLive")
        case .listen:
            result.image = UIImage(named: "btnMiniListen")
        }
        
        return result
    }
}

