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
            let attributedText = NSAttributedString(
                string: taskName.text ?? "",
                attributes: [
                    .strikethroughStyle: NSUnderlineStyle.single.rawValue
                ]
            )
            taskName.attributedText = attributedText
        case false:
            let attributedText = NSAttributedString(
                string: taskName.text ?? "",
                attributes: [:]
            )
            taskName.attributedText = attributedText
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
