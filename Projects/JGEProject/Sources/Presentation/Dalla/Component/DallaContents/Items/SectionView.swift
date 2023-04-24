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
    
    var firstSeperatorBar = UIView().then {
        $0.backgroundColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
    }
    var secondSeperatorBar = UIView().then {
        $0.backgroundColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
    }
    
    var bjButton = TabButton(type: .bj)
    
    var fanButton = TabButton(type: .fan)
    
    var teamButton = TabButton(type: .team)
    
    convenience init(viewModel: DallaViewModel, title: String, hasTabBar: Bool = false) {
        self.init(frame: .zero)
        self.title = title
        self.hasTabBar = hasTabBar
        self.viewModel = viewModel
        
        setSubViews()
        setConstraints()
        setData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setSubViews() {
        self.addArrangedSubview(titleButton)
        
        if hasTabBar {
            self.addArrangedSubview(sectionTabBar)
            sectionTabBar.addArrangedSubview(bjButton)
            sectionTabBar.addArrangedSubview(firstSeperatorBar)
            sectionTabBar.addArrangedSubview(fanButton)
            sectionTabBar.addArrangedSubview(secondSeperatorBar)
            sectionTabBar.addArrangedSubview(teamButton)
        } else {
            self.addArrangedSubview(UIView())
        }
    }
    
    func setConstraints() {
        self.snp.makeConstraints {
            $0.height.equalTo(26)
        }
        
        guard hasTabBar else { return }
        firstSeperatorBar.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.height.equalTo(10)
        }
        
        secondSeperatorBar.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.height.equalTo(10)
        }
    }
    
    func setData() {
        self.alignment = .center
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
        
        self.bjButton.changeSelectedState(to: true)
        self.fanButton.changeSelectedState(to: false)
        self.teamButton.changeSelectedState(to: false)
    }
    
    @objc
    func onPressFanButton() {
        viewModel?.changeListType(to: .fan)
        
        self.bjButton.changeSelectedState(to: false)
        self.fanButton.changeSelectedState(to: true)
        self.teamButton.changeSelectedState(to: false)
    }
    
    @objc
    func onPressTeamButton() {
        viewModel?.changeListType(to: .team)
        
        self.bjButton.changeSelectedState(to: false)
        self.fanButton.changeSelectedState(to: false)
        self.teamButton.changeSelectedState(to: true)
    }
}
