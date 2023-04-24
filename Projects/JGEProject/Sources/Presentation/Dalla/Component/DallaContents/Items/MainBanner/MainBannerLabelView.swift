import UIKit
import SnapKit
import Then

class MainBannerLabelView: UIView {
    let stackViewSpacing: CGFloat = 9.0

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
    
    var titleLabel = UILabel()
    var bjNameLabel = UILabel()
    
    
    let colors: [CGColor] = [
        .init(gray: 1, alpha: 0),
        .init(gray: 1, alpha: 1)
    ]
    
    lazy var gradientLayer = CAGradientLayer().then {
        $0.colors = colors
    }
    
    
    init() {
        super.init(frame: .zero)
        
        self.layer.insertSublayer(gradientLayer, at: 0)
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
    
    func setData(title: String, bjName: String, isStar: Bool) {
        titleLabel.attributedText = FontFactory().getFont(text: title, font: .suit, weight: .semibold, size: 24, color: Color.DallaTextBlack, spacing: -0.72)
        bjNameLabel.attributedText = FontFactory().getFont(text: bjName, font: .suit, weight: .regular, size: 14, color: Color.DallaTextBlack, spacing: -0.42)
        badgeView.isHidden = !isStar
        
        layoutSubviews()
        
        gradientLayer.frame = self.bounds
    }
        
    func setSubViews() {
        self.addSubview(infoStackView)
        
        infoStackView.addArrangedSubview(badgeView)
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(bjNameLabel)
    }
    
    func setConstraints() {
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
        setNeedsDisplay()
    }
}

