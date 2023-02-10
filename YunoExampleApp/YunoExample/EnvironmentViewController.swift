//
//  EnvironmentViewController.swift
//  YunoExample
//
//  Created by Lautaro Pinto on 10/02/2023.
//

import UIKit
import Combine
import YunoSDK

class EnvironmentViewController: UIViewController {
    private var anyCancellables = Set<AnyCancellable>()
    
    @IBOutlet weak var apiKeyTextField: UITextField!

    
    @UserDefault(key: Key.apiKey.rawValue, defaultValue: "")
    var apiKey: String
    
    override func viewDidLoad() {
        super.viewDidLoad()

        apiKeyTextField.text = apiKey
        apiKeyTextField.publisher(for: \.text)
            .compactMap { $0?.trimmingCharacters(in: .whitespacesAndNewlines) }
            .sink { [weak self] (apiKey: String) in
                self?.apiKey = apiKey
            }
            .store(in: &anyCancellables)
        
    }
    
    @IBAction func goToA(_ sender: Any) {
        Yuno.initialize(apiKey: apiKey)
        performSegue(withIdentifier: "goToA", sender: self)
    }
    @IBAction func goToB(_ sender: Any) {
        Yuno.initialize(apiKey: apiKey)
        performSegue(withIdentifier: "goToB", sender: self)
    }
}
