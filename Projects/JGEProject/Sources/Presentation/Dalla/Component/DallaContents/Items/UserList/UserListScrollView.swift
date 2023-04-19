import UIKit
import SnapKit
import Then

class UserListScrollView: UIScrollView {
    var userListStackView = UIStackView().then {
        $0.alignment = .center
        $0.spacing = 8
        $0.distribution = .equalSpacing
    }
    
    convenience init(shouldShowNameLabel: Bool) {
        self.init(frame: .zero)
        
        setSubViews(shouldShowNameLabel: shouldShowNameLabel)
        setConstraints()
        setData()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func setSubViews(shouldShowNameLabel: Bool) {
        self.addSubview(userListStackView)
        
        for index in 1...5 {
            let item = UserListItem(shouldShowNameLabel: shouldShowNameLabel, index: index)
            
            userListStackView.addArrangedSubview(item)
            
            item.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
            }
        }
    }
    
    func setConstraints() {
        userListStackView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.height.equalToSuperview()
        }
        
        
    }
    
    func setData() {
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
