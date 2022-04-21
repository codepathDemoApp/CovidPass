//
//  HosterViewController.swift
//  CovidPass
//
//  Created by Jackson Tran on 4/16/22.
//

import UIKit
import SwiftUI
import CodeScanner
import Parse

class HosterViewController: UIHostingController<TestSwiftUIView>{
    
    var user = PFUser.current()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder, rootView: TestSwiftUIView())
        rootView.dismiss = dismiss
    }
    
    func dismiss (result: String) {
        updateHistory(result: result)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presentingViewController?.viewWillAppear(true)
    }
    
    func updateHistory(result:String) {
        let date = Date()
        var location = [PFObject]()
        let query = PFQuery(className: "_User")
        query.whereKey("qrcode", equalTo: result)
        do {
            location = try query.findObjects()
        } catch {
            print("ERROR: " + error.localizedDescription)
        }
        let history = PFObject(className: "History")
        
        history["user"] = user
        history["location"] = location[0]
        history["date"] = date
        history.saveInBackground()
    }
    
}

struct HosterViewController_Previews: PreviewProvider {
    static var previews: some View {
        TestSwiftUIView()
    }
}

struct TestSwiftUIView: View {
    var dismiss: ((String) -> Void)?
    
    var body: some View {
        CodeScannerView(
            codeTypes: [.qr],
            completion: { result in
                switch result {
                case .success(let result):
                    dismiss!(result.string)
                case .failure(let error):
                    print("Scanned failed: \(error.localizedDescription)")
                }
            }
        )
    }
}

