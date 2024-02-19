//
//  ProfileViewController.swift
//  CovidPass
//
//  Created by LYON on 4/4/22.
//

import UIKit
import Parse

class UserProfileVC: UIViewController {

    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var user = PFUser.current()!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let name = user["name"] as? String ?? ""
        let username = user["username"] as? String ?? ""
        let password = user["password"] as? String ?? ""
        let email = user["email"] as? String ?? ""
        let gender = user["gender"] as? String ?? ""
        let phone = user["phone"] as? String ?? ""
        let address = user["address"] as? String ?? ""
        let country = user["country"] as? String ?? ""
        let zipCode = user["zip"] as? String ?? ""
        let state = user["state"] as? String ?? ""
        let city = user["city"] as? String ?? ""
        
        if (name != "") {
            nameLabel.text = name
        }
        if (username != "") {
            usernameLabel.text = username
        }
        if (password != "") {
            passwordLabel.text = password
        }
        if (email != "") {
            emailLabel.text = email
        }
        if (gender != "") {
            genderLabel.text = gender
        }
        if (phone != "") {
            phoneLabel.text = phone
        }
        
        if (address != "" && country != "" && zipCode != "" && state != "" && city != "") {
            addressLabel.text = "\(address)\n\(city), \(state), \(zipCode)\n\(country)"
        }
        
        // Do any additional setup after loading the view.
    }
        
    @IBAction func saveProfileButton(_ sender: Any) {
    }
    
    
    @IBAction func onLogOut(_ sender: Any) {
        
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScene.delegate as? SceneDelegate else { return }
        
        delegate.window?.rootViewController = loginViewController
        
        let transition = CATransition()

        transition.duration = 0.5
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.default)

        delegate.window?.layer.add(transition, forKey: kCATransition)
    }
    
    @IBAction func scanQR(_ sender: Any) {
    }
}
