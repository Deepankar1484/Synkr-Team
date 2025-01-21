//
//  CollectionReusableView.swift
//  Synkr
//
//  Created by student-2 on 21/01/25.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {
    static let reuseIdentifier = "SectionHeaderView"
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.boldSystemFont(ofSize: 18)
            label.textColor = .black
            return label
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupView()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupView()
        }
        
        private func setupView() {
            addSubview(titleLabel)
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
}
