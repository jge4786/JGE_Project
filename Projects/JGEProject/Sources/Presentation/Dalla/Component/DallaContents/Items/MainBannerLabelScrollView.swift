import UIKit
import SnapKit
import Then
import SwiftyJSON

class MainBannerLabelScrollView: UIScrollView {
    let stackViewSpacing: CGFloat = 9.0
    
    var labelStackView = UIStackView()
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initialize(data: JSON) {
        setSubViews(data: data)
        setConstraints()
        setData()
    }
    
    func setSubViews(data: JSON) {
        for index in 0...data.count {
            var index = index
            if index == data.count { index = 0 }
            
            let view = MainBannerLabelView().then {
                $0.setData(
                    title: "0\(index)_\(data[index]["title"].stringValue)",
                    bjName: data[index]["mem_nick"].stringValue,
                    isStar: data[index]["badgeSpecial"] == 1)
            }
            
            labelStackView.addArrangedSubview(view)
        }
    }
    
    func setConstraints() {
        labelStackView.subviews.forEach {
            $0.snp.makeConstraints {
                $0.width.equalTo(Constants.deviceSize.width * 2)
            }
        }
    }
    
    func setData() {
    }
    
    
}
