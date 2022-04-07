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
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameField.delegate = self
        passwordField.delegate = self
        
        signInButton.layer.cornerRadius = 12
        signInButton.layer.masksToBounds = true
//        signUpButton.layer.cornerRadius = 12
//        signUpButton.layer.masksToBounds = true
        
        // Do any additional setup after loading the view.
    }
    
    // Sign in
    @IBAction func onSignIn(_ sender: Any) {
        
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { user, error in
            if user != nil {
                self.performSegue(withIdentifier: "loginToUserSegue", sender: nil)
            } else {
                print("Error: \(error!.localizedDescription)")
                let alert = UIAlertController(title: "Incorrect Password", message: "The username or password you entered is incorrect.", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // Sign up
    @IBAction func onSignUp(_ sender: Any) {
        
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackground { success, error in
            if success {
                self.performSegue(withIdentifier: "loginToUserSegue", sender: nil)
            } else {
                print("Error: \(error!.localizedDescription)")
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == usernameField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            textField.resignFirstResponder()
        }
        onSignIn((Any).self)
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
