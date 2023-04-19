import UIKit
import SnapKit
import Then

class UserListCollectionViewCell: UICollectionViewCell, DallaCollectionViewCellBase {
    var contentStackView = UIStackView().then {
//        $0.distribution = .equalSpacing
        $0.alignment = .center
        $0.backgroundColor = .green
    }
    
    var contentWrapperView = UIView().then {
        $0.backgroundColor = .yellow
    }
    
    var contentButton = UIButton().then {
        $0.setTitle("", for: .normal)
    }
    
    var liveStatusView = UIImageView().then {
        $0.isHidden = true
    }
    
    var insideNameLabel = UILabel().then {
        $0.isHidden = true
    }
    
    var nameLabel = UILabel().then {
        $0.isHidden = true
    }
    
    var rankingView = UIImageView().then {
        $0.isHidden = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initialize(ranking: Int) {
        setSubViews()
        setConstraints()
        setData(ranking: ranking)
    }
    
    func setSubViews() {
        contentView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(contentWrapperView)
        contentStackView.addArrangedSubview(nameLabel)
        
        contentWrapperView.addSubview(contentButton)
        
        contentWrapperView.addSubview(liveStatusView)
        contentWrapperView.addSubview(insideNameLabel)
        contentWrapperView.addSubview(rankingView)
        
        
    }
    
    func setConstraints() {
        contentStackView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
        
        contentWrapperView.snp.makeConstraints {
            $0.width.equalToSuperview()
        }
        
        liveStatusView.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
//            $0.width.height.equalTo(40)
        }
        
        insideNameLabel.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview().inset(8)
        }
        
        rankingView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview().inset(3)
//            $0.height.equalTo(48)
//            $0.width.equalTo(49)
        }
    }
    
    func setData(ranking: Int) {
        contentView.layer.cornerRadius = 8
        
        insideNameLabel.attributedText = FontFactory().getFont(text: "name", font: .suit, weight: .medium, size: 13)
        
        rankingView.image = UIImage(named: "numberW\(ranking)") ?? UIImage(systemName: "xmark")
    }
}
