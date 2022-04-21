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

class UserHomeVC: UIViewController {

    

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
        
        var history = [PFObject]()
        let query = PFQuery(className: "History")
        query.whereKey("user", equalTo: user)
        query.order(byDescending: "date")
        query.limit = 1
        do {
            history = try query.findObjects()
        } catch {
            print("ERROR:" + error.localizedDescription)
        }
        if history.isEmpty {
            return
        }
        
        let date = history[0]["date"] as! Date
        let location = history[0]["location"] as! PFUser
        
        let locationquery = PFUser.query()!
        locationquery.whereKey("objectId", equalTo: location.objectId!)
        
        var loc = [PFObject]()
        do {
            loc = try locationquery.findObjects()
        } catch {
            print("ERROR:" + error.localizedDescription)
        }
        lastCheckInNameLabel.text = loc[0].object(forKey: "locationname") as? String ?? "No location name"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy 'at' HH:mm"
        let dateString = dateFormatter.string(from: date as Date)
        lastCheckInDateLabel.text = dateString
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
