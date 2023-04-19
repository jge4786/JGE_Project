import UIKit
import SnapKit
import Then

class MainBannerImageView: UIView {
    let stackViewSpacing: CGFloat = 9.0

    var imageView = UIImageView()
    
    var label = UILabel().then {
        $0.numberOfLines = 2
        $0.text = String(Int.random(in: 0...1000000))
    }
    
    lazy var infoStackView = UIStackView().then {
        $0.isLayoutMarginsRelativeArrangement = true
        $0.alignment = .lastBaseline
        $0.layoutMargins = UIEdgeInsets(top: 14, left: 17, bottom: 14, right: 17)
        $0.spacing = stackViewSpacing
        $0.axis = .vertical
    }
    
    var badgeView = UIImageView().then {
        $0.image = UIImage(named: "badgeStar")
    }
    
    var titleLabel = CommonLabel().then {
        $0.setStyle( weight: .semibold, size: 24, spacing: -0.72)
    }
    
    var bjNameLabel = CommonLabel().then {
        $0.setStyle(spacing: -0.42)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.make()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func make() {
        self.backgroundColor = .clear
        setSubViews()
        setConstraints()
    }
    
    func setData(image: UIImage, title: String, bjName: String, isStar: Bool) {
        imageView.image = image
        titleLabel.text = title
        bjNameLabel.text = bjName
        badgeView.isHidden = !isStar
    }
        
    func setSubViews() {
        self.addSubview(imageView)
        self.addSubview(infoStackView)
        
        infoStackView.addArrangedSubview(badgeView)
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(bjNameLabel)
    }
    
    func setConstraints() {
        imageView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
        
        infoStackView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
        }
        
        badgeView.snp.makeConstraints {
            $0.leading.equalTo(infoStackView.layoutMargins)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(infoStackView.layoutMargins)
        }
        bjNameLabel.snp.makeConstraints {
            $0.leading.equalTo(infoStackView.layoutMargins)
        }
    }
}

