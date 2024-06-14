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
    // MARK: - IBOutlets
    // swiftlint:disable:next prohibited_interface_builder
    @IBOutlet private var categoriesCollectionView: UICollectionView!
    
    private enum UIConstants {
        static let cellSpacing: CGFloat = 8
        static let sectionInset: CGFloat = 4
        static let sectionScale: CGFloat = 3
        static let headerHeight: CGFloat = 40
    }
    // MARK: - DataSource
    typealias DataSource = UICollectionViewDiffableDataSource<SectionData, [Joke]>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SectionData, [Joke]>

    // MARK: - Private variables
    private lazy var dataSource = makeDataSource()
    private let jokeService: JokeServicing = JokeService(apiManager: APIManager())
    @Published private var data = [SectionData]()
    private lazy var cancellables = Set<AnyCancellable>()
    private let eventSubject = PassthroughSubject<CategoriesViewEvent, Never>()
    private let logger = Logger()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        title = "Categories"
        fetchData()
    }
}

// MARK: - EventEmitting
extension CategoriesViewController: EventEmitting {
    var eventPublisher: AnyPublisher<CategoriesViewEvent, Never> {
        eventSubject.eraseToAnyPublisher()
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
        $data.sink { [weak self] data in
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
            cell.configure(item) { [weak self] item in
                self?.eventSubject.send(.itemTapped(item))
            }
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

// MARK: - Data fetching
extension CategoriesViewController {
    func fetchData() {
        let numberOfJokesToLoad = 5
        Task {
            do {
                let categories = try await jokeService.fetchCategories()
                try await withThrowingTaskGroup(of: JokeResponse.self) { [weak self] group in
                    guard let self else {
                        return
                    }
                    for category in categories {
                        for _ in 1...numberOfJokesToLoad {
                            group.addTask {
                                try await self.jokeService.fetchJokeForCategory(category)
                            }
                        }
                    }
                    var jokeResponses = [JokeResponse]()
                    
                    for try await jokeResponse in group {
                        jokeResponses.append(jokeResponse)
                    }
                    let dataDictionary = Dictionary(grouping: jokeResponses) { $0.categories.first ?? "" }
                    for key in dataDictionary.keys {
                        data.append(SectionData(title: key, jokes: dataDictionary[key] ?? []))
                    }
                }
            } catch let error as NetworkingError {
                showInfoAlert(title: "Networking error: \(error)")
            } catch {
                showInfoAlert(title: "Unknown error.")
            }
        }
    }
}
