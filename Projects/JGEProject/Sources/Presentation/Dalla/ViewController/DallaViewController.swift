import UIKit
import SnapKit
import Then
import SwiftyJSON

class DallaViewController: UIViewController, TabBarItemRootViewController {
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
        $0.axis = .vertical
    }
    
    var topTenSection = SectionView(title: "NOW TOP 10", hasTabBar: true)
    var newBjSection = SectionView(title: "NEW BJ")
    
    
    var topTenWrapperView = UIStackView().then {
        $0.axis = .vertical
    }
    var newBjWrapperView = UIStackView().then {
        $0.axis = .vertical
    }
    
    lazy var userListScrollView = UserListScrollView(shouldShowNameLabel: false)
    
    lazy var newBjListScrollView = UserListScrollView(shouldShowNameLabel: true)
    
    var mainBannerScrollView = MainBannerImageScrollView()
    
    var favoriteScrollView = FavoriteListScrollView()
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        
        contentScrollView.delegate = self
        mainBannerScrollView.delegate = self
        
        
        setSubview()
        setConstraints()
        setData()
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func setSubview() {
        view.addSubview(contentScrollView)
        view.addSubview(headerWrapeprView)
        
        contentScrollView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(mainBannerScrollView)
        contentStackView.addArrangedSubview(favoriteScrollView)
        
        contentStackView.addArrangedSubview(topTenWrapperView)
        contentStackView.addArrangedSubview(newBjWrapperView)
        
        topTenWrapperView.addArrangedSubview(topTenSection)
        topTenWrapperView.addArrangedSubview(userListScrollView)
        
        newBjWrapperView.addArrangedSubview(newBjSection)
        newBjWrapperView.addArrangedSubview(newBjListScrollView)
        
//        contentStackView.addArrangedSubview(topTenSection)
//
//        contentStackView.addArrangedSubview(userListScrollView)
//
//        contentStackView.addArrangedSubview(newBjSection)
//        contentStackView.addArrangedSubview(newBjListScrollView)

        
        headerWrapeprView.addSubview(headerLogoButton)
        view.addSubview(headerViewButtonGroupStackView)
        
        let headerButtonFactory = HeaderButton()
        headerViewButtonGroupStackView.addArrangedSubview(headerButtonFactory.make(with: .store))
        headerViewButtonGroupStackView.addArrangedSubview(headerButtonFactory.make(with: .ranking))
        headerViewButtonGroupStackView.addArrangedSubview(headerButtonFactory.make(with: .message))
        headerViewButtonGroupStackView.addArrangedSubview(headerButtonFactory.make(with: .alarm))
        
        
    }
    
    func setConstraints() {
        headerWrapeprView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Constants.statusBarHeight + 52)
        }
        
        contentScrollView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentStackView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.width.equalToSuperview()
        }
        
        mainBannerScrollView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(diviceWidth)
        }

        topTenWrapperView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
        
        newBjWrapperView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
        
        headerLogoButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.statusBarHeight + 14)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(13)
        }
        
        headerViewButtonGroupStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(6)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
            
        }
        
    }
    
    func setData() {
        contentScrollView.showsVerticalScrollIndicator = false
        APIService.shared.getDallaBannerData { [weak self] response in
            guard let self = self else { return }
            let json = JSON(response)
            
            self.mainBannerScrollView.initialize(data: json["BannerList"])
        }
        favoriteScrollView.initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mainBannerScrollView.addTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        mainBannerScrollView.stopTimer()
    }
}


extension DallaViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        
        if let scrollView = scrollView as? MainBannerImageScrollView {
            let offsetX = scrollView.contentOffset.x
            let contentWidth = scrollView.contentSize.width
            let scrollViewWidth = scrollView.frame.width

            if offsetX < 0 {
                scrollView.contentOffset.x = contentWidth - scrollViewWidth
            } else if offsetX > contentWidth - scrollViewWidth {
                scrollView.contentOffset.x = 0
            }
        } else {
            let offsetY = scrollView.contentOffset.y

            if offsetY < 0 {
                let viewHeight = mainBannerScrollView.frame.height
                let scale = (viewHeight - offsetY) / (viewHeight)
                
                mainBannerScrollView.transform = CGAffineTransform(translationX: 0, y: offsetY / 2).scaledBy(x: scale, y: scale)
                
            } else if offsetY >= 0 {
                mainBannerScrollView.transform = .identity
            }

            let alphaValue = (offsetY - 200) / 100
            headerWrapeprView.alpha = alphaValue
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        mainBannerScrollView.isHolding = true
        mainBannerScrollView.suspendTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        mainBannerScrollView.resumeTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        mainBannerScrollView.isHolding = false
    }
}
