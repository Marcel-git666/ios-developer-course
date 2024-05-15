//
//  HorizontalScrollingImageCell.swift
//  CourseApp
//
//  Created by Marcel Mravec on 13.05.2024.
//

import UIKit

class HorizontalScrollingImageCell: UICollectionViewCell, ReusableIdentifier {
    // MARK: - Properties
    // swiftlint:disable implicitly_unwrapped_optional
    private var collectionView: UICollectionView!
    // swiftlint:enable implicitly_unwrapped_optional
    var images: [UIImage?] = []
    
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
        setupCollectionView()
        addSubviews()
        setupConstraints()
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        self.collectionView = UICollectionView(frame: contentView.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCollectionViewCell.self)
        
        layout.itemSize = CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func addSubviews() {
        contentView.addSubview(collectionView)
    }
    
    func setupConstraints() {
        let border: CGFloat = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: border),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -border),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: border),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -border)
        ])
    }
}

extension HorizontalScrollingImageCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as ImageCollectionViewCell
        cell.imageView.image = images[indexPath.item]
        return cell
    }
}

extension HorizontalScrollingImageCell: UICollectionViewDelegate {
}
