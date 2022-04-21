//
//  SignupPasswordViewController.swift
//  CovidPass
//
//  Created by LYON on 4/7/22.
//

import UIKit

class SignupPasswordVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var username: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordField.autocorrectionType = .no
        passwordField.delegate = self
        
        passwordField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let password = passwordField.text
        let destinationVC = segue.destination as! SignupTypeVC
        destinationVC.password = password!
        destinationVC.username = username
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if (passwordField.text!.count > 5) {
            nextButton.isUserInteractionEnabled = true
            nextButton.tintColor = UIColor.init(red: 36/255, green: 122/255, blue: 255/255, alpha: 1)
        } else {
            nextButton.isUserInteractionEnabled = false
            nextButton.tintColor = UIColor.init(red: 36/255, green: 122/255, blue: 255/255, alpha: 0.5)
        }
    }
    
    @IBAction func onNext(_ sender: Any) {
        self.performSegue(withIdentifier: "segueToType", sender: nil)
    }
    
    
    // Using return button
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == passwordField {
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
