//
//  HorizontalScrollingImageCell.swift
//  CourseApp
//
//  Created by Marcel Mravec on 13.05.2024.
//

import os
import SwiftUI
import UIKit

class HorizontalScrollingImageCell: UICollectionViewCell {
    // MARK: - Properties
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var data: [Joke] = []
    private lazy var logger = Logger()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    private var didTapCallBack: Action<Joke>?
    
    // MARK: - Setup
    
    func setup() {
        setupCollectionView()
        addSubviews()
        setupConstraints()
    }
    
    func setupCollectionView() {
        collectionView.register(UICollectionViewCell.self)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .bg
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        
        setupCollectionViewLayout()
    }
    
    func setupCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: UIConst.sectionInset, bottom: 0, right: UIConst.sectionInset)
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    func addSubviews() {
        contentView.addSubview(collectionView)
    }
    
    func setupConstraints() {
        let border: CGFloat = 5
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: border),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -border),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: border),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -border)
        ])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HorizontalScrollingImageCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: collectionView.bounds.width - UIConst.cellSpacing, height: collectionView.bounds.height)
    }
}

extension HorizontalScrollingImageCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.contentConfiguration = UIHostingConfiguration {
            if let url = try? ImagesRouter.size300x200.asURLRequest().url {
                AsyncImage(url: url) { image in
                    image
                        .resizableBordered()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
            } else {
                Text("Error")
            }
        }
        return cell
    }
}

extension HorizontalScrollingImageCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        logger.info("Horizontal scrolling did select item \(indexPath)")
        //        didTapCallBack?(data[indexPath.row])
    }
}

// MARK: - Public methods
extension HorizontalScrollingImageCell {
    func setData(_ data: [Joke]) {
        self.data = data
        collectionView.reloadData()
    }
}

extension HorizontalScrollingImageCell {
    enum UIConst {
        static let normalImageRadius: CGFloat = 10
        static let cellSpacing: CGFloat = 8
        static let sectionInset: CGFloat = 4
    }
}
