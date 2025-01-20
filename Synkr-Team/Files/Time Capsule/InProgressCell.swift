//
//  InProgressCell.swift
//  Synkr
//
//  Created by student-2 on 17/01/25.
//

import UIKit

class InProgressCell: UICollectionViewCell {
    
    
    @IBOutlet weak var capsuleName: UILabel!
    
    
    @IBOutlet weak var deadlineLabel: UILabel!
    
    
    @IBOutlet weak var ProgressBar: CircularProgressBar!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            setupAppearance()
        }
        
        func setupAppearance() {
            // Add a border and shadow to the cell to make it visually appealing
            layer.cornerRadius = 8 // Round the corners for a smooth look
            layer.borderWidth = 1  // Set border width
            layer.borderColor = UIColor.systemOrange.cgColor // Set border color
            layer.shadowColor = UIColor.black.cgColor // Set shadow color
            layer.shadowOpacity = 0.1 // Set shadow opacity
            layer.shadowOffset = CGSize(width: 0, height: 1) // Set shadow offset
            layer.shadowRadius = 3 // Set shadow radius
            clipsToBounds = true // Ensure content stays within the rounded corners
        }

        func configureCell(with capsule: TimeCapsule) {
            capsuleName.text = capsule.capsuleName
            
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            deadlineLabel.text = "Deadline: " + formatter.string(from: capsule.deadline)
            
            // Use setProgress method to update the progress
            ProgressBar.setProgress(to: CGFloat(capsule.completionPercentage), animated: true)
        }
    
    
}
