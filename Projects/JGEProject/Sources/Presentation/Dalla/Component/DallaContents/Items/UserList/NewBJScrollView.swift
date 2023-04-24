//
//import UIKit
//import SnapKit
//import Then
//
//class NewBJScrollView: UIScrollView {
//    var viewModel: DallaViewModel?
//    var data: [DallaBannerInfo] = []
//    
//    var userListStackView = UIStackView().then {
//        $0.alignment = .center
//        $0.spacing = 8
//        $0.distribution = .equalSpacing
//    }
//    
//    convenience init(viewModel: DallaViewModel) {
//        self.init(frame: .zero)
//        
//        self.viewModel = viewModel
//        
//        viewModel.data.bind {
//            guard let data = $0 else { return }
//            
//            self.data = data
//            
//            self.initialize()
//        }
// 
//        
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
//    
//    func initialize() {
//        removeAllSubview()
//        setSubViews()
//        setConstraints()
//        setData()
//    }
//    
//    func removeAllSubview() {
//        userListStackView.subviews.forEach { view in
//            view.removeFromSuperview()
//        }
//    }
//    
//    func setSubViews() {
//        self.addSubview(userListStackView)
//        
//        for index in 1...data.count {
//            let item = UserListItem(data: data[index - 1], index: index)
//            
//            userListStackView.addArrangedSubview(item)
//            
//            item.snp.makeConstraints {
//                $0.top.bottom.equalToSuperview()
//            }
//        }
//    }
//    
//    func setConstraints() {
//        userListStackView.snp.makeConstraints {
//            $0.top.leading.bottom.trailing.height.equalToSuperview()
//        }
//        
//        
//    }
//    
//    func setData() {
//        self.showsVerticalScrollIndicator = false
//        self.showsHorizontalScrollIndicator = false
//        self.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//    }
//}
