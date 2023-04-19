import UIKit
import SnapKit
import Then

class UserListItem: UIStackView {
    var userView = UserView()
//    var userView = UIButton().then {
//        $0.backgroundColor = .green
//        $0.layer.cornerRadius = 8
//        $0.setImage(UIImage(systemName: "cart.fill"), for: .normal)
//    }
    
    var userListNameLabel = UILabel().then {
        $0.textAlignment = .center
        $0.attributedText = FontFactory().getFont(text: "홍길동", font: .suit, weight: .regular, size: 20, color: .gray)
    }
    
    convenience init(shouldShowNameLabel: Bool, index: Int = 0) {
        self.init(frame: .zero)
        
        setSubViews(shouldShowNameLabel: shouldShowNameLabel, index: index)
        setConstraints()
        setData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func setSubViews(shouldShowNameLabel: Bool, index: Int) {
        
        userView.initialize(isRanking: !shouldShowNameLabel, ranking: index)
        self.addArrangedSubview(userView)
        
        guard shouldShowNameLabel else { return }
        
        self.addArrangedSubview(userListNameLabel)
    }
    
    func setConstraints() {
        userView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.equalTo(154)
            $0.width.equalTo(116)
        }
        
    }
    
    func setData() {
        self.spacing = 3
        self.axis = .vertical
    }
}
