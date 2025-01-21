//
//  insightViewController.swift
//  Synkr-Team
//
//  Created by Deepankar Garg on 16/01/25.
//

import UIKit

protocol TaskUpdateDelegate: AnyObject {
    func didUpdateTask(_ updatedTask: Task)
}

class insightViewController: UIViewController {
    
    
    @IBOutlet var taskName: UILabel!
    @IBOutlet var taskTime: UILabel!
    @IBOutlet var taskInsights: UILabel!
    @IBOutlet var taskDescription: UILabel!
    var task: Task?
    weak var delegate: TaskUpdateDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let task = task {
            taskName.text = task.taskName
            taskTime.text = task.startTime + " - " + task.endTime
            taskInsights.text = task.category.customCategory.insights
            taskDescription.text = task.description
        }
    }

    
    @IBAction func ButtomComplete(_ sender: Any) {
        guard var task = task else {
            print("Error: Task is nil.")
            return
        }

        // Mark the task as completed
        task.isCompleted = true

        // Notify the delegate
        delegate?.didUpdateTask(task)

        // Provide feedback and update UI
        let alert = UIAlertController(
            title: "Task Completed",
            message: "The task '\(task.taskName)' has been marked as completed.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true)
        
        // Change the label color to indicate completion
        taskName.textColor = .systemGreen
    }
}
