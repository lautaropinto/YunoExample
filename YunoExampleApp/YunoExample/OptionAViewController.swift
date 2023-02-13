//
//  ViewController.swift
//  YunoExample
//
//  Created by Lautaro Pinto on 10/02/2023.
//

import UIKit
import YunoSDK

enum Key: String {
    case checkoutSession, customerSession, country, apiKey
    case language, paymentSelectedString, paymentToken
}

class OptionAViewController: UIViewController {
    
    var customerSession: String = ""
    var countryCode: String = ""
    var language: String = ""
    
    // MARK: - ViewController Lifecycle.
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func startEnrollment(_ sender: Any) {
        Yuno.enrollPayment(with: self, showPaymentStatus: true)
    }
}

extension OptionAViewController: YunoEnrollmentDelegate {
 
    func yunoEnrollmentResult(_ result: YunoSDK.Yuno.Result) {
        guard let yuboxResult = YuboxResult(yunoResult: result) else {
            return
        }
        // LOGIC
        AppDelegate.delegate?.yuboxResult(yuboxResult)
    }
}
