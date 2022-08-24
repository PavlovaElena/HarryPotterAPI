//
//  SettingsStorageManager.swift
//  HarryPotterAPI
//
//  Created by Elena Pavlova on 24.08.2022.
//

import Foundation

class SettingsStorageManager {
    static var shared = SettingsStorageManager()
    
    private init() {}
    
    var mode: Mode {
        get {
            Mode(rawValue: UserDefaults.standard.integer(forKey: "selectedMode")) ?? .device
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "selectedMode")
        }
    }
}
