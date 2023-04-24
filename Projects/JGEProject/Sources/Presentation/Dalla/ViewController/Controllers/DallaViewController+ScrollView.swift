import UIKit

extension DallaViewController:  UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView is MainBannerCollectionView {
            manageMainBannerPaging()
        } else {
            changeMainBannerTransform(offsetY: scrollView.contentOffset.y)
        }
    }
    
    private func manageMainBannerPaging() {
        let offsetX = mainBannerView.contentOffset.x
        let contentWidth = mainBannerView.contentSize.width
        let scrollViewWidth = mainBannerView.frame.width
        
        if offsetX < 0 {
            mainBannerView.contentOffset.x = contentWidth - scrollViewWidth
        } else if offsetX > contentWidth - scrollViewWidth {
            mainBannerView.contentOffset.x = 0
        }
    }
    
    private func changeMainBannerTransform(offsetY: CGFloat) {
        print(offsetY)
        if offsetY < -Constants.statusBarHeight {
            viewModel.topOffsetY.value = offsetY
        } else if offsetY >= -Constants.statusBarHeight {
            viewModel.topOffsetY.value = -Constants.statusBarHeight
        }
        
        if offsetY >= 50 && offsetY <= 250 {
            let alphaValue = (offsetY - 150) / 100
            headerWrapeprView.alpha = alphaValue
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        mainBannerView.isHolding = true
        mainBannerView.suspendTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        mainBannerView.resumeTimer()
        
        if !decelerate {
            mainBannerView.isHolding = false
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        mainBannerView.isHolding = false
    }
}
