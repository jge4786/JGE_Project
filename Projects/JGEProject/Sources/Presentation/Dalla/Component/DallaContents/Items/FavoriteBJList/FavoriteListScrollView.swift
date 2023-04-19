import UIKit
import SnapKit
import Then

class FavoriteListScrollView: UIScrollView {
    func initialize() {
        
        
        setSubViews()
        setConstraints()
        setData()
    }
    
    var contentStackView = UIStackView().then {
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16)
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.spacing = 10
    }
    
    var moreButton = UIButton().then {
        $0.layer.cornerRadius = 35
        $0.backgroundColor = .gray
    }
        
    let itemSize = 80
    let total = Int.random(in: 20...100)
    func setSubViews() {
        self.addSubview(contentStackView)
        
        for _ in 1..<10 {
            let bjView = FavoriteBJView()
            
            contentStackView.addArrangedSubview(bjView)
            
        }
        
        contentStackView.addArrangedSubview(FavoriteBJView())
        
    }
    
    func setConstraints() {
        contentStackView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.height.equalToSuperview()
        }
    }
    
    func setData() {
        moreButton.setTitle("+25", for: .normal)
    }
}
