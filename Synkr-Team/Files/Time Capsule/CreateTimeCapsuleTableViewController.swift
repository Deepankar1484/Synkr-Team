//
//  CreateTimeCapsuleTableViewController.swift
//  Synkr
//
//  Created by Dhruv Jain on 13/01/25.
//

import UIKit

class CreateTimeCapsuleTableViewController: UITableViewController {
    
    
    @IBOutlet weak var TimeCapsuleTaskName: UITextField!
    @IBOutlet weak var TimeCapsuleDescription: UITextField!
    @IBOutlet weak var TimeCapsuleDeadlineDate: UIButton!
    @IBOutlet weak var TimeCapsuleDeadlineTime: UIButton!
    @IBOutlet weak var TimeCapsuleDatePicker: UIDatePicker!
    @IBOutlet weak var TimeCapsuleTimePicker: UIDatePicker!
    
    
    @IBOutlet weak var TImeCapsulePriorityButton: UIButton!
    
    @IBOutlet weak var dateheader: UIView!
    
    @IBOutlet weak var timeheader: UITableViewCell!
    
    @IBOutlet weak var TCSubtask: UISwitch!
    @IBOutlet weak var TCSubtaskName: UITextField!
    @IBOutlet weak var TCTaskDescription: UITextField!
    @IBOutlet weak var TCTaskAdd: UIButton!
    
    @IBOutlet weak var finalButton: UIButton!
    
    var subtasks: [Subtask] = []
        
        var selectedDate: Date?
        var selectedTime: Date?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Initially hide the pickers
            TimeCapsuleDatePicker.isHidden = true
            TimeCapsuleTimePicker.isHidden = true
            TCSubtaskName.isHidden = true
            TCTaskDescription.isHidden = true
            TCTaskAdd.isHidden = true
            dateheader.isHidden = true
            TCSubtask.isOn = false

        }
        
    @IBAction func dateButtonTapped(_ sender: UIButton) {
        TimeCapsuleDatePicker.isHidden.toggle()
        TimeCapsuleTimePicker.isHidden = true
        dateheader.isHidden.toggle()
    }

    @IBAction func timeButtonTapped(_ sender: UIButton) {
        TimeCapsuleTimePicker.isHidden.toggle()
        TimeCapsuleDatePicker.isHidden = true
        dateheader.isHidden.toggle()
    }

    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        selectedDate = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        let formattedDate = dateFormatter.string(from: selectedDate ?? Date())
        TimeCapsuleDeadlineDate.setTitle(formattedDate, for: .normal)
    }

    @IBAction func timePickerChanged(_ sender: UIDatePicker) {
        selectedTime = sender.date
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short
        
        let formattedTime = timeFormatter.string(from: selectedTime ?? Date())
        TimeCapsuleDeadlineTime.setTitle(formattedTime, for: .normal)
    }
    
    
    @IBAction func PriorityButtonTapped(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Priority", message: "Select Task Priority", preferredStyle: .actionSheet)
       
        let highAction = UIAlertAction(title: "High", style: .default) { _ in
            self.TImeCapsulePriorityButton.setTitle("High", for: .normal)
        }
        let mediumAction = UIAlertAction(title: "Medium", style: .default) { _ in
            self.TImeCapsulePriorityButton.setTitle("Medium", for: .normal)
        }
        let lowAction = UIAlertAction(title: "Low", style: .default) { _ in
            self.TImeCapsulePriorityButton.setTitle("Low", for: .normal)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
       
        actionSheet.addAction(highAction)
        actionSheet.addAction(mediumAction)
        actionSheet.addAction(lowAction)
        actionSheet.addAction(cancelAction)
       
        present(actionSheet, animated: true, completion: nil)
    }
        @IBAction func TCSubtaskSwitchToggled(_ sender: UISwitch) {
            if sender.isOn {
                TCSubtaskName.isHidden = false
                TCTaskDescription.isHidden = false
                TCTaskAdd.isHidden = false
            } else {
                TCSubtaskName.isHidden = true
                TCTaskDescription.isHidden = true
                TCTaskAdd.isHidden = true
            }
        }
        @IBAction func addSubtask(_ sender: UIButton) {
            guard let subtaskName = TCSubtaskName.text, !subtaskName.isEmpty,
                  let taskDescription = TCTaskDescription.text, !taskDescription.isEmpty else {
                return
            }
            
            let newSubtask = Subtask(subtaskName: subtaskName,
                                     description: taskDescription,
                                     isCompleted: false)
            
            subtasks.append(newSubtask)
            TCSubtaskName.text = ""
            TCTaskDescription.text = ""
        }
        
        @IBAction func finalButtonTapped(_ sender: UIButton) {
            guard let taskName = TimeCapsuleTaskName.text, !taskName.isEmpty,
                  let description = TimeCapsuleDescription.text, !description.isEmpty else {
                let alert = UIAlertController(title: "Error", message: "Please fill in all task details", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            guard let selectedDate = selectedDate, let _ = selectedTime else {
                let alert = UIAlertController(title: "Error", message: "Please select both date and time", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            
            var selectedPriority: Priority = .medium
            
            func priorityMenuAction(_ sender: UICommand) {
                if sender == TImeCapsulePriorityButton {
                    selectedPriority = .high
                } else if sender == TImeCapsulePriorityButton {
                    selectedPriority = .medium
                } else if sender == TImeCapsulePriorityButton {
                    selectedPriority = .low
                }
            }
            let timeCapsule = TimeCapsule(
                capsuleId: UUID(),
                capsuleName: taskName,
                deadline: selectedDate,
                priority: selectedPriority,
                description: description,
                completionPercentage: 0,
                timeCapsuleCategory: .others,
                subtasks: subtasks
            )
            print(timeCapsule)
            let successAlert = UIAlertController(title: "Success", message: "Time Capsule created successfully!", preferredStyle: .alert)
            successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(successAlert, animated: true, completion: nil)
        }
    
    

    }
