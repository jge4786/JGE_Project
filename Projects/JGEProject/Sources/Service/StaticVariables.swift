import UIKit

struct Constants {
    
    ///디바이스의 크기
    static let deviceSize = UIScreen.main.bounds.size
    
    ///채팅이 최대 몇 줄까지 출력될 수 있는지 결정하는 상수
    static let chatHeightLimit = 15
    
    ///채팅의 너비를 제한할 때 쓰이는 상수
    ///기준 너비에 곱하여 사용하며, 보통 디바이스의 너비에 곱하여 사용 중
    static let chatMaxWidthMultiplier = 0.65
    
    static let rightChatRightPadding = 10
    
    static let defaultImages = [
        "DefaultImage1",
        "DefaultImage2",
        "DefaultImage3",
        "DefaultImage4",
        "DefaultImage5",
        "DefaultImage6",
    ]
    
    // 입력 가능한 최대 메세지 길이
    static let inputLimit = 150
    
    static let chatLoadLimit = 20
    static let loadThreshold = 100.0
    
    static let imageSize = deviceSize.width * chatMaxWidthMultiplier - 150
}

struct Color {
    ///내가 보낸 채팅
    static var Yellow: UIColor { return UIColor(red: 254/255, green: 240/255, blue: 27/255, alpha: 1.0) }
    ///상대방이 보낸 채팅
    static var White: UIColor { return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) }
    ///읽지 않은 사용자의 수
    static var DarkYellow: UIColor { return UIColor(red: 254/255, green: 234/255, blue: 51/255, alpha: 1.0)}
    ///날짜 라벨 배경색, 이름 텍스트 색
    static var InfoLabelColor: UIColor { return UIColor(red: 156/255, green: 175/255, blue: 191/255, alpha: 1.0)}
    ///서랍 배경색
    static var DarkGray: UIColor { return UIColor(red: 95/255, green: 95/255, blue: 95/255, alpha: 1.0) }
    ///카카오톡 기본 배경색
    static var LightBlue: UIColor { return UIColor(red: 155/255, green: 187/255, blue: 212/255, alpha: 1.0)}
    ///카카오톡 검정색 테마의 입력창 배경색
    static var LightBlack: UIColor { return UIColor(red: 46/255, green: 44/255, blue: 48/255, alpha: 1.0)}
    ///카카오톡 검정색 테마의 배경색
    static var Black: UIColor { return UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1.0)}
    ///카카오톡 검정색 테마의 입력창 배경색
    static var LighterBlack: UIColor { return UIColor(red:58/255, green: 56/255, blue: 61/255, alpha: 1.0)}
    ///카카오톡 검정색 테마의 입력창 외곽선 색
    static var DarkerGray: UIColor { return UIColor(red: 70/255, green: 67/255, blue: 71/255, alpha: 1.0)}
    
    static var Transparent: UIColor { return UIColor(red: 0, green: 0, blue: 0, alpha: 0) }
}
