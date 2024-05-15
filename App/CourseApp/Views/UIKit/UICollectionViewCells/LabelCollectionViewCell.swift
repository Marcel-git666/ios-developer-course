//
//  LabelCollectionViewCell.swift
//  CourseApp
//
//  Created by Marcel Mravec on 12.05.2024.
//

import UIKit

final class LabelCollectionViewCell: UICollectionViewCell, ReusableIdentifier {
    lazy var nameLabel = UILabel()
    
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
private extension LabelCollectionViewCell {
    func setupUI() {
        addSubviews()
        configureLabel()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(nameLabel)
    }
    
    func configureLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .white
    }
    
    func setupConstraints() {
        let padding: CGFloat = 5
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
        ])
    }
}
