import UIKit
import SnapKit
import Then

final class MainBannerCollectionView: UICollectionView {
    var viewModel: DallaViewModel?
    
    var isHolding = false
    var bannerIndex: CGFloat = 0.0
    var timer: DispatchSourceTimer?
    let timerInterval = 5
    
    let flowlayout = UICollectionViewFlowLayout().then {
        $0.minimumLineSpacing = 0
        $0.scrollDirection = .horizontal
    }
    
    init(viewModel: DallaViewModel) {
        super.init(frame: .zero, collectionViewLayout: flowlayout)
        self.isPagingEnabled = true
        self.showsHorizontalScrollIndicator = false
        
        self.viewModel = viewModel
        
        viewModel.topOffsetY.bind { [weak self] offset in
            guard let self = self else { return }
            
            let translateValue  = (offset - Constants.statusBarHeight) / 2,
                viewHeight      = Constants.deviceSize.width,
                scale           = 1 + (-1 * (offset + Constants.statusBarHeight) / viewHeight)
            
            self.transform = CGAffineTransform(translationX: 0, y: translateValue).scaledBy(x: scale, y: scale)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
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
    
    func moveToNext() {
        guard !isHolding else { return }
        
        let nextPageIndex = round((self.contentOffset.x + self.frame.width) / self.frame.width),
            nextPageOffset = CGPoint(x: nextPageIndex * self.frame.width, y: 0)
        
        self.setContentOffset(nextPageOffset, animated: true)
    }
        
    func initialize(data: [DallaBannerInfo]) {
        self.isPagingEnabled = true
        self.showsHorizontalScrollIndicator = false
        
        addTimer()
    }
}
