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
    
    convenience init(isRanking: Bool, status: LiveStatus = .none) {
        self.init(frame: .zero)
        
        setSubViews(isRanking: isRanking)
        setConstraints(isRanking: isRanking)
        setData(status: status)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initialize(isRanking: Bool, ranking: Int = 0, status: LiveStatus = .none) {
        if isRanking {
            rankingImageView.isHidden = false
            rankingImageView.image = UIImage(named: "numberW\(ranking)") ?? nil
            nameLabel.isHidden = true
        } else {
            rankingImageView.isHidden = true
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
            $0.bottom.trailing.equalToSuperview()
            $0.width.height.equalTo(49)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
        }
        
//        if isRanking {
//            rankingImageView.snp.makeConstraints {
//                $0.bottom.trailing.equalToSuperview()
//                $0.width.height.equalTo(49)
//            }
//        } else {
//            nameLabel.snp.makeConstraints {
//                $0.leading.bottom.equalToSuperview()
//            }
//        }
    }
    
    func setData(status: LiveStatus) {
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
