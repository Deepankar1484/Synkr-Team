//
//  TimeCapsuleCell.swift
//  Synkr
//
//  Created by student-2 on 17/01/25.
//

import UIKit

class TimeCapsuleCell: UICollectionViewCell {
    
    
    @IBOutlet weak var capsuleName: UILabel!
    
    
    @IBOutlet weak var deadlineLabel: UILabel!
    
    
    @IBOutlet weak var checkMark: UIImageView!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            setupAppearance()
        }
        
        func setupAppearance() {
            
            backgroundColor = UIColor(red: 0.9, green: 0.85, blue: 1.0, alpha: 1.0)

            // Add border and padding to the cell
            layer.cornerRadius = 8
            layer.borderWidth = 2  // Increased border width for visibility
            layer.borderColor = UIColor.black.cgColor
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.1
            layer.shadowOffset = CGSize(width: 0, height: 1)
            layer.shadowRadius = 2
            
            // Ensure clipsToBounds is false to avoid clipping borders
            clipsToBounds = false
        }
        
        func configureCell(with capsule: TimeCapsule) {
            capsuleName.text = capsule.capsuleName
            capsuleName.numberOfLines = 2  // Adjust number of lines for label if needed
            
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            deadlineLabel.text = "Deadline: " + formatter.string(from: capsule.deadline)
            
            // Ensure checkmark visibility and correct image setting
            if capsule.completionPercentage >= 1.0 {
                checkMark.image = UIImage(systemName: "checkmark.circle.fill")
                checkMark.tintColor = .systemGreen
                checkMark.isHidden = false
            } else {
                checkMark.isHidden = true
            }
        }
   
}
