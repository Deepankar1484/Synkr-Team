//
//  CategoryCollectionViewCell.swift
//  Synkr-Team
//
//  Created by Deepankar Garg on 17/01/25.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var categoryImage: UIImageView!
    @IBOutlet var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    func configure(with category: Category) {
        // Set category name
        categoryName.text = category.rawValue
        // Set category image
        categoryImage.image = category.taskImage
        // Set background color
        self.backgroundColor = category.customCategory.categoryColor
        
        // Optionally, set insights
//        insightsLabel?.text = category.customCategory.insights
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
    }
}
