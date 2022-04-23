//
//  UserSettingsViewController.swift
//  CovidPass
//
//  Created by Jasmine Lee on 4/15/22.
//

import UIKit
import Parse

struct Section2{
    let title: String
    let options: [SettingsOption2]
}

struct SettingsOption2 {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}

class UserSettingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UserSettingCell.self, forCellReuseIdentifier: UserSettingCell.identifier)
        return table
    }()
    
    var modelss = [Section2]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        title = "Settings"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        self.tabBarItem = UITabBarItem(title: "Setting", image: UIImage(systemName: "gear"), tag: 4)
    }
    
    func configure() {
        self.modelss.append(Section2(title: "General", options: [
    
            SettingsOption2(title: "FAQ", icon: UIImage(systemName: "book"), iconBackgroundColor: .systemGreen, handler: {
                print("Tapped second cell")
                
            }),
            SettingsOption2(title: "How the app works", icon: UIImage(systemName: "building"), iconBackgroundColor: .systemTeal, handler: {
                print("Tapped third cell")
                
            }), SettingsOption2(title: "Delete my data", icon: UIImage(systemName: "trash"), iconBackgroundColor: .systemBlue, handler: {
                print("Tapped third cell")
                
            })
        ]))
//      
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let model = modelss[indexPath.section].options[indexPath.row]
        model.handler()
        //connect pressing cell to going thru segue
        performSegue(withIdentifier: "ShowFAQUser", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 88
        let model3 = modelss[indexPath.section].options[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserSettingCell.identifier, for: indexPath) as? UserSettingCell else {
            return UITableViewCell()
        }
        cell.configure(with: model3)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return modelss.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelss[section].options.count
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
}
