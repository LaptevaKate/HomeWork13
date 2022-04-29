//
//  SignUpViewController.swift
//  HomeWork13
//
//  Created by Екатерина Лаптева on 26.04.22.
//

import UIKit

class SignUpViewController: UIViewController, AlertPresenter {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var emailEnterTextField: UITextField!
    @IBOutlet weak var passwordEnterTextField: UITextField!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        let doneToolBar = UIToolbar().addDoneButtonOnKeyboard()
        let done: UIBarButtonItem = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(self.doneButtonAction))
        doneToolBar.items?.append(done)
        emailEnterTextField.inputAccessoryView = doneToolBar
        passwordEnterTextField.inputAccessoryView = doneToolBar
    }
    
    //MARK: - Methods
    @objc private func doneButtonAction() {
        emailEnterTextField.resignFirstResponder()
        passwordEnterTextField.resignFirstResponder()
    }
    
    //MARK: - IBActions
    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let email = emailEnterTextField.text, let password = passwordEnterTextField.text, !email.isEmpty || !password.isEmpty else {
            showAlert(self, type: .empty)
            return
        }
        SaveUserInfo.shared.userEmail = email
        SaveUserInfo.shared.userPassword = password
        self.navigationController?.popViewController(animated: true)
    }
}
