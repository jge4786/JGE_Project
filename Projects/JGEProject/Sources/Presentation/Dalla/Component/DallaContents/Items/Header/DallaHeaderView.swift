import UIKit
import SnapKit
import Then

class DallaHeaderView: UIView {
    var headerWrapeprView = UIView().then {
        $0.backgroundColor = .blue
    }
    
    var headerLogoButton = UIButton().then {
        $0.setImage(UIImage(named: "dallaLogo"), for: .normal)
    }
    
    var headerViewButtonGroupStackView = UIStackView().then {
        $0.backgroundColor = .clear
        $0.distribution = .equalSpacing
        $0.spacing = 8
    }
    
    func initialize() {
        setSubview()
        setConstraints()
        
        UIView.animate(withDuration: 3, delay: 0, options: [.repeat]) {
            self.headerWrapeprView.alpha = 0
        }
    }
    
    func setSubview() {
        self.addSubview(headerWrapeprView)
        
        self.addSubview(headerViewButtonGroupStackView)
        
        headerWrapeprView.addSubview(headerLogoButton)
        
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
        
        headerLogoButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.statusBarHeight + 14)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(13)
        }
        
        headerViewButtonGroupStackView.snp.makeConstraints {
            $0.top.equalTo(self).inset(6)
            $0.trailing.equalTo(self)
            
        }
    }
    
}
