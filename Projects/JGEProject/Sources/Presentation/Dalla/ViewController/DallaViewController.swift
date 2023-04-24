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
    
    lazy var mainBannerView = MainBannerCollectionView()
    
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
//        mainBannerScrollView.delegate = self
        
        self.mainBannerView.delegate = self
        self.mainBannerView.dataSource = self
        MainBannerCell.register(collectionView: mainBannerView)
        
        setSubview()
        setConstraints()
        setData()
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func setSubview() {
        view.addSubview(contentScrollView)
        view.addSubview(headerWrapeprView)
        
        contentScrollView.addSubview(contentStackView)
//        contentStackView.addArrangedSubview(mainBannerScrollView)
        contentStackView.addArrangedSubview(mainBannerView)
        contentStackView.addArrangedSubview(favoriteScrollView)
        
        contentStackView.addArrangedSubview(topTenWrapperView)
        contentStackView.addArrangedSubview(newBjWrapperView)
        
        topTenWrapperView.addArrangedSubview(topTenSection)
        topTenWrapperView.addArrangedSubview(topTenScrollView)
        
        newBjWrapperView.addArrangedSubview(newBjSection)
        newBjWrapperView.addArrangedSubview(newBjListScrollView)
                
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
        
//        mainBannerScrollView.snp.makeConstraints {
//            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(diviceWidth)
//        }
        
        mainBannerView.snp.makeConstraints {
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
        contentScrollView.canCancelContentTouches = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mainBannerView.addTimer()
//        mainBannerScrollView.addTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        mainBannerView.stopTimer()
//        mainBannerScrollView.stopTimer()
    }
}


extension DallaViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Constants.deviceSize.width
        return CGSize(width: width, height: width)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = viewModel.data.value?.count else { return 0 }
        
        return count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = MainBannerCell.dequeueReusableCell(collectionView: mainBannerView, indexPath: indexPath) else {
            return UICollectionViewCell()
        }
        var index = indexPath.row
        if index == viewModel.data.value!.count { index = 0 }
        
        cell.initialize(data: viewModel.data.value![index])
        return cell
    }
}


extension DallaViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let scrollView = scrollView as? MainBannerCollectionView {
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
                let translateValue  = offsetY / 2,
                    viewHeight      = Constants.deviceSize.width,
                    scale           = 1 + (-1 * offsetY / viewHeight)
                
//                mainBannerScrollView.changeScale(to: scale)
//                mainBannerScrollView.transform = CGAffineTransform(translationX: 0, y: translateValue).scaledBy(x: scale, y: scale)
//                mainBannerView.changeScale(to: scale)
                mainBannerView.transform = CGAffineTransform(translationX: 0, y: translateValue).scaledBy(x: scale, y: scale)
            } else if offsetY >= 0 {
//                mainBannerView.changeScale(to: 1)
                mainBannerView.transform = .identity
//                mainBannerScrollView.changeScale(to: 1)
//                mainBannerScrollView.transform = .identity
            }
            
            if offsetY >= 50 && offsetY <= 250 {
                let alphaValue = (offsetY - 150) / 100
                headerWrapeprView.alpha = alphaValue
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        mainBannerView.isHolding = true
        mainBannerView.suspendTimer()
//        mainBannerScrollView.isHolding = true
//        mainBannerScrollView.suspendTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        mainBannerView.resumeTimer()
        
        if !decelerate {
            mainBannerView.isHolding = false
        }
//        mainBannerScrollView.resumeTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        mainBannerView.isHolding = false
//        mainBannerScrollView.isHolding = false
    }
}
