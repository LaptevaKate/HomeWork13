//
//  SignInViewController.swift
//  HomeWork13
//
//  Created by Екатерина Лаптева on 26.04.22.
//

import UIKit

class SignInViewController: UIViewController, AlertPresenter {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        let doneToolBar = UIToolbar().addDoneButtonOnKeyboard()
        let done: UIBarButtonItem = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(self.doneButtonAction))
        doneToolBar.items?.append(done)
        userEmailTextField.inputAccessoryView = doneToolBar
        userPasswordTextField.inputAccessoryView = doneToolBar
    }
    
    //MARK: - Methods
    private func checkForRegistration() {
        guard let userEmail = userEmailTextField.text, let userPassword = userPasswordTextField.text, !userEmail.isEmpty || !userPassword.isEmpty else {
            showAlert(self, type: .empty)
            return
        }
        if let password = SaveUserInfo.shared.userPassword, let email = SaveUserInfo.shared.userEmail {
            if password == userPassword && email == userEmail {
                let mainVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "mainVC") as! MainViewController
                self.navigationController?.pushViewController(mainVC, animated: true)
            } else if password != userPassword || email != userEmail {
                showAlert(self, type: .notValid)
            }
        } else {
            showAlert(self, type: .noData)
        }
    }

    @objc private func doneButtonAction() {
        userPasswordTextField.resignFirstResponder()
        userEmailTextField.resignFirstResponder()
    }
    
    //MARK: - IBActions
    @IBAction func signInButtonTapped(_ sender: Any) {
        checkForRegistration()
    }
}
