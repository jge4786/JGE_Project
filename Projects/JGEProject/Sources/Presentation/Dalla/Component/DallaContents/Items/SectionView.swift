import UIKit
import SnapKit
import Then

class SectionView: UIStackView {
    var title: String = ""
    var hasTabBar: Bool = false
    
    
    var titleButton = UIButton()
    
    var sectionTabBar = UIStackView().then {
        $0.distribution = .equalSpacing
        $0.spacing = 10
    }
    
    var viewModel: DallaViewModel?
    
    lazy var seperatorBar = UIView().then {
        $0.backgroundColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
    }
    
    
    var bjButton = UIButton().then {
        $0.backgroundColor = .white
        $0.setAttributedTitle(
            FontFactory().getFont(text: "BJ", font: .suit, weight: .bold, size: 14, color: .black)
            , for: .normal)
    }
    
    var fanButton = UIButton().then {
        $0.backgroundColor = .white
        $0.setAttributedTitle(
            FontFactory().getFont(text: "FAN", font: .suit, weight: .bold, size: 14, color: .black)
            , for: .normal)
    }
    
    var teamButton = UIButton().then {
        $0.backgroundColor = .white
        $0.setAttributedTitle(
            FontFactory().getFont(text: "TEAM", font: .suit, weight: .bold, size: 14, color: .black)
            , for: .normal)
    }
    
    
    convenience init(viewModel: DallaViewModel, title: String, hasTabBar: Bool = false) {
        self.init(frame: .zero)
        
        self.viewModel = viewModel
        setSubViews( hasTabBar: hasTabBar)
        setConstraints()
        setData(title: title)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setSubViews( hasTabBar: Bool) {
        self.addArrangedSubview(titleButton)
        
        if hasTabBar {
            self.addArrangedSubview(sectionTabBar)
            sectionTabBar.addArrangedSubview(bjButton)
            sectionTabBar.addArrangedSubview(seperatorBar)
            sectionTabBar.addArrangedSubview(fanButton)
            sectionTabBar.addArrangedSubview(seperatorBar)
            sectionTabBar.addArrangedSubview(teamButton)
        } else {
            self.addArrangedSubview(UIView())
        }
    }
    
    func setConstraints() {
        sectionTabBar.snp.makeConstraints {
            $0.height.equalTo(10)
        }
    }
    
    func setData(title: String) {
        self.isLayoutMarginsRelativeArrangement = true
        self.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        self.distribution = .equalSpacing
        
        titleButton.setAttributedTitle(
            FontFactory().getFont(text: title, font: .suit, weight: .bold, size: 19, color: .black, spacing: -0.57)
            , for: .normal)
        
        bjButton.addTarget(self, action: #selector(onPressBJButton), for: .touchUpInside)
        fanButton.addTarget(self, action: #selector(onPressFanButton), for: .touchUpInside)
        teamButton.addTarget(self, action: #selector(onPressTeamButton), for: .touchUpInside)
    }
    
    @objc
    func onPressBJButton() {
        viewModel?.changeListType(to: .bj)
    }
    
    @objc
    func onPressFanButton() {
        viewModel?.changeListType(to: .fan)
    }
    
    @objc
    func onPressTeamButton() {
        viewModel?.changeListType(to: .team)
    }
}
