//
//  HomeAllTaskViewController.swift
//  Synkr-Team
//
//  Created by Deepankar Garg on 17/01/25.
//

import UIKit

class HomeAllTaskViewController: UIViewController {
    @IBOutlet var taskCollection: UICollectionView!
    
    var loggedUser: User?{
        didSet {
            if isViewLoaded {
                updateUI()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        taskCollection.register(taskCollectionViewCell.nib(), forCellWithReuseIdentifier: "taskCollectionViewCell")
        taskCollection.delegate = self
        taskCollection.dataSource = self
        
        // Set the compositional layout
        taskCollection.collectionViewLayout = createCompositionalLayout()
    }
    private func createCompositionalLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            // You can use the `sectionIndex` if you plan to have multiple sections in the future
            return self.createTaskSection()
        }
    }

    private func createTaskSection() -> NSCollectionLayoutSection {
        // Define the item size
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0), // Full width
            heightDimension: .absolute(100)       // Fixed height
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

        // Define the group size
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(100) // Group height adjusts based on content
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        // Define the section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        // Optional: Add orthogonal scrolling behavior if needed
        section.orthogonalScrollingBehavior = .none // No horizontal scrolling; tasks are vertical

        return section
    }

    private func updateUI() {
        // Use the LoggedUser property to update the UI
        if let loggedUser = loggedUser {
            print("LoggedUser: \(loggedUser.name)")
        }
    }
    
    // Sort tasks by priority
    func sortTasksByPriority() {
        let todayIndex = getTodayDayIndex()
        if let todayTasks = loggedUser?.dailyTaskCalendar[todayIndex].todayTasks {
            // Sort the tasks based on priority
            let sortedTasks = todayTasks.sorted { (firstTask: Task, secondTask: Task) -> Bool in
                return firstTask.priority.sortOrder > secondTask.priority.sortOrder
            }
            
            // Update the tasks in the model
            loggedUser?.dailyTaskCalendar[todayIndex].todayTasks = sortedTasks
            print("Tasks sorted by priority")
        }
        
        // Reload collection view to reflect changes
        taskCollection.reloadData()
    }
    
    
    func sortTasksByCompletionStatus() {
        let todayIndex = getTodayDayIndex()
        if let todayTasks = loggedUser?.dailyTaskCalendar[todayIndex].todayTasks {
            // Sort tasks by completion status
            let sortedTasks = todayTasks.sorted { (firstTask: Task, secondTask: Task) -> Bool in
                return !firstTask.isCompleted && secondTask.isCompleted
            }
            
            // Update the tasks in the model
            loggedUser?.dailyTaskCalendar[todayIndex].todayTasks = sortedTasks
            print("Tasks sorted by completion status")
        }
        
        // Reload collection view to reflect changes
        taskCollection.reloadData()
    }
}

extension HomeAllTaskViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
//        print("You tapped me!")
        // Instantiate TaskDetailViewController from storyboard
        let storyboard = UIStoryboard(name: "HomeScreens", bundle: nil) // Replace "Main" with your storyboard name
        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "insightViewController") as? insightViewController else {
            return
        }
        
        // Get the task for the selected cell
        let todayIndex = getTodayDayIndex()
        if let todayTasks = loggedUser?.dailyTaskCalendar[todayIndex].todayTasks {
            let selectedTask = todayTasks[indexPath.row]
            detailVC.task = selectedTask // Pass the selected task to the detail VC
        }
        
        // Push or present the detail view controller
//        navigationController?.pushViewController(detailVC, animated: true)
        present(detailVC, animated: true, completion: nil)
    }
}

extension HomeAllTaskViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Use getTodayDayIndex() directly
        let todayIndex = getTodayDayIndex()
        
        // Return the count of today's tasks, or 0 if nil
        return loggedUser?.dailyTaskCalendar[todayIndex].todayTasks.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "taskCollectionViewCell", for: indexPath) as! taskCollectionViewCell
        // Use getTodayDayIndex() directly
        let todayIndex = getTodayDayIndex()
        
        // Safely access today's tasks array
        if let todayTasks = loggedUser?.dailyTaskCalendar[todayIndex].todayTasks {
            // Fetch the specific task for this indexPath
            let task = todayTasks[indexPath.row]
            
            // Configure the cell with the task
            cell.configure(with: task)
        }
        
        return cell
    }
}
extension HomeAllTaskViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width // Adjust padding
        return CGSize(width: width, height: 100) // Set the height based on your design
    }
}
