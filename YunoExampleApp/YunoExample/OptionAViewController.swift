//
//  ViewController.swift
//  YunoExample
//
//  Created by Lautaro Pinto on 10/02/2023.
//

import UIKit
import Combine
import YunoSDK

enum Key: String {
    case checkoutSession, customerSession, country, apiKey
    case language, paymentSelectedString, paymentToken
}

class OptionAViewController: UIViewController, YunoEnrollmentDelegate {
    
    private var anyCancellables = Set<AnyCancellable>()
    
    @IBOutlet weak var customerSessionTextField: UITextField!
    @IBOutlet weak var countryCodeTextField: UITextField!
    @IBOutlet weak var languageTextField: UITextField!
    
    // MARK: Yuno - Requirements from YunoEnrollmentDelegate
    @UserDefault(key: Key.customerSession.rawValue, defaultValue: "")
    var customerSession: String
    @UserDefault(key: Key.country.rawValue, defaultValue: "")
    var countryCode: String
    @UserDefault(key: Key.language.rawValue, defaultValue: "")
    var language: String
    
    func yunoEnrollmentResult(_ result: YunoSDK.Yuno.Result) {
        debugPrint("yunoEnrollmentResult \(result)")
    }
    
    // MARK: - ViewController Lifecycle.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Filling YunoEnrollmentDelegate requirement data from UI components
        customerSessionTextField.text = customerSession
        customerSessionTextField.publisher(for: \.text)
            .compactMap { $0?.trimmingCharacters(in: .whitespacesAndNewlines) }
            .sink { [weak self] (customerSession: String) in
                guard let self = self else { return }
                self.customerSession = customerSession
            }
            .store(in: &anyCancellables)
        
        countryCodeTextField.text = countryCode
        countryCodeTextField.publisher(for: \.text)
            .compactMap { $0?.trimmingCharacters(in: .whitespacesAndNewlines) }
            .sink { [weak self] (countryCode: String) in
                guard let self = self else { return }
                self.countryCode = countryCode
            }
            .store(in: &anyCancellables)
        languageTextField.text = language
        languageTextField.publisher(for: \.text)
            .compactMap { $0?.trimmingCharacters(in: .whitespacesAndNewlines) }
            .sink { [weak self] (language: String) in
                guard let self = self else { return }
                self.language = language
            }
            .store(in: &anyCancellables)
    }


    @IBAction func startEnrollment(_ sender: Any) {
        Yuno.enrollPayment(with: self, showPaymentStatus: true)
    }
}

