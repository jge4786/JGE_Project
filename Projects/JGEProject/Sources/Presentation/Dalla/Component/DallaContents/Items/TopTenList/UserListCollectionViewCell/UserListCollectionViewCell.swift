import UIKit
import SnapKit
import Then

class UserListCollectionViewCell: UICollectionViewCell, DallaCollectionViewCellBase {
    var contentStackView = UIStackView().then {
        $0.axis = .vertical
//        $0.alignment = .center
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
        $0.text = "홍길동"
    }
    
    var rankingView = UIImageView().then {
        $0
        
//        $0.isHidden = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        setSubViews()
        setConstraints()
        
        
            contentView.layer.cornerRadius = 8
        
        insideNameLabel.attributedText = FontFactory().getFont(text: "name", font: .suit, weight: .medium, size: 13)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initialize(ranking: Int) {
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
            $0.top.leading.equalToSuperview()
        }
        
        contentWrapperView.snp.makeConstraints {
            $0.width.equalTo(116)
            $0.height.equalTo(154)
        }
        
        liveStatusView.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        
        insideNameLabel.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview().inset(8)
        }
        
        rankingView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview().inset(3)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func setData(ranking: Int) {
        
        
        rankingView.image = UIImage(named: "numberW\(ranking)") ?? UIImage(systemName: "xmark")
    }
}
