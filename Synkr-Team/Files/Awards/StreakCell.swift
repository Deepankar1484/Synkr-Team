//
//  StreakCell.swift
//  Synkr
//
//  Created by student-2 on 20/01/25.
//

import UIKit

class StreakCell: UICollectionViewCell {

    override func awakeFromNib() {
            super.awakeFromNib()
            
            // Set border and corner radius
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.gray.cgColor
            self.layer.cornerRadius = 10
            
            // Align text properly
            currentStreakLabel.textAlignment = .center
            maxStreakLabel.textAlignment = .center
        }
    
    @IBOutlet weak var currentStreakLabel: UILabel!
    
    @IBOutlet weak var maxStreakLabel: UILabel!
    
    
}
