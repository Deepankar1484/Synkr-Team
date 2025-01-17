//
//  LoginViewController.swift
//  Synkr-Team
//
//  Created by Deepankar Garg on 13/01/25.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var userEmail: UITextField!
        
    @IBOutlet var userPass: UITextField!
    
    var UserLogged: User?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        userEmail.text = "deep@gmail.com"
        userPass.text = "123"
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = userEmail.text,
              let password = userPass.text,
              !email.isEmpty,
              !password.isEmpty else {
            print("Please enter both email and password")
            return
        }
        
        if let loggedUser = UserDataModel.shared.validateUser(email: email, password: password) {
            // Store logged-in user (if needed)
            UserLogged = loggedUser
            
            // Load the HomeScreens storyboard
            let homeStoryboard = UIStoryboard(name: "HomeScreens", bundle: nil)
            
            guard let tabBarController = homeStoryboard.instantiateInitialViewController() as? UITabBarController else {
                    print("Error: TabBarController not found in Home storyboard")
                    return
                }
            // Instantiate HomeViewController from the HomeScreens storyboard
            if let homeVC = homeStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
                homeVC.loggedInUser = UserLogged  // Pass logged-in user data
//                homeVC.modalPresentationStyle = .currentContext
//                present(homeVC, animated: true)
                if var viewControllers = tabBarController.viewControllers {
                           // Replace the first tab with the instantiated HomeVC
                   viewControllers[0] = UINavigationController(rootViewController: homeVC)
                   tabBarController.viewControllers = viewControllers
               }
            }
            if let window = UIApplication.shared.windows.first {
                    window.rootViewController = tabBarController
                    window.makeKeyAndVisible()
                }
        } else {
            let alert = UIAlertController(title: "Login Failed", message: "Invalid email or password. Please try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            print("User not found or incorrect credentials")
        }
    }
    // Optional: Prepare for segue if needed
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "homePageSegue" {
//            // Pass any data to the HomeViewController if necessary
//            if let homeVC = segue.destination as? HomeViewController {
//                homeVC.loggedInUser = UserLogged
//            }
//        }
//    }
}
