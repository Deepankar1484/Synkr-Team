//
//  HomeViewController.swift
//  Synkr-Team
//
//  Created by Deepankar Garg on 14/01/25.
//
import UIKit

class HomeViewController: UIViewController {
    
    // Property to hold the logged-in user
    @IBOutlet var Name: UILabel!
    
    @IBOutlet var segmentOutlet: UISegmentedControl!
    @IBOutlet var allTask: UIView!
    @IBOutlet var taskCategory: UIView!
    
    @IBOutlet var todayDateHome: UILabel!
    
    var loggedInUser: User?
    var homeAllTaskViewController: HomeAllTaskViewController?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Check if the logged-in user exists and print some of their details
        if let user = loggedInUser {
            Name.text = "Welcome, "+user.name
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.timeStyle = .none
            todayDateHome.text = formatter.string(from: Date())
            self.view.bringSubviewToFront(allTask)
            print("Welcome, \(user.name)!")
        } else {
            print("No user logged in.")
        }
    }
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            self.view.bringSubviewToFront(allTask)
        case 1:
            self.view.bringSubviewToFront(taskCategory)
        case 2:
            self.view.bringSubviewToFront(allTask)
        case 3:
            self.view.bringSubviewToFront(allTask)
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedSegue" {
            if let secondVC = segue.destination as? HomeAllTaskViewController {
                self.homeAllTaskViewController = secondVC
                secondVC.loggedUser = loggedInUser
            }
        }
    }
    
}
