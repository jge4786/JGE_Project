import UIKit
import SnapKit
import Then

class TopTenView: UIStackView {
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
    
    var userListCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .init(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.red

        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        UserListCollectionViewCell.register(collectionView: userListCollectionView)
        
        self.userListCollectionView.dataSource = self
        
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
        
    func initialize() {
        setSubViews()
        setConstraints()
        setData()
    }
    
    func setSubViews() {
        self.addArrangedSubview(titleStackView)
        
        titleStackView.addArrangedSubview(bannerTitleButton)
        titleStackView.addArrangedSubview(tabButtonStackView)
        
        tabButtonStackView.addArrangedSubview(TopTenTabButton().make(type: .bj))
        tabButtonStackView.addArrangedSubview(TopTenTabButton().make(type: .fan))
        tabButtonStackView.addArrangedSubview(TopTenTabButton().make(type: .team))
        
        self.addArrangedSubview(userListCollectionView)
    }
    
    func setConstraints() {
        
    }
    
    func setData() {
        self.axis = .vertical
    }
}

extension TopTenView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = UserListCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath) else { return UICollectionViewCell() }
        
        cell.initialize(ranking: indexPath.row + 1)
        
        return cell
    }
}
