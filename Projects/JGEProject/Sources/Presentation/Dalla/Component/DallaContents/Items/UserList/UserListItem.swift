import UIKit
import SnapKit
import Then

class UserListItem: UIStackView {
    var userView = UserView()
//    var userView = UIButton().then {
//        $0.backgroundColor = .green
//        $0.layer.cornerRadius = 8
//        $0.setImage(UIImage(systemName: "cart.fill"), for: .normal)
//    }
    
    var data: DallaBannerInfo?
    
    var userListNameLabel = UILabel().then {
        $0.textAlignment = .center
    }
    
    init(data: DallaBannerInfo, isRanking: Bool, index: Int = 0) {
        super.init(frame: .zero)
        self.data = data
        setSubViews(isRanking: isRanking, index: index)
        setConstraints()
        setData()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func setSubViews(isRanking: Bool, index: Int) {
        
        userView.initialize(data: data, isRanking: isRanking, ranking: index)
        self.addArrangedSubview(userView)
        
        guard isRanking else { return }
        
        self.addArrangedSubview(userListNameLabel)
    }
    
    func setConstraints() {
        userView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.equalTo(154)
            $0.width.equalTo(116)
        }
        
    }
    
    func setData() {
        userListNameLabel.attributedText = FontFactory().getFont(text: data?.memNick ?? "",
                                                                 font: .noto,
                                                                 weight: .regular,
                                                                 size: 15,
                                                                 color: Color.DallaTextLightBlack,
                                                                 spacing: -0.75)
        self.spacing = 3
        self.axis = .vertical
    }
}
