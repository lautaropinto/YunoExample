//
//  ViewController.swift
//  YunoExample
//
//  Created by Lautaro Pinto on 10/02/2023.
//

import UIKit
import Combine
import YunoSDK

class MyAppEnrollmentDelegate: YunoEnrollmentDelegate {
    // MARK: Yuno - Requirements from YunoEnrollmentDelegate
    
    init() {
        customerSession = ""
        countryCode = ""
        language = ""
    }
    
    var customerSession: String
    var countryCode: String
    var language: String
    
    var navigationController: UINavigationController?
    
    func yunoEnrollmentResult(_ result: YunoSDK.Yuno.Result) {
        debugPrint("yunoEnrollmentResult \(result)")
    }
}

class OptionBViewController: UIViewController {
    
    private var anyCancellables = Set<AnyCancellable>()
    
    @IBOutlet weak var customerSessionTextField: UITextField!
    @IBOutlet weak var countryCodeTextField: UITextField!
    @IBOutlet weak var languageTextField: UITextField!
    
    let delegate: MyAppEnrollmentDelegate = MyAppEnrollmentDelegate()
        
    // MARK: - ViewController Lifecycle.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Filling YunoEnrollmentDelegate requirement data from UI components
        
        delegate.navigationController = self.navigationController
        
        customerSessionTextField.text = delegate.customerSession
        customerSessionTextField.publisher(for: \.text)
            .compactMap { $0?.trimmingCharacters(in: .whitespacesAndNewlines) }
            .sink { [weak self] (customerSession: String) in
                guard let self = self else { return }
                self.delegate.customerSession = customerSession
            }
            .store(in: &anyCancellables)
        
        countryCodeTextField.text = delegate.countryCode
        countryCodeTextField.publisher(for: \.text)
            .compactMap { $0?.trimmingCharacters(in: .whitespacesAndNewlines) }
            .sink { [weak self] (countryCode: String) in
                guard let self = self else { return }
                self.delegate.countryCode = countryCode
            }
            .store(in: &anyCancellables)
        languageTextField.text = delegate.language
        languageTextField.publisher(for: \.text)
            .compactMap { $0?.trimmingCharacters(in: .whitespacesAndNewlines) }
            .sink { [weak self] (language: String) in
                guard let self = self else { return }
                self.delegate.language = language
            }
            .store(in: &anyCancellables)
    }


    @IBAction func startEnrollment(_ sender: Any) {
        Yuno.enrollPayment(with: delegate, showPaymentStatus: true)
    }
}
