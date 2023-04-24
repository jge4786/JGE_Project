import UIKit
import SnapKit
import Then
import Kingfisher

class MainBannerCell: UICollectionViewCell, DallaCollectionViewCellBase {
    var isHolding = false
    var bannerIndex: CGFloat = 0.0
    var timer: DispatchSourceTimer?
    let timerInterval = 5
    
    var data: DallaBannerInfo?
    
    var imageView = UIImageView()
    
    var labelView = MainBannerLabelView()
    
    func changeScale(to scale: Double) {
        let width = self.frame.width
        
        guard width != 0 else { return }
        
        labelView.transform = CGAffineTransform(scaleX: 1 / scale, y: 1 / scale)
    }
    
    func initialize(data: DallaBannerInfo) {
        self.data = data
        setSubViews()
        setConstraints()
        setData()
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.bounds
        
        let colors: [CGColor] = [
            .init(gray: 1, alpha: 0),
            .init(gray: 1, alpha: 0),
            .init(gray: 1, alpha: 1)
        ]
        
        gradientLayer.colors = colors
    }
    
    func setSubViews() {
        self.addSubview(imageView)
        self.addSubview(labelView)
    }
    
    func setConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        labelView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
            $0.height.equalTo(156)
        }
        layoutSubviews()
    }
    
    func setData() {
        
        let url = URL(string: data?.imageBackground ?? "")
        imageView.kf.setImage(with: url, placeholder: UIImage(named: "defaultBanner"))
        
        
        labelView.setData(title: "\(data?.title ?? "")",
                          bjName: data?.memNick ?? "홍길동",
                          isStar: data?.badgeSpecial ?? false)
        
    }
}
