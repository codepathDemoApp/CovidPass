//
//  ProfileViewController.swift
//  CovidPass
//
//  Created by LYON on 4/4/22.
//

import UIKit
import Parse

class UserProfileVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var editNameField: UITextField!
    
    @IBOutlet weak var editUsernameField: UITextField!
    
    @IBOutlet weak var editPasswordField: UITextField!
    
    @IBOutlet weak var editEmailField: UITextField!
    
    @IBOutlet weak var editGenderField: UITextField!
    
    @IBOutlet weak var editPhoneNumberField: UITextField!
    
    @IBOutlet weak var editAddressField: UITextField!
    
    @IBOutlet weak var saveProfileButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editNameField.delegate = self
        editUsernameField.delegate = self
        editPasswordField.delegate = self
        editEmailField.delegate = self
        editGenderField.delegate = self
        editPhoneNumberField.delegate = self
        editAddressField.delegate = self
        

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
