//
//  CreateTaskTableViewController1.swift
//  Synkr
//
//  Created by student-2 on 14/01/25.
//

import UIKit

class CreateTaskTableViewController1: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let currentDate = Date()

           // Extract date components and set time to midnight
           let calendar = Calendar.current
           let startOfDay = calendar.startOfDay(for: currentDate)

           // Set default values for labels
           let formatter = DateFormatter()
           formatter.dateStyle = .medium
           formatter.timeStyle = .none // Ensure only the date is displayed

           let defaultDate = formatter.string(from: startOfDay)
           startDateLabel.setTitle(defaultDate, for: .normal)

           // Add one day to the current date for the end date
           if let endDate = calendar.date(byAdding: .day, value: 1, to: startOfDay) {
               let endDateString = formatter.string(from: endDate)
               endDateLabel.setTitle(endDateString, for: .normal)
           }

           // Set default repeat and priority values
           repeatButton.setTitle("None", for: .normal)
           PriorityButton.setTitle("Medium", for: .normal)
        
           

        
           // Select the first category by default
           if let defaultButton = categoryButton.first {
               print("Default category button title: \(defaultButton.currentTitle ?? "Unknown")")
               updateCategorySelection(selectedButton: defaultButton)
           }
        
        print("Category buttons count: \(categoryButton.count)")
       
    }

  

    
    @IBOutlet weak var taskName: UITextField!
    
    
    @IBOutlet weak var taskDescription: UITextField!
    
    @IBOutlet weak var startDateLabel: UIButton!
    
    @IBOutlet weak var startTimeLabel: UIButton!
    
    @IBOutlet weak var startDatePicker: UIDatePicker!
    
    @IBOutlet weak var startTimePicker: UIDatePicker!
    
    @IBOutlet weak var endDateLabel: UIButton!
    
    @IBOutlet weak var endTimeLabel: UIButton!
    
    
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    
    @IBOutlet weak var endTimePicker: UIDatePicker!
    
    
    @IBOutlet weak var repeatButton: UIButton!
    
    
    @IBOutlet weak var PriorityButton: UIButton!
    
    @IBOutlet weak var CreateButton: UIButton!
    
    @IBOutlet var categoryButton: [UIButton]!
    
    var selectedCategory: String?
    
    var isStartDatePickerVisible = false
    var isStartTimePickerVisible = false
    var isEndDatePickerVisible = false
    var isEndTimePickerVisible = false
    var isRepeatDropdownVisible = false
    var isPriorityDropdownVisible = false
    
    @IBAction func startDateButtonTapped(_ sender: Any) {
        isStartDatePickerVisible.toggle()
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    
    @IBAction func startTimeButtonTapped(_ sender: Any) {
        isStartTimePickerVisible.toggle()
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    
    @IBAction func endDateButtonTapped(_ sender: Any) {
        
        isEndDatePickerVisible.toggle()
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @IBAction func endTimeButtonTapped(_ sender: Any) {
        isEndTimePickerVisible.toggle()
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            if indexPath.row == 1 { // Start Date Picker
                return isStartDatePickerVisible ? 216 : 0
            } else if indexPath.row == 2 { // Start Time Picker
                return isStartTimePickerVisible ? 216 : 0
            } else if indexPath.row == 4 { // End Date Picker
                return isEndDatePickerVisible ? 216 : 0
            } else if indexPath.row == 5 { // End Time Picker
                return isEndTimePickerVisible ? 216 : 0
            }
        }
        return UITableView.automaticDimension
    }

    
    
    @IBAction func startDatePickerAction(_ sender: Any) {
        let formatter = DateFormatter()
            formatter.dateStyle = .medium
        let date = formatter.string(from: (sender as AnyObject).date)
            startDateLabel.setTitle(date, for: .normal)
        
        
    }
    
    
    @IBAction func startTimePickerAction(_ sender: Any) {
        let formatter = DateFormatter()
            formatter.timeStyle = .short
        let time = formatter.string(from: (sender as AnyObject).date)
            startTimeLabel.setTitle(time, for: .normal)
        
        
    }
    
    
    @IBAction func endDatePickerAction(_ sender: Any) {
        
        let formatter = DateFormatter()
            formatter.dateStyle = .medium
        let date = formatter.string(from: (sender as AnyObject).date)
            endDateLabel.setTitle(date, for: .normal)
        
        
    }
    
    
    @IBAction func endTimePickerAction(_ sender: Any) {
        let formatter = DateFormatter()
            formatter.timeStyle = .short
        let time = formatter.string(from: (sender as AnyObject).date)
            endTimeLabel.setTitle(time, for: .normal)
        
        
        
    }
    
    
    @IBAction func repeatButtonTapped(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Repeat", message: "Select Repeat Frequency", preferredStyle: .actionSheet)
            
            let noneAction = UIAlertAction(title: "None", style: .default) { _ in
                // Update the button with the selected value
                self.repeatButton.setTitle("None", for: .normal)
            }
        
            let dailyAction = UIAlertAction(title: "Daily", style: .default) { _ in
                // Update the button with the selected value
                self.repeatButton.setTitle("Daily", for: .normal)
            }
            let weeklyAction = UIAlertAction(title: "Weekly", style: .default) { _ in
                self.repeatButton.setTitle("Weekly", for: .normal)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
            actionSheet.addAction(noneAction)
            actionSheet.addAction(dailyAction)
            actionSheet.addAction(weeklyAction)
            actionSheet.addAction(cancelAction)
            
            present(actionSheet, animated: true, completion: nil)
        
    }
    
    @IBAction func PriorityButtonTapped(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Priority", message: "Select Task Priority", preferredStyle: .actionSheet)
           
           let highAction = UIAlertAction(title: "High", style: .default) { _ in
               self.PriorityButton.setTitle("High", for: .normal)
           }
           let mediumAction = UIAlertAction(title: "Medium", style: .default) { _ in
               self.PriorityButton.setTitle("Medium", for: .normal)
           }
           let lowAction = UIAlertAction(title: "Low", style: .default) { _ in
               self.PriorityButton.setTitle("Low", for: .normal)
           }
           let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
           
           actionSheet.addAction(highAction)
           actionSheet.addAction(mediumAction)
           actionSheet.addAction(lowAction)
           actionSheet.addAction(cancelAction)
           
           present(actionSheet, animated: true, completion: nil)
    }
    
    
    func updateCategorySelection(selectedButton: UIButton) {
        for button in categoryButton {
            if button == selectedButton {
                // Selected Button Styling
                button.backgroundColor = .systemBlue
                button.setTitleColor(.white, for: .normal)
                button.layer.cornerRadius = 8 // Rounded corners for a modern look
                button.layer.borderWidth = 2 // Black border for the selected button
                button.layer.borderColor = UIColor.black.cgColor
                button.transform = CGAffineTransform(scaleX: 1.05, y: 1.05) // Slight scaling effect
                
                selectedCategory = button.titleLabel?.text // Save the selected category
                print("Selected category: \(selectedCategory ?? "None")")
            } else {
                // Reset Styling for Unselected Buttons
                button.backgroundColor = .systemGray6
                button.setTitleColor(.systemBlue, for: .normal)
                button.layer.cornerRadius = 0
                button.layer.borderWidth = 0 // No border for unselected buttons
                button.transform = .identity // Reset scaling
            }
        }
    }



    
    
    
    @IBAction func categoryButtonTapped(_ sender: UIButton) {
        updateCategorySelection(selectedButton: sender)
        //selectedCategory = "Sports"
        
    }
    
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

    
    
    
    @IBAction func CreateButtonTapped(_ sender: Any) {
        
        guard let name = taskName.text, !name.isEmpty else {
            showAlert(title: "Missing Information", message: "Please enter a task name.")
            return
        }

        // Validate task description
        guard let description = taskDescription.text, !description.isEmpty else {
            showAlert(title: "Missing Information", message: "Please enter a task description.")
            return
        }

           guard let startDateString = startDateLabel.title(for: .normal), startDateString != "No Start Date" else {
                showAlert(title: "Missing Information", message: "Please select a start date.")
                return
            }
            
            // Convert start date from string to Date
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            guard let startDate = formatter.date(from: startDateString) else {
                showAlert(title: "Invalid Start Date", message: "The start date is not valid.")
                return
            }

            // Validate start time
            guard let startTimeString = startTimeLabel.title(for: .normal), startTimeString != "No Start Time" else {
                showAlert(title: "Missing Information", message: "Please select a start time.")
                return
            }

            // Validate end date
            guard let endDateString = endDateLabel.title(for: .normal), endDateString != "No End Date" else {
                showAlert(title: "Missing Information", message: "Please select an end date.")
                return
            }
            
            // Convert end date from string to Date
            guard let endDate = formatter.date(from: endDateString) else {
                showAlert(title: "Invalid End Date", message: "The end date is not valid.")
                return
            }

            // Validate end time
            guard let endTimeString = endTimeLabel.title(for: .normal), endTimeString != "No End Time" else {
                showAlert(title: "Missing Information", message: "Please select an end time.")
                return
            }
        // Validate repeat frequency
        guard let repeatFrequencyString = repeatButton.title(for: .normal),
              repeatFrequencyString != "No Repeat Frequency",
              let repeatFrequency = RepeatFrequency(rawValue: repeatFrequencyString) else {
            showAlert(title: "Missing Information", message: "Please select a valid repeat frequency.")
            return
        }

        // Validate priority
        guard let priorityString = PriorityButton.title(for: .normal),
              priorityString != "No Priority",
              let priority = Priority(rawValue: priorityString.lowercased()) else {
            showAlert(title: "Missing Information", message: "Please select a valid priority.")
            return
        }

        // Assign category (fixed value for now, can be modified later for dynamic selection)
        guard let selectedCategory = selectedCategory else {
                showAlert(title: "Missing Information", message: "Please select a category.")
                return
            }

            // Convert the selected category string to the appropriate enum value (adjust based on your enum design)
        let category = Category(rawValue: selectedCategory) ?? .others //
        
        
        // Set a default alert (you can modify this later if needed)
        let alert: Alert = .none // Default to no alert for now

        // Create Task instance
        
        let task = Task(
            taskId: UUID(), // Generate a unique ID for the task
            taskName: name,
            description: description,
            startTime: startTimeString, // This should be before startDate
            endTime: endTimeString,     // This should be before endDate
            startDate: startDate, // Now correctly positioned after startTime
            endDate: endDate,     // Now correctly positioned after endTime
            repeatFrequency:[repeatFrequency],
            priority: priority,
            isCompleted: false, // Default to false when creating a new task
            Alert: alert, // Provide correct alert value
            category: category
            
        )

        // Debug output
        print("Task Created: \(task)")

        // Feedback to the user
        showAlert(title: "Success", message: "Task created successfully!")


    }
    
    
    
    
    
}

