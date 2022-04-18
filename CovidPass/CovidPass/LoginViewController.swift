//
//  LoginViewController.swift
//  CovidPass
//
//  Created by LYON on 5/2/22.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var textSecureButton: UIButton!
    
    var iconClick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameField.delegate = self
        passwordField.delegate = self
        usernameField.autocorrectionType = .no
        passwordField.autocorrectionType = .no
        
        signInButton.layer.cornerRadius = 12
        signInButton.layer.masksToBounds = true
        
        // Do any additional setup after loading the view.
    }
    
    // Secure Button. Allows user to look at their password.
    @IBAction func onSecure(_ sender: Any) {
        if(iconClick == true) {
            let image = UIImage(systemName: "eye")
            textSecureButton.setImage(image, for: UIControl.State.normal)
            passwordField.isSecureTextEntry = false
            
        } else {
            let image = UIImage(systemName: "eye.slash")
            textSecureButton.setImage(image, for: UIControl.State.normal)
            passwordField.isSecureTextEntry = true
        }

        iconClick = !iconClick
    }
    
    // Sign in
    @IBAction func onSignIn(_ sender: Any) {
        
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { user, error in

            if user != nil {
                let usertype = user?["type"] as! String
                if usertype == "location" {
                    self.performSegue(withIdentifier: "loginToLocationSegue", sender: nil)
                } else {
                    self.performSegue(withIdentifier: "loginToUserSegue", sender: nil)
                }
            } else {
                print("Error: \(error!.localizedDescription)")
                let alert = UIAlertController(title: "Incorrect Password", message: "The username or password you entered is incorrect.", preferredStyle: UIAlertController.Style.alert)

                alert.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: nil))

                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // Using return button
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == usernameField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            textField.resignFirstResponder()
            onSignIn((Any).self)
        }
        return true
    }
    
    // responsive signIn button
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if (!(usernameField.text?.count == 0) && !(passwordField.text?.count == 0)) {
            signInButton.isUserInteractionEnabled = true
            signInButton.tintColor = UIColor.init(red: 36/255, green: 122/255, blue: 255/255, alpha: 1)
        } else {
            signInButton.isUserInteractionEnabled = false
            signInButton.tintColor = UIColor.init(red: 36/255, green: 122/255, blue: 255/255, alpha: 0.5)
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
