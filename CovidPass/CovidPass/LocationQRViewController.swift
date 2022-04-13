//
//  LocationQRViewController.swift
//  CovidPass
//
//  Created by Jackson Tran on 4/7/22.
//

import UIKit
import Parse
import QRCode

class LocationQRViewController: UIViewController {

    
    @IBOutlet weak var qrCodeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onLogout(_ sender: Any) {
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
    
    @IBAction func onRegenerate(_ sender: Any) {
        if qrCodeImage.image == nil {
            let qrCode = QRCode(generateRandomCode(length: 6))
            qrCodeImage.backgroundColor = nil
            qrCodeImage.image = qrCode?.image
            return
        }
        
        let alert = UIAlertController(title: "Regenerate QR Code", message: "Are you sure you want to regenerate your QR Code?", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { UIAlertAction in
            let qrCode = QRCode(self.generateRandomCode(length: 6))
            self.qrCodeImage.backgroundColor = nil
            self.qrCodeImage.image = qrCode?.image
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        

    }
    
    func generateRandomCode(length: Int)-> String{
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()!})
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
