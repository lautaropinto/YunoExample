//
//  UserDefault.swift
//  YunoExample
//
//  Created by Lautaro Pinto on 10/02/2023.
//

import Foundation

@propertyWrapper
struct UserDefault<Value> {
    
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard

    var wrappedValue: Value {
        get {
            return container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }
}
