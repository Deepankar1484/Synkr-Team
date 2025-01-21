//
//  EarnedAwardCell.swift
//  Synkr
//
//  Created by student-2 on 20/01/25.
//

import UIKit

class EarnedAwardCell: UICollectionViewCell {

    override func awakeFromNib() {
            super.awakeFromNib()
            
            // Set border and corner radius
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.gray.cgColor
            self.layer.cornerRadius = 10
            
            // Align text properly
            awardTitle.textAlignment = .center
            dateEarned.textAlignment = .center
        }

    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var awardTitle: UILabel!
    
    
    @IBOutlet weak var dateEarned: UILabel!
}
