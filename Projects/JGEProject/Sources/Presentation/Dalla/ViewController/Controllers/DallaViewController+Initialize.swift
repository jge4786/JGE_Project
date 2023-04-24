import UIKit
import SnapKit

extension DallaViewController {
    func setSubview() {
        view.addSubview(contentScrollView)
        view.addSubview(headerWrapeprView)
        
        contentScrollView.addSubview(contentStackView)
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
}
