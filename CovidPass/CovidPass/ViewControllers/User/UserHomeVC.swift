//
//  HomeViewController.swift
//  CovidPass
//
//  Created by LYON on 4/4/22.
//

import UIKit
import Parse
import SwiftUI
import CodeScanner
import PhotosUI
import AlamofireImage

class UserHomeVC: UIViewController, PHPickerViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var lastCheckInNameLabel: UILabel!
    @IBOutlet weak var lastCheckInDateLabel: UILabel!
    @State private var isShowingScanner = false
    
    var user = PFUser.current()!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getHistoryImage()
    }
    
    func getHistoryImage() {
        let query = PFQuery(className: "History")
        query.whereKey("user", equalTo: user)
        query.order(byDescending: "date")
        query.limit = 1
        
        query.findObjectsInBackground { (objects, error) in
            if let error = error {
                print("Error fetching history: \(error.localizedDescription)")
                return
            }
            
            guard let history = objects as? [PFObject], let latestHistory = history.first else {
                print("History not found")
                return
            }
            
            guard let date = latestHistory["date"] as? Date,
                  let location = latestHistory["location"] as? PFUser else {
                print("Date or location not found in history")
                return
            }
            
            let locationquery = PFUser.query()!
            locationquery.whereKey("objectId", equalTo: location.objectId!)
            
            locationquery.findObjectsInBackground { (locationObjects, error) in
                if let error = error {
                    print("Error fetching location: \(error.localizedDescription)")
                    return
                }
                
                guard let location = locationObjects?.first, let locationName = location["locationname"] as? String else {
                    print("Location not found")
                    return
                }
                
                DispatchQueue.main.async {
                    self.lastCheckInNameLabel.text = locationName
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MMMM dd, yyyy 'at' HH:mm"
                    let dateString = dateFormatter.string(from: date)
                    self.lastCheckInDateLabel.text = dateString
                }
            }
            
            guard let imageFile = self.user["image"] as? PFFileObject else {
                print("Image file not found")
                return
            }
            
            imageFile.getDataInBackground { (data, error) in
                if let error = error {
                    print("Error fetching image data: \(error.localizedDescription)")
                    return
                }
                
                guard let imageData = data else {
                    print("Image data not found")
                    return
                }
                
                if let uiimage = UIImage(data: imageData) {
                    let flippedImage = UIImage(cgImage: uiimage.cgImage!, scale: 1.0, orientation: .right)
                    DispatchQueue.main.async {
                        self.cardImage.image = flippedImage
                    }
                } else {
                    print("Failed to create UIImage from data")
                }
            }
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
    
    @IBAction func onUpload(_ sender: Any) {
        
        var configuration = PHPickerConfiguration()
        configuration.filter = .images

        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            let previousImage = cardImage.image
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    guard let self = self, let image = image as? UIImage, self.cardImage.image == previousImage else { return }
                    
                    let size = CGSize(width: 400, height: 600)
                    let scaledImage = image.af.imageAspectScaled(toFill: size)
                    let flippedImage = UIImage(cgImage: scaledImage.cgImage!, scale: 1.0, orientation: .right)
                    
                    self.cardImage.image = flippedImage
                    
                    let imageData = self.cardImage.image!.pngData()
                    let file = PFFileObject(data: imageData!)
                    self.user["image"] = file
                    
                    self.user.saveInBackground { (success, error) in
                        if success {
                            print("saved!")
                        } else {
                            print("ERROR: \(error!.localizedDescription)")
                        }
                    }
                }
            }
        }
        dismiss(animated: true, completion: nil)
        
    }
}
