import UIKit
import SnapKit
import Then
import Kingfisher

class FavoriteBJView: UIStackView {
    var isLive = false
    var image = ""
    var name = "홍길동"
    
    let liveColor: [CGColor] = [
        .init(red: 255/255, green: 60/255, blue: 123/255, alpha: 1.0),
        .init(red: 255/255, green: 133/255, blue: 101/255, alpha: 1.0)
    ]
    
    let offlineColor: [CGColor] = [
        .init(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0),
        .init(red: 225/255, green: 225/255, blue: 225/255, alpha: 1.0)
    ]
    
    var profileImageWrapperView = UIView().then {
        $0.layer.cornerRadius = 40
        $0.clipsToBounds = true
    }
    
    var profileImageOuterView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 38
        $0.clipsToBounds = true
    }
    
    lazy var profileImageView = UIButton().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 35
        $0.clipsToBounds = true
    }
    
    lazy var nameLabel = UILabel().then {
        $0.text = name
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
            
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.profileImageWrapperView.bounds
        let colors = isLive ? liveColor : offlineColor
        
        gradientLayer.colors = colors
        
        self.profileImageWrapperView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    init(name: String, image: String, isLive: Bool) {
        super.init(frame: .zero)
        
        self.name = name
        self.image = image
        self.isLive = isLive
        
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        profileImageView.kf.setImage(with: URL(string: image), for: .normal, placeholder: UIImage(systemName: "cart.fill"))
        
        nameLabel.text = name
    }
}
