//
//  HomeViewController+Ext.swift
//  CourseApp
//
//  Created by Marcel Mravec on 15.05.2024.
//

import SwiftUI
import UIKit

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width // Use full width for horizontal scrolling
        let height: CGFloat = 250   // Maintain aspect ratio (assuming all images have similar heights)
        return CGSize(width: width, height: height)
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.logger.log("I have tapped \(indexPath)")
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.logger.log("Will display \(indexPath)")
    }
}
