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
    }
    private func updateUI() {
        // Use the LoggedUser property to update the UI
        if let loggedUser = loggedUser {
            print("LoggedUser: \(loggedUser.name)")
        }
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
        let width = collectionView.frame.width - 20 // Adjust padding
        return CGSize(width: width, height: 100) // Set the height based on your design
    }
}
