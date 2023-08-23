//
//  LocalStore.swift
//  LandmarkApp
//
//  Created by Ahmed Tarık Bozyak on 23.08.2023.
//

import Foundation

final class LocalStore {
    
    static func setBoolValue(with value: Bool, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func getBoolValue(with key: String) -> Bool? {
        let defaults = UserDefaults.standard
        if let data = defaults.object(forKey: key) as? Bool {
            return data
        }
        return nil
    }
}
