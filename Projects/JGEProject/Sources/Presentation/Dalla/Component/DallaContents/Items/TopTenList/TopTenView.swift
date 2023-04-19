import UIKit
import SnapKit
import Then

class TopTenView: UIView {
    let title = "🏆 NOW TOP 10"
    
    var bannerTitleButton = UIButton().then {
        $0.setTitle("🏆 NOW TOP 10", for: .normal)
    }
    
    var tabButtonStackView = UIStackView().then {
        $0.distribution = .equalSpacing
    }
    
    var titleStackView = UIStackView().then {
        $0.distribution = .equalSpacing
    }
    
    var flowLayout = UICollectionViewFlowLayout().then {
        $0.minimumInteritemSpacing = 8.0
        $0.scrollDirection = .horizontal
    }
    
    var userListCollectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: UICollectionViewLayout.init()).then {
        $0.showsHorizontalScrollIndicator = true
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = UIColor.brown
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        UserListCollectionViewCell.register(collectionView: userListCollectionView)
        self.userListCollectionView.dataSource  = self
        self.userListCollectionView.delegate    = self
        userListCollectionView.collectionViewLayout = flowLayout
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
        
    func initialize() {
        setSubViews()
        setConstraints()
        setData()
    }
    
    func setSubViews() {
        self.addSubview(titleStackView)
        
        titleStackView.addArrangedSubview(bannerTitleButton)
        titleStackView.addArrangedSubview(tabButtonStackView)
        
        tabButtonStackView.addArrangedSubview(TopTenTabButton().make(type: .bj))
        tabButtonStackView.addArrangedSubview(TopTenTabButton().make(type: .fan))
        tabButtonStackView.addArrangedSubview(TopTenTabButton().make(type: .team))
        
        self.addSubview(userListCollectionView)
    }
    
    func setConstraints() {
        titleStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        userListCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleStackView.snp.bottom)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    func setData() {
    }
}

extension TopTenView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = UserListCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath) else { return UICollectionViewCell() }
        
        cell.initialize(ranking: indexPath.row + 1)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 116, height: 200)
    }
}
