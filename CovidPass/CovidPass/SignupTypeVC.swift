//
//  SignupTypeViewController.swift
//  CovidPass
//
//  Created by LYON on 4/7/22.
//

import UIKit
import Parse

class SignupTypeVC: UIViewController {

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueIdentifier = segue.identifier ?? ""
        if segueIdentifier == "segueToLocationInformation" {
            let destinationVC = segue.destination as! SignupLocationVC
            destinationVC.password = password
            destinationVC.username = username
        } else if segueIdentifier == "segueToUserInformation" {
            let destinationVC = segue.destination as! SignupUserVC
            destinationVC.password = password
            destinationVC.username = username
        }
    }
    
    // Sign up for location
    @IBAction func forLocation(_ sender: Any) {
        self.performSegue(withIdentifier: "segueToLocationInformation", sender: nil)
//        let user = PFUser()
//
//        user.username = username
//        user.password = password
//        user["type"] = "location"
//
//        print("System: successfully signed \(user.username!) as location type account")
//
//        user.signUpInBackground { success, error in
//            if success {
//                self.performSegue(withIdentifier: "loginToLocationSegue", sender: nil)
//            } else {
//                print("Error: \(error!.localizedDescription)")
//            }
//        }
    }
    
    // Sign up for user
    @IBAction func forUser(_ sender: Any) {
        performSegue(withIdentifier: "segueToUserInformation", sender: nil)
//        let user = PFUser()
//
//        user.username = username
//        user.password = password
//        user["type"] = "user"
//
//        print("System: successfully signed \(user.username!) as user type account")
//
//        user.signUpInBackground { success, error in
//            if success {
//                self.performSegue(withIdentifier: "segueToUserInformation", sender: nil)
//            } else {
//                print("Error: \(error!.localizedDescription)")
//            }
//        }
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
