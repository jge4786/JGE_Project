import UIKit
import SnapKit
import Then

class TabButton: ExtendedButton {
    var type: DallaViewModel.TopTenType = .bj
    
    convenience init(type: DallaViewModel.TopTenType) {
        self.init(frame: .zero)
        
        self.type = type
        
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        
        switch type {
        case .bj:   text = "BJ"
        case .fan:  text = "FAN"
        case .team: text = "TEAM"
        }
        
        self.setAttributedTitle(FontFactory().getFont(text: text,
                                                      font: .suit,
                                                      weight: .bold,
                                                      size: 14,
                                                      color: Color.DallaTextBlack)
                                , for: .normal)
        
        self.changeSelectedState(to: type == .bj)
    }
    
    func changeSelectedState(to state: Bool) {
        var color = Color.DallaTextGray
        
        if state {
            color = Color.DallaTextBlack
        }
        
        self.setAttributedTitle(FontFactory().getFont(text: self.currentAttributedTitle?.string ?? "asdf",
                                                      font: .suit,
                                                      weight: .bold,
                                                      size: 14,
                                                      color: color)
                                , for: .normal)
        
        self.layoutIfNeeded()
    }
}
