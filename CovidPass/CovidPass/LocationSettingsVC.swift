//
//  SettingsViewController.swift
//  CovidPass
//
//  Created by LYON on 4/7/22.
//

import UIKit
import Parse

struct Section{
    let title: String
    let options: [SettingsOption]
}
struct SettingsOption{
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}

class LocationSettingsVC: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        title = "Settings"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds

        // Do any additional setup after loading the view.
    }
    var models = [Section]()
    let contents = ["Notifications", "FAQ", "About"]
    func configure(){
        models.append(Section(title: "General", options: [
            SettingsOption(title: "Notifications", icon: UIImage(systemName: "bell"), iconBackgroundColor: .systemRed, handler:
                            {
                print("Tapped first cell")
                
                            }),
            SettingsOption(title: "FAQ", icon: UIImage(systemName: "book"), iconBackgroundColor: .systemGreen, handler:
                            {
                print("Tapped second cell")
                
                            }),
            SettingsOption(title: "How the app works", icon: UIImage(systemName: "building"), iconBackgroundColor: .systemTeal, handler:
                            {
                print("Tapped third cell")
                
                            }),
            SettingsOption(title: "Delete my data", icon: UIImage(systemName: "trash"), iconBackgroundColor: .systemBlue, handler:
                            {
                print("Tapped third cell")
                
            })
        ]))
           
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.section].options[indexPath.row]
        model.handler()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 88
        let model = models[indexPath.section].options[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath
        ) as? SettingsTableViewCell else{
            return UITableViewCell()
        }
        cell.configure(with: model)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // print("you tapped")
        return models[section].options.count
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
