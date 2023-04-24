import UIKit
import SnapKit
import Then

class TabButton: ExtendedButton {
    var type: DallaViewModel.TopTenType = .bj
    
    init(type: DallaViewModel.TopTenType) {
        super.init(frame: .zero)
        
        self.type = type
        
        initialize()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initialize() {
        setSubViews()
        setConstraints()
        setData()
    }
    
    func setSubViews() {
    }
    
    func setConstraints() {
    }
    
    func setData() {
        self.verticalHitSlop = 10
        self.horizontalHitSlop = 10
        self.backgroundColor = .white
        var text = ""
        
        //TODO: rawValue 사용?
        switch type {
        case .bj:
            text = "BJ"
        case .fan:
            text = "FAN"
        case .team:
            text = "TEAM"
        }
        
        let string = FontFactory().getFont(text: text,
                                           font: .suit,
                                           weight: .bold,
                                           size: 14)
        
        self.setAttributedTitle(string, for: .normal)
        
        self.changeSelectedState(to: type == .bj)
    }
    
    func changeSelectedState(to state: Bool) {
        var color = Color.DallaTextGray
        
        if state {
            color = Color.DallaTextBlack
        }
        
        let string = FontFactory().getFont(text: self.currentAttributedTitle?.string ?? "asdf",
                                           font: .suit,
                                           weight: .bold,
                                           size: 14,
                                           color: color)
        
        self.setAttributedTitle(string, for: .normal)
        
        self.layoutIfNeeded()
    }
}
