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
    
    
    var mainBannerScrollView = MainBannerImageScrollView()
    
    var favoriteScrollView = FavoriteListScrollView()
    var favoriteWrapperView = UIView()
    
    var topTenView = TopTenView()
    
    var tmpScrollView = MainBannerImageScrollView()
    
    
    
    var apiTestButton = UIButton().then {
        $0.snp.makeConstraints {
            $0.height.width.equalTo(100)
        }
        $0.layer.borderWidth = 5
        $0.backgroundColor = .black
    }
    @objc
    func bannerAPITestFunc() {
        APIService.shared.getDallaBannerData { [weak self] response in
            dump(response)
        }
        print("zz")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        getFontName()
        
        
        contentScrollView.delegate = self
        mainBannerScrollView.delegate = self
        
        
        setSubview()
        setConstraints()
        setData()
        
//        view.addSubview(apiTestButton)
//        apiTestButton.snp.makeConstraints {
//            $0.bottom.leading.equalToSuperview().inset(30)
//        }
//        apiTestButton.addTarget(self, action: #selector(bannerAPITestFunc), for: .touchUpInside)
        
//        UIView.animate(withDuration: 3, delay: 0, options: [.repeat]) {
//            self.headerWrapeprView.alpha = 1
//        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func getFontName() {
            for family in UIFont.familyNames {

                let sName: String = family as String
                print("family: \(sName)")
                        
                for name in UIFont.fontNames(forFamilyName: sName) {
                    print("name: \(name as String)")
                }
            }
        }
    
    func setSubview() {
        view.addSubview(contentScrollView)
        view.addSubview(headerWrapeprView)
        
        contentScrollView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(mainBannerScrollView)
        contentStackView.addArrangedSubview(favoriteScrollView)
        
        contentStackView.addArrangedSubview(topTenView)
        
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
        
//        favoriteStackView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
        
        //TODO: 임시 높이 지정
        topTenView.snp.makeConstraints {
            $0.height.equalTo(531)
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
        APIService.shared.getDallaBannerData { [weak self] response in
            guard let self = self else { return }
            let json = JSON(response)
            
            self.mainBannerScrollView.initialize(data: json["BannerList"])
        }
//        mainBannerScrollView.initialize()
        favoriteScrollView.initialize()
        topTenView.initialize()
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
