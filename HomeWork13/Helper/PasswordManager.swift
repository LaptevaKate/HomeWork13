//
//  PasswordManager.swift
//  HomeWork13
//
//  Created by Екатерина Лаптева on 19.05.22.
//

import Foundation
import UIKit
import SwiftyKeychainKit


class PasswordManager {
    static let shared = PasswordManager()
    private lazy var keychain = Keychain(service: "by.Lapteva.HomeWork13")
    private let passwordKey = KeychainKey<String>(key: "password")
    private init() { }
    
 
    func remove() {
        do {
            try keychain.removeAll()
        } catch {
            print(error.localizedDescription)
        }
    }

    func validate(_ password: String) -> Bool {
        do {
            let storedPassword = try keychain.get(passwordKey)
            return password == storedPassword
        } catch {
            print(error.localizedDescription)
            return false
        }
    }

    func save(_ password: String) {
        do {
            try keychain.set(password, for: passwordKey)
        } catch {
            print(error.localizedDescription)
        }
    }

    var firstAutorization: Bool {
        do {
            if let autorization = try keychain.get(passwordKey) {
                return autorization.isEmpty == true
            }
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}
