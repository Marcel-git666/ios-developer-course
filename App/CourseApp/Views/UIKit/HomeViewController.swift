//
//  HomeViewController.swift
//  CourseApp
//
//  Created by Marcel Mravec on 10.05.2024.
//

import Combine
import os
import SwiftUI
import UIKit

final class HomeViewController: UIViewController {
    @IBOutlet private var categoriesCollectionView: UICollectionView!
    let logger = Logger()
    // MARK: - DataSource
    private lazy var dataProvider = MockDataProvider()
    typealias DataSource = UICollectionViewDiffableDataSource<SectionData, [Joke]>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SectionData, [Joke]>
    private lazy var dataSource = makeDataSource()
    private lazy var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
}

// MARK: - UICollectionViewDataSource
private extension HomeViewController {
    func readData() {
        dataProvider.$data.sink { [weak self] data in
            self?.logger.log(level: .info, "The value is \(data)")
            self?.applySnapshot(data: data, animatingDifferences: true)
        }
        .store(in: &cancellables)
    }
    
    func applySnapshot(data: [SectionData], animatingDifferences: Bool = true) {
        guard dataSource.snapshot().numberOfSections == 0 else {
            //
            return
        }
        
        var snapshot = Snapshot()
        snapshot.appendSections(data)
        
        data.forEach { section in
            snapshot.appendItems([section.jokes], toSection: section)
        }
        
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: categoriesCollectionView) { collectionView, indexPath, joke in
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]

            let horizontalCell: HorizontalScrollingImageCell = collectionView.dequeueReusableCell(for: indexPath)
            horizontalCell.images = joke.map { $0.image }
            return horizontalCell
        }
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else {
                return nil
            }
            
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            let labelCell: LabelCollectionViewCell = collectionView.dequeueSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath)
            labelCell.nameLabel.text = section.title
            return labelCell
        }
        return dataSource
    }
}

// MARK: - UISetup

private extension HomeViewController {
    func setup() {
        setupCollectionView()
        readData()
    }
    
    func setupCollectionView() {
        categoriesCollectionView.backgroundColor = .systemMint
        categoriesCollectionView.isPagingEnabled = true
        categoriesCollectionView.contentInsetAdjustmentBehavior = .never
        categoriesCollectionView.showsVerticalScrollIndicator = false
        categoriesCollectionView.delegate = self
        categoriesCollectionView.register(HorizontalScrollingImageCell.self)
        categoriesCollectionView.register(LabelCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)

        let interitemSpacing: CGFloat = 10
        let minimumLineSpacing: CGFloat = 8
        let sectionInset: CGFloat = 4
        let headerSize: CGFloat = 30
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // Change this to vertical
        layout.minimumLineSpacing = minimumLineSpacing // Spacing here is not necessary, but adds a better inset for horizontal scrolling. Gives you a tiny peek of the background.
        layout.minimumInteritemSpacing = interitemSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionInset, bottom: 0, right: sectionInset)
        layout.sectionHeadersPinToVisibleBounds = true
        layout.headerReferenceSize = CGSize(width: categoriesCollectionView.contentSize.width, height: headerSize)
        categoriesCollectionView.setCollectionViewLayout(layout, animated: false)
    }
}

// MARK: - HELPER
struct HomeView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> HomeViewController {
        //        let storyboard = UIStoryboard(name: "HomeViewController", bundle: nil)
        //        if let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
        //            return viewController
        //        }
        HomeViewController()
    }
    
    func updateUIViewController(_ uiViewController: HomeViewController, context: Context) {
    }
}
