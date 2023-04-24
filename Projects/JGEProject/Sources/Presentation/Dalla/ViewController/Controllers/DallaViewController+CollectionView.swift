///메인 배너 UICollectionView delegate

import UIKit

extension DallaViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Constants.deviceSize.width
        return CGSize(width: width, height: width)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = viewModel.data.value?.count else { return 0 }
        
        return count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = MainBannerCell.dequeueReusableCell(collectionView: mainBannerView, indexPath: indexPath) else {
            return UICollectionViewCell()
        }
        var index = indexPath.row
        if index == viewModel.data.value!.count { index = 0 }
        
        cell.initialize(data: viewModel.data.value![index])
        return cell
    }
}



