import UIKit
import SnapKit
import Then
import SwiftyJSON

class DallaViewController: UIViewController, TabBarItemRootViewController {
    var viewModel = DallaViewModel()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var tabId: TabBarIdentifier = .dalla
    let diviceWidth = UIScreen.main.bounds.size.width
    
    var headerWrapeprView = UIView().then {
        $0.backgroundColor = .blue
        $0.alpha = 0
    }
    
    var headerLogoButton = UIButton().then {
        $0.setImage(UIImage(named: "dallaLogo"), for: .normal)
    }
    
    var headerViewButtonGroupStackView = UIStackView().then {
        $0.backgroundColor = .clear
        $0.distribution = .equalSpacing
        $0.spacing = 8
    }
    
    var contentScrollView = UIScrollView().then {
        $0.backgroundColor = .clear
    }
    var contentStackView = UIStackView().then {
        $0.spacing = 24
        $0.axis = .vertical
    }
    
    lazy var mainBannerView = MainBannerCollectionView(viewModel: viewModel)
    
    lazy var topTenSection = SectionView(viewModel: viewModel, title: "🏆 NOW TOP 10", hasTabBar: true)
    lazy var newBjSection = SectionView(viewModel: viewModel, title: "🌱 NEW BJ")
    
    
    var topTenWrapperView = UIStackView().then {
        $0.spacing = 12
        $0.axis = .vertical
    }
    var newBjWrapperView = UIStackView().then {
        $0.spacing = 12
        $0.axis = .vertical
    }
    
    lazy var topTenScrollView = UserListScrollView(viewModel: viewModel, isRanking: true)
    
    lazy var newBjListScrollView = UserListScrollView(viewModel: viewModel, isRanking: false)
    
    lazy var favoriteScrollView = FavoriteListScrollView(viewModel: viewModel)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        contentScrollView.delegate = self
        
        self.mainBannerView.delegate = self
        self.mainBannerView.dataSource = self
        MainBannerCell.register(collectionView: mainBannerView)
        
        setSubview()
        setConstraints()
        setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mainBannerView.addTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        mainBannerView.stopTimer()
    }
}
