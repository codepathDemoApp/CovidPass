//
//  UserHistoryViewController.swift
//  CovidPass
//
//  Created by LYON on 4/4/22.
//

import UIKit
import Parse

class UserHistoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var history = [PFObject]()
    var user = PFUser.current()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchData()
    }
    
    func fetchData() {
        let query = PFQuery(className: "History")
        query.whereKey("user", equalTo: user)
        query.order(byDescending: "date")
        query.limit = 20
        
        query.findObjectsInBackground { (history, error) in
            if let history = history {
                self.history = history
                DispatchQueue.main.async {
                    self.tableView.reloadData() // Reload the tableView after data is fetched
                }
            } else {
                if let error = error {
                    print("Error fetching history: \(error.localizedDescription)")
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    @IBAction func onAllRecords(_ sender: Any) {
        fetchData()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserHistoryCell", for: indexPath) as! UserHistoryCell
        
        let record = history[indexPath.row]
        let date = record["date"] as! Date
        let location = record["location"] as! PFUser
        
        let locationquery = PFUser.query()!
        locationquery.whereKey("objectId", equalTo: location.objectId!)
        
        locationquery.findObjectsInBackground { (locations, error) in
            if let locations = locations, let location = locations.first {
                DispatchQueue.main.async {
                    cell.locationLabel.text = location.object(forKey: "locationname") as? String ?? "No location name"
                }
            } else {
                print("Error fetching location: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
            
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMMM dd, yyyy"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let dateString = dateFormatter.string(from: date as Date)
        let timeString = timeFormatter.string(from: date as Date)
        cell.dateLabel.text = dateString
        cell.timeLabel.text = timeString
        
        cell.dateLabel.layer.cornerRadius = 5
        cell.dateLabel.clipsToBounds = true
        
        return cell
    }
    
    @IBAction func scanQR(_ sender: Any) {
    }
}
