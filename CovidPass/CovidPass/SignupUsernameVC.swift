//
//  SignupUsernameViewController.swift
//  CovidPass
//
//  Created by LYON on 4/7/22.
//

import UIKit
import Parse

class SignupUsernameVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField.delegate = self
        usernameField.autocorrectionType = .no
        
        usernameField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let username = usernameField.text
        let destinationVC = segue.destination as! SignupPasswordVC
        destinationVC.username = username!
    }
    
    @IBAction func onNext(_ sender: Any) {
        let query = PFQuery(className: "_User")
        query.includeKey("username")
        query.findObjectsInBackground { (usernames, error) in
            if usernames != nil {
                let username = self.usernameField.text
                let listUser = usernames!
                for i in listUser {
                    let name = i["username"] as! String
                    if name == username {
                        let alert = UIAlertController(title: "Username already exist", message: "The username \(name) is not available.", preferredStyle: UIAlertController.Style.alert)

                        alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))

                        self.present(alert, animated: true, completion: nil)
                    }
                }
                self.performSegue(withIdentifier: "segueToPassword", sender: nil)
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if (usernameField.text!.count > 4) {
            nextButton.isUserInteractionEnabled = true
            nextButton.tintColor = UIColor.init(red: 36/255, green: 122/255, blue: 255/255, alpha: 1)
        } else {
            nextButton.isUserInteractionEnabled = false
            nextButton.tintColor = UIColor.init(red: 36/255, green: 122/255, blue: 255/255, alpha: 0.5)
        }
    }

    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Using return button
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == usernameField {
            textField.resignFirstResponder()
            onNext((Any).self)
        }
        return true
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
