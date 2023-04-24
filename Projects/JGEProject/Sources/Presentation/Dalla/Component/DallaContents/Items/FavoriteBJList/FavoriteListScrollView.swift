import UIKit
import SnapKit
import Then

class FavoriteListScrollView: UIScrollView {
    var data: [DallaBannerInfo]?
    var viewModel: DallaViewModel?
    
    init(viewModel: DallaViewModel) {
        super.init(frame: .zero)
        
        self.viewModel = viewModel
        
        viewModel.data.bind { [weak self] vmData in
            guard let self = self,
                  let data = vmData
            else {
                return
            }
            
            self.data = data
            self.initialize()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
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
    
    func setSubViews() {
        self.addSubview(contentStackView)
        
        data?.forEach {
            let bjView = FavoriteBJView(name: $0.memNick , image: $0.imageBackground, isLive: $0.badgeSpecial)
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
