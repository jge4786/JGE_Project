import UIKit
import SnapKit
import Then

class UserListScrollView: UIScrollView {
    var viewModel: DallaViewModel?
    var data: [DallaBannerInfo] = []
    var isRanking = false
    
    var userListStackView = UIStackView().then {
        $0.alignment = .center
        $0.spacing = 8
        $0.distribution = .equalSpacing
    }
    
    init(viewModel: DallaViewModel, isRanking: Bool) {
        super.init(frame: .zero)
        
        self.viewModel = viewModel
        self.isRanking = isRanking
        
        
        if isRanking {
            viewModel.topList.bind {
                guard let data = $0 else { return }
                
                self.data = data
                
                self.initialize()
            }
        } else {
            viewModel.data.bind {
                guard let data = $0 else { return }
                
                self.data = data
                
                self.initialize()
            }
        }
 
        
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initialize() {
        removeAllSubview()
        setSubViews()
        setConstraints()
        setData()
    }
    
    func removeAllSubview() {
        userListStackView.subviews.forEach { view in
            view.removeFromSuperview()
        }
    }
    
    func setSubViews() {
        self.addSubview(userListStackView)
        
        for index in 1...data.count {
            let item = UserListItem(data: data[index - 1], isRanking: isRanking, index: index)
            
            userListStackView.addArrangedSubview(item)
            
            item.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
            }
        }
    }
    
    func setConstraints() {
        userListStackView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.height.equalToSuperview()
        }
        
        
    }
    
    func setData() {
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
