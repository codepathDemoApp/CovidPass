//
//  SignupUserViewController.swift
//  CovidPass
//
//  Created by LYON on 4/19/22.
//

import UIKit
import Parse

class SignupUserVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!
    
    var username: String = ""
    var password: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        emailTextField.delegate = self
        genderTextField.delegate = self
        phoneTextField.delegate = self
        addressTextField.delegate = self
        countryTextField.delegate = self
        zipTextField.delegate = self
        stateTextField.delegate = self
        cityTextField.delegate = self
        
        nameTextField.autocorrectionType = .no
        emailTextField.autocorrectionType = .no
        genderTextField.autocorrectionType = .no
        phoneTextField.autocorrectionType = .no
        addressTextField.autocorrectionType = .no
        countryTextField.autocorrectionType = .no
        zipTextField.autocorrectionType = .no
        stateTextField.autocorrectionType = .no
        cityTextField.autocorrectionType = .no

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onDone(_ sender: Any) {
        if checkTextFields() == false {
            let alert = UIAlertController(title: "Invalid Information Input", message: "One or more text fields are invalid.", preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))

            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let user = PFUser()

        user.username = username
        user.password = password
        user["type"] = "user"
        user["name"] = nameTextField.text
        user["email"] = emailTextField.text
        user["gender"] = genderTextField.text
        user["phone"] = phoneTextField.text
        user["address"] = addressTextField.text
        user["country"] = countryTextField.text
        user["state"] = stateTextField.text
        user["city"] = cityTextField.text
        user["zip"] = zipTextField.text
        

        print("System: successfully signed \(user.username!) as user type account")

        user.signUpInBackground { success, error in
            if success {
                self.performSegue(withIdentifier: "loginToUserSegue", sender: nil)
            } else {
                print("Error: \(error!.localizedDescription)")
            }
        }
    }
    
    func checkTextFields() -> Bool{
        if nameTextField.text!.isEmpty || emailTextField.text!.isEmpty || genderTextField.text!.isEmpty || phoneTextField.text!.isEmpty || addressTextField.text!.isEmpty || countryTextField.text!.isEmpty || stateTextField.text!.isEmpty || zipTextField.text!.isEmpty || cityTextField.text!.isEmpty {
            return false
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == nameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            genderTextField.becomeFirstResponder()
        } else if textField == genderTextField {
            phoneTextField.becomeFirstResponder()
        } else if textField == phoneTextField {
            addressTextField.becomeFirstResponder()
        } else if textField == addressTextField {
            countryTextField.becomeFirstResponder()
        } else if textField == countryTextField {
            stateTextField.becomeFirstResponder()
        } else if textField == stateTextField {
            cityTextField.becomeFirstResponder()
        } else if textField == cityTextField {
            zipTextField.becomeFirstResponder()
        } else if textField == zipTextField {
            textField.resignFirstResponder()
            onDone((Any).self)
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

