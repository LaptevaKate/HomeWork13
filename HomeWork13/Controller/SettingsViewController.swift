//
//  SignUpViewController.swift
//  HomeWork13
//
//  Created by Екатерина Лаптева on 26.04.22.
//

import UIKit

class SettingsViewController: UIViewController, AlertPresenter {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var enterNewPasswordTextField: UITextField!
    @IBOutlet weak var repeatNewPasswordTextField: UITextField!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let doneToolBar = UIToolbar().addDoneButtonOnKeyboard()
        let done: UIBarButtonItem = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(self.doneButtonAction))
        doneToolBar.items?.append(done)
        
        enterNewPasswordTextField.inputAccessoryView = doneToolBar
        repeatNewPasswordTextField.inputAccessoryView = doneToolBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    //MARK: - Methods
    @objc private func doneButtonAction() {
        enterNewPasswordTextField.resignFirstResponder()
        repeatNewPasswordTextField.resignFirstResponder()
    }
    
    //MARK: - IBActions
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        guard let password = enterNewPasswordTextField.text else {
            return
        }
        if password.isEmpty {
            showAlert(self, type: .empty)
        } else {
            if password == repeatNewPasswordTextField.text {
                PasswordManager.shared.save(password)
                showAlert(self, type: .changedPassword) {
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                showAlert(self, type: .repeatPassword)
            }
        }
    }
}
