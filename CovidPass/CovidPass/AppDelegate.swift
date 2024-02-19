//
//  AppDelegate.swift
//  CovidPass
//
//  Created by Jackson Tran on 4/2/22.
//

import UIKit
import Parse

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Prase setup
        let parseConfig = ParseClientConfiguration {
            $0.applicationId = "QGQMN81EW7gvohQtYE5F5bpBkdJurKwhKRm75UV9"
            $0.clientKey = "OOqhE6MwfukiwRz1CGJ6e8dmRiq1MWDEuDQxJV50"
            $0.server = "http://parseapi.back4app.com"
        }
        Parse.initialize(with: parseConfig)
        
        // Asynchronous URL loading example using URLSession
        if let url = URL(string: "https://parsefiles.back4app.com/QGQMN81EW7gvohQtYE5F5bpBkdJurKwhKRm75UV9/4afa6d8382f97477869dd7614abcf700_file.bin") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                // Handle error
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                // Handle response and data
                if let httpResponse = response as? HTTPURLResponse {
                    print("Status code: \(httpResponse.statusCode)")
                }
                // Process received data
                if let data = data {
                    print("Received data: \(data)")
                }
            }.resume()
         }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

