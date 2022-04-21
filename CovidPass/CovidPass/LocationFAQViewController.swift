//
//  LocationFAQViewController.swift
//  CovidPass
//
//  Created by Jasmine Lee on 4/20/22.
//

import UIKit

class LocationFAQViewController: UIViewController {

    @IBOutlet weak var FAQLabel: UILabel!
    
    @IBOutlet weak var btnShow: UIButton!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var btnShow2: UIButton!
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var btnShow3: UIButton!
    @IBOutlet weak var label3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.isHidden = true
        label.text = "If you choose the user it takes you to a page where you can access your COVID Health Status. As a user you can also upload your COVID vaccination card, the location and time of your last check in and it will allow you to scan a QR code."

        label2.isHidden = true
        label2.text = "If you choose location you will access a page where you can generate and regenerate your own QR code. You can also see history records of people who accessed the location."
        
        label3.isHidden = true
        label3.text = "If you choose the user it takes you to a page where you can access your COVID Health Status. As a user you can also upload your COVID vaccination card under the first tab and press the Vaccination Card icon to upload your image."
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickShow(_ sender: Any) {
        if label.isHidden {
            animate(toogle: true, type: btnShow)
        } else {
            animate(toogle: false, type: btnShow)
        }
    }
    
    @IBAction func onClickShow2(_ sender: Any) {
        if label2.isHidden {
            animate2(toogle: true, type: btnShow2)
        } else {
            animate2(toogle: false, type: btnShow2)
        }
    }

    
    @IBAction func onClickShow3(_ sender: Any) {
        if label3.isHidden {
            animate3(toogle: true, type: btnShow3)
        } else {
            animate3(toogle: false, type: btnShow3)
        }
        
    }
    
    func animate(toogle: Bool, type: UIButton) {
        if type == btnShow {
            if toogle {
                UIView.animate(withDuration: 0.3) {
                    self.label.isHidden = false
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.label.isHidden = true
                }
            }
        }
    }
    
    func animate2(toogle: Bool, type: UIButton) {
        if type == btnShow2 {
            if toogle {
                UIView.animate(withDuration: 0.3) {
                    self.label2.isHidden = false
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.label2.isHidden = true
                }
            }
        }
    }
    
    func animate3(toogle: Bool, type: UIButton) {
        if type == btnShow3 {
            if toogle {
                UIView.animate(withDuration: 0.3) {
                    self.label3.isHidden = false
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.label3.isHidden = true
                }
            }
        }
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
