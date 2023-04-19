import UIKit
import SnapKit
import Then
import SwiftyJSON

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
        
        let targetView = (self.imageStackView.subviews[Int(trunc((self.contentOffset.x + width) / width)) - 1] as! MainBannerLabelView)
        
        targetView.transform = CGAffineTransform(scaleX: scale, y: scale)
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
            let view = MainBannerLabelView()
            
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
        
        for (index, view) in imageStackView.subviews.enumerated() {
            let view = view as! MainBannerLabelView
            
            
            if index == imageStackView.subviews.count - 1 {
                view.setData(title: "0\(index)_\(data[0]["title"].stringValue)", bjName: data[0]["mem_nick"].stringValue, isStar: data[0]["badgeSpecial"] == 1)
            } else {
                view.setData(title: "\(index)_\(data[index]["title"].stringValue)", bjName: data[index]["mem_nick"].stringValue, isStar: data[index]["badgeSpecial"] == 1)
            }
        }
        
    }
}
