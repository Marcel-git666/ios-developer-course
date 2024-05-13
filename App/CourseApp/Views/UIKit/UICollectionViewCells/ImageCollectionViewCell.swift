//
//  ImageCollectionViewCell.swift
//  CourseApp
//
//  Created by Marcel Mravec on 13.05.2024.
//

import UIKit

final class ImageCollectionViewCell: UICollectionViewCell, ReusableIdentifier {
    // MARK: UI items
    let imageView: UIImageView = {
        let imageView = UIImageView()
        let cornerRadius: CGFloat = 10
        imageView.layer.cornerRadius = cornerRadius
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup UI
private extension ImageCollectionViewCell {
    func setupUI() {
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        addSubview(imageView)
    }

    func setupConstraints() {
        let border: CGFloat = 5
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: border),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: border),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -border),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -border)
        ])
    }
}
