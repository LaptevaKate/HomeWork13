//
//  SaveUserInfoViewController.swift
//  HomeWork13
//
//  Created by Екатерина Лаптева on 26.04.22.
//
import Foundation
import UIKit


enum SaveKeys: String {
    case userEmail, userPassword
}

class SaveUserInfo {
    
        private let defaults = UserDefaults.standard
        
        public static var shared = SaveUserInfo()
        
        var userEmail: String? {
            get {
                return defaults.string(forKey: SaveKeys.userEmail.rawValue)
            }
            set {
                defaults.setValue(newValue, forKey: SaveKeys.userEmail.rawValue)
            }
        }
        
        var userPassword: String? {
            get {
                return defaults.string(forKey: SaveKeys.userPassword.rawValue)
            }
            set {
                defaults.setValue(newValue, forKey: SaveKeys.userPassword.rawValue)
            }
        }
}
