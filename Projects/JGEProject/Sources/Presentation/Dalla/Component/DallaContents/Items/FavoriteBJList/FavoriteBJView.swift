import UIKit
import SnapKit
import Then

class FavoriteBJView: UIStackView {
    var isLive = false
    var image = UIImage(systemName: "cart.fill")
    var name = "홍길동"
    
    
    var profileImageWrapperView = UIView().then {
        $0.backgroundColor = .red
        $0.layer.cornerRadius = 40
    }
    
    var profileImageOuterView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 38
        $0.clipsToBounds = true
    }
    
    lazy var profileImageView = UIButton().then {
        $0.backgroundColor = .white
        $0.setImage(image, for: .normal)
    }
    
    lazy var nameLabel = UILabel().then {
        $0.text = name
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initialize()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initialize() {
        self.axis = .vertical
        self.alignment = .center
        self.spacing = 6
        setSubViews()
        setConstraints()
        setData()
    }
    
    func setSubViews() {
        self.addArrangedSubview(profileImageWrapperView)
        self.addArrangedSubview(nameLabel)
        
        profileImageWrapperView.addSubview(profileImageOuterView)
        profileImageOuterView.addSubview(profileImageView)
    }
    
    func setConstraints() {
        profileImageWrapperView.snp.makeConstraints {
            $0.width.height.equalTo(80)
        }
        
        profileImageOuterView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview().inset(2)
        }
        profileImageView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview().inset(2)
        }
        
    }
    
    func setData() {
        profileImageView.setImage(image, for: .normal)
        nameLabel.text = name
    }
}
