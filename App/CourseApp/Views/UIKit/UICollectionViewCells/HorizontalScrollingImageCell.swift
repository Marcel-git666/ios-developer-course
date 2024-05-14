//
//  HorizontalScrollingImageCell.swift
//  CourseApp
//
//  Created by Marcel Mravec on 13.05.2024.
//

import UIKit

class HorizontalScrollingImageCell: UICollectionViewCell, ReusableIdentifier {
    
    // MARK: - Properties
    
    private var collectionView: UICollectionView!
    private var images: [UIImage?] = []
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImages(_ images: [UIImage]) {
        self.images = images
        collectionView.reloadData()
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
    }
    
    func addSubviews() {
        contentView.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
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
