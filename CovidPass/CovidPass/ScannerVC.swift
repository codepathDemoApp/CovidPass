//
//  HosterViewController.swift
//  CovidPass
//
//  Created by Jackson Tran on 4/16/22.
//

import UIKit
import SwiftUI
import CodeScanner

class HosterViewController: UIHostingController<TestSwiftUIView>{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder, rootView: TestSwiftUIView())
        rootView.dismiss = dismiss
    }
    
    func dismiss () {
        dismiss(animated: true, completion: nil)
    }
}

struct HosterViewController_Previews: PreviewProvider {
    static var previews: some View {
        TestSwiftUIView()
    }
}

struct TestSwiftUIView: View {
    
    var dismiss: (() -> Void)?
    
    var body: some View {
        CodeScannerView(
            codeTypes: [.qr],
            completion: { result in
                switch result {
                case .success(let result):
                    print(result.string)
                    dismiss!()
                case .failure(let error):
                    print("Scanned failed: \(error.localizedDescription)")
                }
            }
        )
    }
}
