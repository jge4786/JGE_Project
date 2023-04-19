//
//  TableViewCellBase.swift
//  ChatRoom
//
//  Created by 여보야 on 2023/03/23.
//

import UIKit

protocol DallaCollectionViewCellBase {
    static func register(collectionView: UICollectionView)
    static func dequeueReusableCell(collectionView: UICollectionView, indexPath: IndexPath) -> Self?
    static var reuseIdentifier: String { get }
    static var NibName: String { get }
}

extension DallaCollectionViewCellBase where Self: UICollectionViewCell {
    static func register(collectionView: UICollectionView) {
        collectionView.register(self, forCellWithReuseIdentifier: self.reuseIdentifier)
    }
    
    static func dequeueReusableCell(collectionView: UICollectionView, indexPath: IndexPath) -> Self? {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath) as? Self else {
            return nil
        }
        
        return cell
    }
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var NibName: String {
        return String(describing: self)
    }
}
