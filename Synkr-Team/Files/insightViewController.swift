//
//  insightViewController.swift
//  Synkr-Team
//
//  Created by Deepankar Garg on 16/01/25.
//

import UIKit

class insightViewController: UIViewController {
    
    
    @IBOutlet var taskName: UILabel!
    @IBOutlet var taskTime: UILabel!
    @IBOutlet var taskInsights: UILabel!
    @IBOutlet var taskDescription: UILabel!
    var task: Task?
    override func viewDidLoad() {
        super.viewDidLoad()

        if let task = task {
            taskName.text = task.taskName
            taskTime.text = task.startTime + " - " + task.endTime
            taskInsights.text = task.category.customCategory.insights
            taskDescription.text = task.description
        }
    }

}
