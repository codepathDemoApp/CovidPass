//
//  ProfileViewController.swift
//  CovidPass
//
//  Created by LYON on 4/4/22.
//

import UIKit
import Parse

class UserProfileVC: UIViewController, UITextFieldDelegate {

<<<<<<< HEAD
    @IBOutlet weak var editNameField: UITextField!
    
    @IBOutlet weak var editUsernameField: UITextField!
    
    @IBOutlet weak var editPasswordField: UITextField!
    
    @IBOutlet weak var editEmailField: UITextField!
    
    @IBOutlet weak var editGenderField: UITextField!
    
    @IBOutlet weak var editPhoneNumberField: UITextField!
    
    @IBOutlet weak var editAddressField: UITextField!
    
    @IBOutlet weak var saveProfileButton: UIButton!
=======
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var user = PFUser.current()!
>>>>>>> a021eebd9b0f37b0828c03558f2abe39f4f07c96
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editNameField.delegate = self
        editUsernameField.delegate = self
        editPasswordField.delegate = self
        editEmailField.delegate = self
        editGenderField.delegate = self
        editPhoneNumberField.delegate = self
        editAddressField.delegate = self
        

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
    
    @IBAction func saveProfile(_ sender: Any) {
        let name = editNameField.text!
        let username = editUsernameField.text!
        let password = editPasswordField.text!
        let email = editEmailField.text!
        let gender = editGenderField.text!
        let phone = editPhoneNumberField.text!
        let address = editAddressField.text!
        
        let profile = PFObject(className: "User")
        profile["name"] = editNameField.text
        profile["username"] = editUsernameField.text
        
        profile.saveInBackground() { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("saved")
            } else {
                print("error")
            }
        }
        
    }
    
    
     
    func saveInfo(_ textField: UITextField) {
        if (!(editNameField.text?.count == 0) || !(editUsernameField.text?.count == 0) || !(editPasswordField.text?.count == 0) || !(editEmailField.text?.count == 0) || !(editGenderField.text?.count == 0) || !(editPhoneNumberField.text?.count == 0) || !(editAddressField.text?.count == 0)) {
            saveProfileButton.isUserInteractionEnabled = true
            saveProfileButton.tintColor = UIColor.init(red: 36/255, green: 122/255, blue: 255/255, alpha: 1)
        } else {
            saveProfileButton.isUserInteractionEnabled = false
            saveProfileButton.tintColor = UIColor.init(red: 36/255, green: 122/255, blue: 255/255, alpha: 0.5)
        }
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
