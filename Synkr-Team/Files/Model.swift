//
//  Model.swift
//  Synkr-Team
//
//  Created by Deepankar Garg on 13/01/25.
//

import UIKit

enum RepeatFrequency: String { // we have mainly created a map for the same
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
    case sunday = "Sunday"
}

enum Priority: String {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
    
    // Computed property for tintColor
    var tintColor: UIColor {
        switch self {
        case .low:
            return .green
        case .medium:
            return .orange
        case .high:
            return .red
        }
    }
}


enum Alert: String {
    case none = "None"
    case fiveMinutes = "5 minutes"
    case tenMinutes = "10 minutes"
    case fifteenMinutes = "15 minutes"
    case thirtyMinutes = "30 minutes"
    case oneHour = "1 hour"
}

enum Usage: String {
    case personal = "Personal"
    case work = "Work"
    case education = "Education"
}
enum Category: String {
    case sports = "Sports"
    case study = "Study"
    case work = "Work"
    case meetings = "Meetings"
    case habits = "Habits"
    case others = "Others"

    var customCategory: CustomCategory {
        switch self {
        case .sports:
            return CustomCategory(
                category: self,
                categoryName: "Sports",
                categoryColor: UIColor.systemBlue,
                insights: "Stay active and healthy with sports-related tasks."
            )
        case .study:
            return CustomCategory(
                category: self,
                categoryName: "Study",
                categoryColor: UIColor.systemGreen,
                insights: "Focus on learning and personal growth."
            )
        case .work:
            return CustomCategory(
                category: self,
                categoryName: "Work",
                categoryColor: UIColor.systemRed,
                insights: "Manage your professional tasks efficiently."
            )
        case .meetings:
            return CustomCategory(
                category: self,
                categoryName: "Meetings",
                categoryColor: UIColor.systemOrange,
                insights: "Keep track of your scheduled meetings and events."
            )
        case .habits:
            return CustomCategory(
                category: self,
                categoryName: "Habits",
                categoryColor: UIColor.systemPurple,
                insights: "Build and maintain positive habits."
            )
        case .others:
            return CustomCategory(
                category: self,
                categoryName: "Others",
                categoryColor: UIColor.systemGray,
                insights: "Miscellaneous tasks that don't fit into other categories."
            )
        }
    }

    // Add a computed property for taskImage
    var taskImage: UIImage? {
        switch self {
        case .work:
            return UIImage(systemName: "latch.2.case")
        case .study:
            return UIImage(systemName: "books.vertical")
        case .others:
            return UIImage(named: "Others")
        case .sports:
            return UIImage(systemName: "figure.run")
        case .meetings:
            return UIImage(systemName: "person.line.dotted.person")
        case .habits:
            return UIImage(systemName: "arrow.trianglehead.2.clockwise")
        }
    }
}


// ---------------------------------------------------------------------------

struct User {
    var userId: UUID
    var name: String
    var email: String
    var password: String
    var phone: String
    var dailyTaskCalendar: [DailyTasks] // Only 7 days
    var totalStreak: Int
    var monthlyStreak: Int
    var settings: Settings
    var awards: [Award]
    var OverdueTasks: [Task]
    
    // Initializer to generate the 7-day calendar dynamically
    init(userId: UUID, name: String, email: String, password: String, phone: String, totalStreak: Int, monthlyStreak: Int, settings: Settings, awards: [Award]) {
        self.userId = userId
        self.name = name
        self.email = email
        self.password = password
        self.phone = phone
        self.totalStreak = totalStreak
        self.monthlyStreak = monthlyStreak
        self.settings = settings
        self.awards = awards
        self.OverdueTasks = []
        // Generate dynamic daily task calendar for the next 7 days
        self.dailyTaskCalendar = User.generateWeeklyTaskCalendar()
    }
    
    // Function to generate the daily task calendar for the current week's Monday to Sunday
    private static func generateWeeklyTaskCalendar() -> [DailyTasks] {
        let calendar = Calendar.current
        let currentDate = Date()
        
        // Find the Monday of the current week
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate))!
        
        // Generate an array of DailyTasks from Monday to Sunday
        return (0..<7).compactMap { offset -> DailyTasks? in
            if let date = calendar.date(byAdding: .day, value: offset, to: startOfWeek) {
                return DailyTasks(date: date, todayTasks: [])
            }
            return nil
        }
    }
}

// Add an extension to format the output with days of the week
extension DailyTasks: CustomStringConvertible {
    var description: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, yyyy-MM-dd" // Include the day of the week and the date
        let formattedDate = formatter.string(from: date)
        return "DailyTasks(day: \(formattedDate), todayTasks: \(todayTasks))"
    }
}

// Data model to represent a single day's tasks
struct DailyTasks {
    var date: Date
    var todayTasks: [Task]
}

struct Settings {
    let profilePicture: UIImage?
    var usage: Usage
    var bedtime: String
    var wakeUpTime: String
    var notificationsEnabled: Bool
}

// for creating new and editing task
struct Task {
    var taskId: UUID
    var taskName: String
    var description: String
    var startTime: String
    var endTime: String
    var startDate: Date
    var endDate: Date
    var repeatFrequency: [RepeatFrequency]
    var priority: Priority
    var isCompleted: Bool
    var Alert: Alert
    var category: Category
    var otherCategory: String?
}

struct CustomCategory {
    var category: Category
    var categoryName: String?
    var categoryColor: UIColor
    var insights: String
}

struct TimeCapsule{
    var capsuleId: UUID
    var capsuleName: String
    var deadline: Date
    var priority: Priority
    var description: String
    var completionPercentage: Double
    var timeCapsuleCategory: Category
    var subtasks: [Subtask]
}

struct Subtask {
    var subtaskName: String
    var description: String?
    var startDate: Date?
    var endDate: Date?
    var isCompleted: Bool
    mutating func markAsCompleted() {
        self.isCompleted = true
        self.endDate = Date() // Set the end date to the current date when completed
    }
}

struct Award{
    var awardId: UUID
    var awardName: String
    var dateEarned: Date
    var description: String
    var awardCount: Int
}


// Create the User instance
var exampleUser = User(
    userId: UUID(),
    name: "Deepankar Garg",
    email: "deep@gmail.com",
    password: "123",
    phone: "+1234567890",
    totalStreak: 5,
    monthlyStreak: 2,
    settings: Settings(
        profilePicture: UIImage(),
        usage: .personal,
        bedtime: "22:00",
        wakeUpTime: "06:00",
        notificationsEnabled: true
    ),
    awards: []
)

// Helper function to get today's index
func getTodayDayIndex() -> Int {
    let today = Date()
    let calendar = Calendar.current
    // Get the weekday as a number (1 = Sunday, 2 = Monday, ..., 7 = Saturday)
    let weekday = calendar.component(.weekday, from: today)
    // Adjust to make Sunday = 0, Monday = 1, ..., Saturday = 6
    return weekday - 1
}

// Function to add multiple tasks to today's calendar
func addTasks(for user: inout User, tasks: [Task]) {
    let todayIndex = getTodayDayIndex()
    if todayIndex >= 0 && todayIndex < user.dailyTaskCalendar.count {
        user.dailyTaskCalendar[todayIndex].todayTasks.append(contentsOf: tasks)
//        print("Tasks added to day \(todayIndex): \(user.dailyTaskCalendar[todayIndex])")
    } else {
        print("Error: Invalid day index.")
    }
}

// Define sample tasks
let sampleTasks: [Task] = [
    Task(
        taskId: UUID(),
        taskName: "Morning Workout",
        description: "1-hour workout session",
        startTime: "06:00",
        endTime: "07:00",
        startDate: Date(),
        endDate: Date(),
        repeatFrequency: [],
        priority: .high,
        isCompleted: true,
        Alert: .fiveMinutes,
        category: .sports
    ),
    Task(
        taskId: UUID(),
        taskName: "Team Meeting",
        description: "Discuss project roadmap",
        startTime: "10:00",
        endTime: "11:00",
        startDate: Date(),
        endDate: Date(),
        repeatFrequency: [],
        priority: .medium,
        isCompleted: false,
        Alert: .tenMinutes,
        category: .work
    ),
    Task(
            taskId: UUID(),
            taskName: "Morning Yoga",
            description: "30-minute yoga session to relax and energize.",
            startTime: "06:30",
            endTime: "07:00",
            startDate: Date(),
            endDate: Date(),
            repeatFrequency: [],
            priority: .high,
            isCompleted: false,
            Alert: .tenMinutes,
            category: .habits
        ),
        Task(
            taskId: UUID(),
            taskName: "Client Call",
            description: "Monthly call to discuss project updates and deliverables.",
            startTime: "09:30",
            endTime: "10:30",
            startDate: Date(),
            endDate: Date(),
            repeatFrequency: [],
            priority: .medium,
            isCompleted: true,
            Alert: .fifteenMinutes,
            category: .work
        ),
        Task(
            taskId: UUID(),
            taskName: "Lunch with Team",
            description: "Team bonding lunch at a local restaurant.",
            startTime: "12:30",
            endTime: "13:30",
            startDate: Date(),
            endDate: Date(),
            repeatFrequency: [],
            priority: .low,
            isCompleted: false,
            Alert: .fiveMinutes,
            category: .others
        ),
        Task(
            taskId: UUID(),
            taskName: "Code Review Session",
            description: "Review PRs and give feedback to the team.",
            startTime: "15:00",
            endTime: "16:00",
            startDate: Date(),
            endDate: Date(),
            repeatFrequency: [],
            priority: .high,
            isCompleted: false,
            Alert: .thirtyMinutes,
            category: .work
        ),
        Task(
            taskId: UUID(),
            taskName: "Grocery Shopping",
            description: "Pick up essentials for the week.",
            startTime: "18:00",
            endTime: "19:00",
            startDate: Date(),
            endDate: Date(),
            repeatFrequency: [],
            priority: .medium,
            isCompleted: true,
            Alert: .none,
            category: .others
        ),
        Task(
            taskId: UUID(),
            taskName: "Read a Book",
            description: "Read 50 pages of a novel to unwind.",
            startTime: "21:00",
            endTime: "22:00",
            startDate: Date(),
            endDate: Date(),
            repeatFrequency: [],
            priority: .low,
            isCompleted: false,
            Alert: .none,
            category: .study
        )
]

//print(exampleUser.dailyTaskCalendar) // Verify the tasks added for 14th Jan


// All user class
class UserDataModel {
    private var users: [User] = []
    static let shared = UserDataModel()
    
    private init() {
        // Add tasks to 14th January 2025
        addTasks(for: &exampleUser, tasks: sampleTasks)
        users.append(exampleUser) // Adding example user
        
    }
    
    // Get user by ID
    func getUser(by userId: UUID) -> User? {
        return users.first { $0.userId == userId }
    }
    
    // Check if user exists by email
    func userExists(email: String) -> Bool {
        return users.contains { $0.email == email }
    }
    
    // Validate user login by email and password and this will return user so that we can inialise the user in app coding side
    func validateUser(email: String, password: String) -> User? {
        if userExists(email: email) {
            return users.first { $0.email == email && $0.password == password }
        }
        return nil
    }

    // Update user data make it one by one
    func updateUserData(for user: User) {
        if let index = users.firstIndex(where: { $0.userId == user.userId }) {
            users[index] = user
        }
    }
    // Add a new user to the data model
    func addUser(_ newUser: User) -> Bool {
        // Check if the user already exists by email
        if userExists(email: newUser.email) {
            print("Error: User with email \(newUser.email) already exists.")
            return false
        }
        // Add the new user to the array
        users.append(newUser)
        print("User with email \(newUser.email) added successfully.")
        return true
    }
}

// Class for Logged-in User Data Management
class LoggedInUser {
    private var user: User
    static var currentUser: LoggedInUser?

    init(user: User) {
        self.user = user
        LoggedInUser.currentUser = self
        // Add sample tasks to the user's daily task calendar after initialization
//        addSampleTasksToCalendar()
    }

    // Retrieve user details
    func getUserDetails() -> User {
        return user
    }

    // Add a task to a specific day in the daily task calendar
    func addTask(task: Task, to date: Date) {
        if let index = user.dailyTaskCalendar.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: date) }) {
            user.dailyTaskCalendar[index].todayTasks.append(task)
        } else {
            let newDailyTasks = DailyTasks(date: date, todayTasks: [task])
            user.dailyTaskCalendar.append(newDailyTasks)
        }
        UserDataModel.shared.updateUserData(for: user)
    }

    // Update an existing task in the daily task calendar
    func updateTask(updatedTask: Task, for date: Date) {
        if let dayIndex = user.dailyTaskCalendar.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: date) }) {
            if let taskIndex = user.dailyTaskCalendar[dayIndex].todayTasks.firstIndex(where: { $0.taskId == updatedTask.taskId }) {
                user.dailyTaskCalendar[dayIndex].todayTasks[taskIndex] = updatedTask
            }
        }
        UserDataModel.shared.updateUserData(for: user)
    }

    // Mark a task as completed
    func updateTaskStatusToCompleted(taskId: UUID, for date: Date) {
        if let dayIndex = user.dailyTaskCalendar.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: date) }) {
            if let taskIndex = user.dailyTaskCalendar[dayIndex].todayTasks.firstIndex(where: { $0.taskId == taskId }) {
                user.dailyTaskCalendar[dayIndex].todayTasks[taskIndex].isCompleted = true
            }
        }
        UserDataModel.shared.updateUserData(for: user)
    }

    // Delete a task by its ID
    func deleteTask(taskId: UUID) {
        // Iterate through all days in the dailyTaskCalendar
        for (dayIndex, _) in user.dailyTaskCalendar.enumerated() {
            // Remove the task with the specified ID from todayTasks
            user.dailyTaskCalendar[dayIndex].todayTasks.removeAll { $0.taskId == taskId }
        }
        UserDataModel.shared.updateUserData(for: user)
    }
//    private func addSampleTasksToCalendar() {
//        for task in sampleTasks {
//            if let taskDate = task.startDate {
//                if let dayIndex = user.dailyTaskCalendar.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: taskDate) }) {
//                    user.dailyTaskCalendar[dayIndex].todayTasks.append(task)
//                } else {
//                    let newDailyTasks = DailyTasks(date: taskDate, todayTasks: [task])
//                    user.dailyTaskCalendar.append(newDailyTasks)
//                }
//            }
//        }
//    }
}

// Singleton Class for Task Data Model
class TaskDataModel {
    private var tasks: [Task] = []
    static let shared = TaskDataModel()
    
//    private init() {
//        tasks.append(contentsOf: sampleTasks) // Adding sample tasks
//    }
    
    // Get all tasks
    func getAllTasks() -> [Task] {
        return tasks
    }
    // Get tasks by category
    func getTasks(by category: Category) -> [Task] {
        return tasks.filter { $0.category == category } // Fixed `category.category` to `category`
    }
    // Get tasks by priority
    func getTasks(by priority: Priority) -> [Task] {
        return tasks.filter { $0.priority == priority }
    }
    // Get incomplete tasks
    func getIncompleteTasks() -> [Task] {
        return tasks.filter { !$0.isCompleted }
    }
    // Mark task as completed
    func markTaskAsCompleted(taskId: UUID) {
        if let index = tasks.firstIndex(where: { $0.taskId == taskId }) {
            tasks[index].isCompleted = true
            // Notify LoggedInUser about the change
            LoggedInUser.currentUser?.updateTaskStatusToCompleted(taskId: taskId, for: Date())
        }
    }
}
//    This is commented beacuse these operations are done on the tasks in the particular rather than the orignal array of tasks.
//    // Add a new task
//    func addTask(_ task: Task) {
//        tasks.append(task)
//    }
//    // Delete a task
//    func deleteTask(taskId: UUID) {
//        tasks.removeAll { $0.taskId == taskId }
//        // Optionally, notify the logged-in user if the task needs to be removed from their calendar
//        LoggedInUser.currentUser?.deleteTask(taskId: taskId)
//    }
//
//    // Update an existing task
//    func updateTask(_ updatedTask: Task) {
//        if let index = tasks.firstIndex(where: { $0.taskId == updatedTask.taskId }) {
//            tasks[index] = updatedTask
//        }
//    }



let sampleSubtasks = [
    Subtask(
        subtaskName: "Design Phase",
        description: "Complete initial design",
        startDate: Date(),
        endDate: Date().addingTimeInterval(3600),
        isCompleted: false
    ),
    Subtask(
        subtaskName: "Development Phase",
        description: "Start development",
        startDate: Date(),
        endDate: Date().addingTimeInterval(7200),
        isCompleted: false
    )
]


let sampleTimeCapsule = TimeCapsule(
    capsuleId: UUID(),
    capsuleName: "Project ABC",
    deadline: Date().addingTimeInterval(86400), // 1 day from now
    priority: .high,
    description: "This is a critical project",
    completionPercentage: 0.0,
    timeCapsuleCategory: Category.work,
    subtasks: sampleSubtasks
)
class TimeCapsuleDataModel {
    private var timeCapsules: [TimeCapsule] = []
    static let shared = TimeCapsuleDataModel()

    private init() {
        timeCapsules.append(sampleTimeCapsule) // Adding a sample time capsule
    }

    // Get all time capsules
    func getAllTimeCapsules() -> [TimeCapsule] {
        return timeCapsules
    }

    // Add a new time capsule
    func addTimeCapsule(capsule: TimeCapsule) {
        timeCapsules.append(capsule)
    }

    // Get time capsule by ID
    func getTimeCapsule(by capsuleId: UUID) -> TimeCapsule? {
        return timeCapsules.first { $0.capsuleId == capsuleId }
    }

    // Update completion percentage of a time capsule
    func updateCompletion(capsuleId: UUID, newCompletionPercentage: Double) {
        if let index = timeCapsules.firstIndex(where: { $0.capsuleId == capsuleId }) {
            timeCapsules[index].completionPercentage = newCompletionPercentage
        }
    }
    
    // Get subtasks for a time capsule
    func getSubtasks(for capsuleId: UUID) -> [Subtask]? {
        return getTimeCapsule(by: capsuleId)?.subtasks
    }

    // Mark a subtask as complete
    func markSubtaskAsComplete(capsuleId: UUID, subtaskName: String) {
        if let index = timeCapsules.firstIndex(where: { $0.capsuleId == capsuleId }) {
            if let subtaskIndex = timeCapsules[index].subtasks.firstIndex(where: { $0.subtaskName == subtaskName }) {
                // Mark the subtask as completed
                timeCapsules[index].subtasks[subtaskIndex].markAsCompleted()
                updateCompletion(capsuleId: capsuleId, newCompletionPercentage: calculateCompletion(capsuleId: capsuleId))
            }
        }
    }
    
    private func calculateCompletion(capsuleId: UUID) -> Double {
        guard let capsule = getTimeCapsule(by: capsuleId) else { return 0.0 }
        let totalSubtasks = capsule.subtasks.count
        let completedSubtasks = capsule.subtasks.filter { $0.isCompleted }.count
        return totalSubtasks > 0 ? (Double(completedSubtasks) / Double(totalSubtasks)) * 100 : 0.0
    }
}

func validateUserLogin(email: String, password: String) {
    // Try to validate the user with the given email and password
    if let user = UserDataModel.shared.validateUser(email: email, password: password) {
        // If validation is successful, we log the user in
        let loggedInUser = LoggedInUser(user: user)
        let userDetails = loggedInUser.getUserDetails();
        print("All the tasks are: \(userDetails.dailyTaskCalendar)")
        print("\(Date())")
        print("Login successful. Welcome, \(user.name)!")
    } else {
        // If the email or password is incorrect
        print("Invalid email or password. Please try again.")
    }
}
