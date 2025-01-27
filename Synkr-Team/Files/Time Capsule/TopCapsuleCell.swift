//
//  TopCapsuleCell.swift
//  Synkr
//
//  Created by student-2 on 17/01/25.
//

import UIKit

class TopCapsuleCell: UICollectionViewCell {
    
    
    @IBOutlet weak var capsuleName: UILabel!
    
    
    @IBOutlet weak var capsuleDeadline: UILabel!
    
    
    @IBOutlet weak var ProgressBar: CircularProgressBar!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            setupAppearance()
        }
        
        func setupAppearance() {
            // Add border, padding, and shadow
            backgroundColor = UIColor(red: 0.9, green: 0.85, blue: 1.0, alpha: 1.0)
                    
                    // Customize border
                    layer.cornerRadius = 10
                    layer.borderWidth = 1
                    layer.borderColor = UIColor.black.cgColor
                    
                    // Add shadow
                    layer.masksToBounds = false
                    layer.shadowColor = UIColor.black.cgColor
                    layer.shadowOpacity = 0.2
                    layer.shadowOffset = CGSize(width: 0, height: 2)
                    layer.shadowRadius = 4
                    
                    // Keep content inside rounded corners
                    clipsToBounds = true
        }
        
        func configureCell(with capsule: TimeCapsule) {
            capsuleName.text = capsule.capsuleName
            capsuleName.numberOfLines = 2 // Allow multiline if text is long
            
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            capsuleDeadline.text = "Deadline: " + formatter.string(from: capsule.deadline)
            
            // Set progress bar
            ProgressBar.setProgress(to: CGFloat(capsule.completionPercentage), animated: true)
        }
}
