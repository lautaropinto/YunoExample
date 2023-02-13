//
//  AppDelegate.swift
//  YunoExample
//
//  Created by Lautaro Pinto on 10/02/2023.
//

import UIKit
import YunoSDK

public enum YuboxResult: Int {
    case reject, succeeded, fail, processing, internalError, userCancell
    
    init?(yunoResult: Yuno.Result) {
        guard let result = YuboxResult(rawValue: yunoResult.rawValue) else  {
            return nil
        }
        self = result
    }
}

public protocol YuboxDelegate: AnyObject {
    
    func yuboxResult(_ result: YuboxResult)
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var delegate: YuboxDelegate?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Yuno.initialize(apiKey: "Yubox_Api_Key")
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

