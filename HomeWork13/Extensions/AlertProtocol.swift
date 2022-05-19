//
//  AlertProtocol.swift
//  HomeWork13
//
//  Created by Екатерина Лаптева on 26.04.22.
//

import Foundation
import UIKit

enum AlertType: String {
    case empty = "Please,check, if all the fields are filled"
    case notValid = "Password is not valid"
    case noData = "There is no registered user"
    case repeatPassword = "Please,repeat password"
    case changedPassword = "Your password has been changed"
}

protocol AlertPresenter {
    func showAlert(_ vc: UIViewController, type: AlertType, completion: (() -> Void)?)
}

extension AlertPresenter {
    func showAlert(_ vc: UIViewController, type: AlertType, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "WARNING", message: type.rawValue, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
}
