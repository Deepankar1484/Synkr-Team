//
//  RecentAwardCell.swift
//  Synkr
//
//  Created by student-2 on 20/01/25.
//

import UIKit

class RecentAwardCell: UICollectionViewCell {
    override func awakeFromNib() {
            super.awakeFromNib()
            
            // Set border and corner radius
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.gray.cgColor
            self.layer.cornerRadius = 10
            
            // Align text properly
            trophyName.textAlignment = .center
            awardDescription.textAlignment = .center
            dateEarned.textAlignment = .center
        }
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var trophyName: UILabel!
    
    
    @IBOutlet weak var awardDescription: UILabel!
    
    
    @IBOutlet weak var dateEarned: UILabel!
    
    
}
