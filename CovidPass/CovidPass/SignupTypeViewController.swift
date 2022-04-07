//
//  SignupTypeViewController.swift
//  CovidPass
//
//  Created by LYON on 4/7/22.
//

import UIKit
import Parse

class SignupTypeViewController: UIViewController {

    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var userButton: UIButton!
    
    var username: String = ""
    var password: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationButton.layer.cornerRadius = 12
        locationButton.layer.masksToBounds = true
        userButton.layer.cornerRadius = 12
        userButton.layer.masksToBounds = true

        // Do any additional setup after loading the view.
    }
    
    // Sign up for location
    @IBAction func forLocation(_ sender: Any) {
        
        let user = PFUser()

        user.username = "Admin-" + username
        user.password = password

        user.signUpInBackground { success, error in
            if success {
                self.performSegue(withIdentifier: "loginToLocationSegue", sender: nil)
            } else {
                print("Error: \(error!.localizedDescription)")
            }
        }
    }
    
    // Sign up for user
    @IBAction func forUser(_ sender: Any) {
        
        let user = PFUser()
        
        user.username = username
        user.password = password

        user.signUpInBackground { success, error in
            if success {
                self.performSegue(withIdentifier: "loginToUserSegue", sender: nil)
            } else {
                print("Error: \(error!.localizedDescription)")
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
