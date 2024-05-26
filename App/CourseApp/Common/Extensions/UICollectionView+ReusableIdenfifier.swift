//
//  UICollectionView+ReusableIdenfifier.swift
//  CourseApp
//
//  Created by Marcel Mravec on 10.05.2024.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableIdentifier {
        register(T.self, forCellWithReuseIdentifier: T.identifier)
    }
    
    func register<T: UICollectionViewCell>(_: T.Type, forSupplementaryViewOfKind: String) where T: ReusableIdentifier {
        register(
            T.self,
            forSupplementaryViewOfKind: forSupplementaryViewOfKind,
            withReuseIdentifier: T.identifier
        )
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableIdentifier {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Cell with identifier: \(T.identifier) could not be dequeued!")
        }
        
        return cell
    }
    
    func dequeueSupplementaryView<T: UICollectionViewCell>(ofKind: String, for indexPath: IndexPath) -> T where T: ReusableIdentifier {
        guard let cell = dequeueReusableSupplementaryView(
            ofKind: ofKind,
            withReuseIdentifier: T.identifier,
            for: indexPath
        ) as? T else {
            fatalError("SupplementaryView with identifier: \(T.identifier) could not be dequeued!")
        }
        
        return cell
    }
}
