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
            backgroundColor = UIColor(red: 0.9, green: 0.85, blue: 1.0, alpha: 1.0)
 // Light peach-like color

                // Customize border and corners
                layer.cornerRadius = 8 // Round the corners for a smooth look
                layer.borderWidth = 1  // Set border width
            layer.borderColor = UIColor.black.cgColor // Set border color

                // Add shadow for depth
                layer.shadowColor = UIColor.black.cgColor // Set shadow color
                layer.shadowOpacity = 0.1 // Set shadow opacity
                layer.shadowOffset = CGSize(width: 0, height: 1) // Set shadow offset
                layer.shadowRadius = 3 // Set shadow radius

                // Ensure content stays within the rounded corners
                clipsToBounds = true
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
