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
    private var didTapCallback: Action<Joke>?
    private var didLikeCallback: Action<Joke>?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setup
    
    func setup() {
        addSubviews()
        setupCollectionView()
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
        collectionView.isPagingEnabled = true
        
        setupCollectionViewLayout()
    }
    
    func setupCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = UIConst.cellSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: UIConst.sectionInset, bottom: 0, right: UIConst.sectionInset)
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    func addSubviews() {
        addSubview(collectionView)
    }
    
    func setupConstraints() {
        let border: CGFloat = 5
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: border),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -border),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: border),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -border)
        ])
    }
}

// MARK: - Public methods
extension HorizontalScrollingImageCell {
    func configure(_ data: [Joke], callback: Action<Joke>? = nil, likedCallback: Action<Joke>? = nil) {
        self.data = data
        collectionView.reloadData()
        self.didTapCallback = callback
        self.didLikeCallback = likedCallback
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
        let joke = data[indexPath.row]
        cell.contentConfiguration = UIHostingConfiguration { [weak self] in
            if let url = try? ImagesRouter.size300x200.asURLRequest().url {
                AsyncImage(url: url) { image in
                    image
                        .resizableBordered()
                        .scaledToFit()
                } placeholder: {
                    Color.gray
                }
            } else {
                Text("Error")
            }
            Button(action: {
                self?.didLikeCallback?(joke)
            }, label: {
                Image(systemName: "heart")
            })
            .buttonStyle(SelectableButtonStyle(isSelected: .constant(joke.liked), color: Color.gray))
            
        }
        return cell
    }
}

extension HorizontalScrollingImageCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        logger.info("Horizontal scrolling did select item \(indexPath)")
        print("Category: \(data[indexPath.row].categories)")
        didTapCallback?(data[indexPath.row])
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
