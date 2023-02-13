//
//  ViewController.swift
//  YunoExample
//
//  Created by Lautaro Pinto on 10/02/2023.
//

import UIKit
import YunoSDK

class MyAppEnrollmentDelegate: YunoEnrollmentDelegate {
    // MARK: Yuno - Requirements from YunoEnrollmentDelegate
    
    var customerSession: String = ""
    var countryCode: String = ""
    var language: String = ""
    
    var navigationController: UINavigationController?
    
    func yunoEnrollmentResult(_ result: YunoSDK.Yuno.Result) {
        guard let ruboxResult = YuboxResult(yunoResult: result) else {
            return
        }
        AppDelegate.delegate?.yuboxResult(ruboxResult)
    }
}

class OptionBViewController: UIViewController {
    
    let delegate: MyAppEnrollmentDelegate = MyAppEnrollmentDelegate()
        
    // MARK: - ViewController Lifecycle.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Filling YunoEnrollmentDelegate requirement data from UI components
        
        delegate.navigationController = self.navigationController
    }


    @IBAction func startEnrollment(_ sender: Any) {
        Yuno.enrollPayment(with: delegate, showPaymentStatus: true)
    }
}
