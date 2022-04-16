//
//  UserSettingsViewController.swift
//  CovidPass
//
//  Created by Jasmine Lee on 4/15/22.
//

import UIKit
import Parse

struct SettingsOption2 {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}

class UserSettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UserSettingsTableViewCell.self, forCellReuseIdentifier: UserSettingsTableViewCell.identifier)
        return table
    }()
    
    var modelss = [SettingsOption]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        title = "Settings"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    func configure() {
        self.modelss = Array(0...100).compactMap({
            SettingsOption(title: "Item \($0)", icon: UIImage(systemName: "house"), iconBackgroundColor: .systemPink) {
                
            }
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelss.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model2 = modelss[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserSettingsTableViewCell.identifier, for: indexPath) as? UserSettingsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: model2)
        return cell
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
