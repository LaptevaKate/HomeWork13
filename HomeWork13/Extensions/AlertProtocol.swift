//
//  AlertProtocol.swift
//  HomeWork13
//
//  Created by Екатерина Лаптева on 26.04.22.
//

import Foundation
import UIKit

enum AlertType: String {
    case empty = "Please, fill email and password"
    case notValid = "Email or Password is not valid"
    case noData = "There is no registered user"
}

protocol AlertPresenter {
    func showAlert(_ vc: UIViewController, type: AlertType)
}

extension AlertPresenter {
    func showAlert(_ vc: UIViewController, type: AlertType) {
        let alert = UIAlertController(title: "WARNING", message: type.rawValue, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
}
