//
//  taskCollectionViewCell.swift
//  Synkr-Team
//
//  Created by Deepankar Garg on 15/01/25.
//

import UIKit

class taskCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var flagImage: UIImageView!
    @IBOutlet var taskImage: UIImageView!
    @IBOutlet var taskLabel: UILabel!
    @IBOutlet var taskName: UILabel!
    @IBOutlet var taskTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with task: Task) {
        switch task.isCompleted {
        case true:
            print("task completed")
            taskName.backgroundColor = .green // Set background color to green for completed tasks
            // Optionally trigger haptic feedback or display a notification
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        case false:
            taskName.backgroundColor = .white // Set background color to white for incomplete tasks
            // Optionally trigger haptic feedback
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }

        
        taskImage.image = task.category.taskImage
        flagImage.image = UIImage(systemName: "flag.circle")
        flagImage.tintColor = task.priority.tintColor
        taskLabel.text = task.category.customCategory.categoryName
        taskName.text = task.taskName
        taskTime.text = task.startTime + " - " + task.endTime
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "taskCollectionViewCell", bundle: nil)
    }
}
