import UIKit
import SnapKit
import Then

final class UserView: UIButton {
    enum LiveStatus {
        case live
        case listen
        case none
    }
    
    var liveStatusImageView = UIImageView()
    
    var nameLabel = UILabel().then {
        $0.isHidden = true
        $0.text = "ㅋㅋㅋ"
    }
    
    var rankingImageView = UIImageView().then {
        $0.isHidden = true
    }
    
    convenience init() {
        self.init(isRanking: true)
    }
    
    init(isRanking: Bool, status: LiveStatus = .none) {
        super.init(frame: .zero)
        
        setSubViews(isRanking: isRanking)
        setConstraints(isRanking: isRanking)
        setData(status: status)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initialize(data: DallaBannerInfo?, isRanking: Bool, ranking: Int = 0, status: LiveStatus = .none) {
        self.kf.setImage(with: URL(string: data?.imageBackground ?? ""), for: .normal, placeholder: UIImage(named: "defaultImage"))
        
        if isRanking {
            rankingImageView.isHidden = false
            rankingImageView.image = UIImage(named: "numberW\(ranking)") ?? nil
            nameLabel.isHidden = true
        } else {
            rankingImageView.isHidden = true
            nameLabel.text = data?.memNick ?? "홍길동"
            nameLabel.isHidden = false
        }
    }
    
    func setSubViews(isRanking: Bool) {
        self.addSubview(liveStatusImageView)
        
        self.addSubview(rankingImageView)
        self.addSubview(nameLabel)
        
//        if isRanking {
//            self.addSubview(rankingImageView)
//        } else {
//            self.addSubview(nameLabel)
//        }
    }
    
    func setConstraints(isRanking: Bool) {
        liveStatusImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.width.equalTo(40)
        }
        
        rankingImageView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview().inset(3)
            $0.width.height.equalTo(49)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(8)
        }
    }
    
    func setData(status: LiveStatus) {
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        
        nameLabel.attributedText = FontFactory().getFont(text: nameLabel.text ?? "",
                                                         font: .suit,
                                                         weight: .medium,
                                                         size: 13,
                                                         color: .white)
        
        self.setTitle("", for: .normal)
        
        switch status {
        case .live:
            self.setImage(UIImage(named: "btnMiniLive"), for: .normal)
        case .listen:
            self.setImage(UIImage(named: "btnMiniListen"), for: .normal)
        case .none:
            self.setImage(nil, for: .normal)
            break
        }
        
    }
}
