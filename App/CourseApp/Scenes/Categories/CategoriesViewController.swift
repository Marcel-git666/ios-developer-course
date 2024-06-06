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

final class CategoriesViewController: UIViewController {
    // swiftlint:disable:next prohibited_interface_builder
    @IBOutlet private var categoriesCollectionView: UICollectionView!
    
    private enum UIConstants {
        static let cellSpacing: CGFloat = 8
        static let sectionInset: CGFloat = 4
        static let sectionScale: CGFloat = 3
        static let headerHeight: CGFloat = 104
        static let headerFontSize: CGFloat = 36
    }
    // MARK: - DataSource
    private let dataProvider = MockDataProvider()
    typealias DataSource = UICollectionViewDiffableDataSource<SectionData, [Joke]>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SectionData, [Joke]>
    private lazy var dataSource = makeDataSource()
    private lazy var cancellables = Set<AnyCancellable>()
    private let logger = Logger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        title = "Categories"
        
        Task {
            let apiManager = APIManager()
            do {
                let joke: JokeResponse = try await apiManager.request(JokesRouter.getRandomJoke)
                print("🤣 \(joke) 🤣")
            } catch {
                showInfoAlert(title: "Error: \(error)")
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - UIConstants.cellSpacing
        let height: CGFloat = collectionView.bounds.height / UIConstants.sectionScale
        return CGSize(width: width, height: height)
    }
}

// MARK: - UICollectionViewDelegate
extension CategoriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.logger.info("Home collection view did select item at \(indexPath)")
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.logger.info("Home collection view cell will display \(indexPath)")
    }
}

// MARK: - UISetup
private extension CategoriesViewController {
    func setup() {
        setupCollectionView()
        readData()
    }
    
    func setupCollectionView() {
        categoriesCollectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
        
        categoriesCollectionView.backgroundColor = .bg
        categoriesCollectionView.isPagingEnabled = true
        categoriesCollectionView.contentInsetAdjustmentBehavior = .never
        categoriesCollectionView.showsVerticalScrollIndicator = false
        categoriesCollectionView.delegate = self
        setupCollectionViewLayout()
    }
    
    func setupCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = UIConstants.cellSpacing
        layout.minimumInteritemSpacing = UIConstants.cellSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: UIConstants.sectionInset, bottom: 0, right: UIConstants.sectionInset)
        layout.sectionHeadersPinToVisibleBounds = true
        layout.headerReferenceSize = CGSize(width: categoriesCollectionView.contentSize.width, height: UIConstants.headerHeight)
        categoriesCollectionView.setCollectionViewLayout(layout, animated: false)
    }
}

// MARK: - UICollectionViewDataSource
private extension CategoriesViewController {
    func readData() {
        dataProvider.$data.sink { [weak self] data in
            self?.logger.log(level: .info, "The value is \(data)")
            self?.applySnapshot(data: data, animatingDifferences: true)
        }
        .store(in: &cancellables)
    }
    
    func applySnapshot(data: [SectionData], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(data)
        
        data.forEach { section in
            snapshot.appendItems([section.jokes], toSection: section)
        }
        
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    func makeDataSource() -> DataSource {
        let cellRegistration = UICollectionView.CellRegistration<HorizontalScrollingImageCell, [Joke]> { cell, _, item in
            cell.setData(item)
        }
        
        let dataSource = DataSource(collectionView: categoriesCollectionView) { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else {
                return nil
            }
            
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            let labelCell: UICollectionViewCell = collectionView.dequeueSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                for: indexPath
            )
            labelCell.contentConfiguration = UIHostingConfiguration {
                Text(section.title)
                    .textTypeModifier(textType: .sectionTitle)
            }
            return labelCell
        }
        return dataSource
    }
}

private extension CategoriesViewController {
    func fetchData() {
        Task {
            //
        }
    }
}
