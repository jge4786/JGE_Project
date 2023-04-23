import UIKit
import SnapKit
import Then
import SwiftyJSON
import Kingfisher

class MainBannerImageScrollView: UIScrollView {
    var isHolding = false
    var bannerIndex: CGFloat = 0.0
    var timer: DispatchSourceTimer?
    let timerInterval = 5
    
    
    var imageStackView = UIStackView()
    
    func resumeTimer() {
        print("resume")
        timer?.resume()
    }
    
    func suspendTimer() {
        print("suspend")
        timer?.suspend()
    }
    
    func stopTimer() {
        print("stop")
        timer?.cancel()
        timer = nil
    }
    
    func addTimer() {
        guard timer == nil else { return } // initialize와 willViewAppear에서의 중복 호출 방지
        
        timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        
        timer?.schedule(deadline: .now() + .seconds(timerInterval), repeating: DispatchTimeInterval.seconds(timerInterval))
        
        timer?.setEventHandler(handler: moveToNext)
        
        timer?.resume()
    }
    
    func changeScale(to scale: Double) {
        let width = self.frame.width
        
        guard width != 0 else { return }
        
        let targetView = (self.imageStackView.subviews[Int(trunc((self.contentOffset.x + width) / width)) - 1]).subviews[1]
        
        targetView.transform = CGAffineTransform(scaleX: 1 / scale, y: 1 / scale)
    }
    
    func moveToNext() {
        guard !isHolding else { return }
        
        let nextPageIndex = trunc((self.contentOffset.x + self.frame.width) / self.frame.width),
            nextPageOffset = CGPoint(x: nextPageIndex * self.frame.width, y: 0)
        
        
        
        self.setContentOffset(nextPageOffset, animated: true)
    }
        
    func initialize(data: JSON) {
        self.isPagingEnabled = true
        self.showsHorizontalScrollIndicator = false
        setSubViews(count: data.count)
        setConstraints()
        setData(data: data)
        
        addTimer()
    }
    
    func setSubViews(count: Int) {
        self.addSubview(imageStackView)
        
        for index in 0...count {
            var view = UIView()
            let labelView = MainBannerLabelView()
            let button = UIButton()
            
            view.addSubview(button)
            view.addSubview(labelView)
            
            button.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            
            labelView.snp.makeConstraints {
                $0.bottom.equalToSuperview()
            }
            
            
            imageStackView.addArrangedSubview(view)
            
        }
    }
    
    func setConstraints() {
        imageStackView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.height.equalToSuperview()
        }
        
        imageStackView.subviews.forEach {
            $0.snp.makeConstraints {
                $0.height.equalToSuperview()
                $0.width.equalTo(Constants.deviceSize.width)
            }
        }
    }
        
    func setData(data: JSON) {
        
        for (index, subView) in imageStackView.subviews.enumerated() {
            subView.subviews.forEach {
                if let view = $0 as? UIButton {
                    let index = (index == imageStackView.subviews.count - 1)
                                ? 0
                                : index
                    
                    let url = URL(string: data[index]["image_background"].stringValue)
                    view.kf.setImage(with: url, for: .normal, completionHandler:  { _ in
                        let gradientLayer = CAGradientLayer()
                        gradientLayer.frame = view.bounds
                        let colors: [CGColor] = [
                            .init(gray: 1, alpha: 0),
                            .init(gray: 1, alpha: 0),
                            .init(gray: 1, alpha: 1)
                        ]
                        
                        gradientLayer.colors = colors
                        
                        view.layer.addSublayer(gradientLayer)
                    })
                } else if let view = $0 as? MainBannerLabelView {
                    if index == imageStackView.subviews.count - 1 {
                        view.setData(title: "0\(index)_\(data[0]["title"].stringValue)", bjName: data[0]["mem_nick"].stringValue, isStar: data[0]["badgeSpecial"] == 1)
                    } else {
                        view.setData(title: "\(index)_\(data[index]["title"].stringValue)", bjName: data[index]["mem_nick"].stringValue, isStar: data[index]["badgeSpecial"] == 1)
                    }
                }
                
                
                
            }
        }
        
    }
}
