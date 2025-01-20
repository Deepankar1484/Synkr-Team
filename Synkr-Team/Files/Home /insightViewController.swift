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

    
    @IBAction func ButtomComplete(_ sender: Any) {
        guard var task = task else {
                print("Error: Task is nil.")
                return
            }
            
            // Update the task as completed
            task.isCompleted = true
            
            // Update the data model if necessary
            if let userId = UserDataModel.shared.getUser(by: exampleUser.userId)?.userId {
                let currentDate = task.startDate // Assuming the task is for today or its start date
                var updatedTasks = UserDataModel.shared.getUser(by: userId)?.dailyTaskCalendar
                    .first(where: { Calendar.current.isDate($0.date, inSameDayAs: currentDate) })?.todayTasks ?? []
                
                if let taskIndex = updatedTasks.firstIndex(where: { $0.taskId == task.taskId }) {
                    updatedTasks[taskIndex] = task
                    
                    // Update the tasks back to the user's calendar
                    let success = UserDataModel.shared.updateDailyTasks(for: userId, date: currentDate, updatedTasks: updatedTasks)
                    print(success ? "Task marked as completed!" : "Failed to update task completion.")
                }
            }
            
            // Provide user feedback (optional)
            let alert = UIAlertController(title: "Task Completed", message: "The task '\(task.taskName)' has been marked as completed.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            
            taskName.textColor = .systemGreen
    }
}
