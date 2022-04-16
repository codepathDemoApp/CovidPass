//
//  LocationQRViewController.swift
//  CovidPass
//
//  Created by Jackson Tran on 4/7/22.
//

import UIKit
import Parse
import QRCode

class LocationCodeVC: UIViewController {

    
    @IBOutlet weak var qrCodeImage: UIImageView!
    
    var user = PFUser.current()!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
//
//        longPressRecognizer.minimumPressDuration = 0.5
//        qrCodeImage.addGestureRecognizer(longPressRecognizer)
//        qrCodeImage.isUserInteractionEnabled = true
//        view.addSubview(qrCodeImage)
        
        // Do any additional setup after loading the view.
    }
    
//    @objc func longPressed(sender: UILongPressGestureRecognizer) {
//        UIImageWriteToSavedPhotosAlbum(qrCodeImage.image!, self, nil, nil)
//        }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//            // Dispose of any resources that can be recreated.
//    }

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
            let code = generateRandomCode(length: 6)
            let qrCode = QRCode(code)
            qrCodeImage.backgroundColor = nil
            qrCodeImage.image = qrCode?.image
            user["qrcode"] = code
            user.saveInBackground()
            return
        }
        
        let alert = UIAlertController(title: "Regenerate QR Code", message: "Are you sure you want to regenerate your QR Code?", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { UIAlertAction in
            let code = self.generateRandomCode(length: 6)
            let qrCode = QRCode(code)
            self.qrCodeImage.backgroundColor = nil
            self.qrCodeImage.image = qrCode?.image
            self.user["qrcode"] = code
            self.user.saveInBackground()
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
