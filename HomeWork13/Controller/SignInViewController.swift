//
//  SignInViewController.swift
//  HomeWork13
//
//  Created by Екатерина Лаптева on 26.04.22.
//

import UIKit

class SignInViewController: UIViewController, AlertPresenter {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordLabel: UILabel!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var recoverPasswordButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let doneToolBar = UIToolbar().addDoneButtonOnKeyboard()
        let done: UIBarButtonItem = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(self.doneButtonAction))
        doneToolBar.items?.append(done)
        passwordTextField.inputAccessoryView = doneToolBar
        repeatPasswordTextField.inputAccessoryView = doneToolBar
        passwordTextField.becomeFirstResponder()
        if !PasswordManager.shared.firstAutorization {
            repeatPasswordTextField.isHidden = true
            repeatPasswordLabel.isHidden = true
            signInButton.setTitle("Log In", for: .normal)
        } else {
            recoverPasswordButton.isHidden = true
            signInButton.setTitle("Sign In", for: .normal)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        passwordTextField.text = ""
    }
    
    //MARK: - Methods
    @objc private func doneButtonAction() {
        passwordTextField.resignFirstResponder()
        repeatPasswordTextField.resignFirstResponder()
    }
   
    //MARK: - IBActions
    @IBAction func signInButtonTapped(_ sender: Any) {
        guard let password = passwordTextField.text else {
            return
        }
        if PasswordManager.shared.firstAutorization {
            if password.isEmpty {
                showAlert(self, type: .empty)
            } else {
                if password == repeatPasswordTextField.text {
                    PasswordManager.shared.save(password)
                    createViewController(String(describing: MainViewController.self))
                } else {
                    showAlert(self, type: .repeatPassword)
                }
            }
        } else {
            if PasswordManager.shared.validate(password) {
                createViewController(String(describing: MainViewController.self))
            } else {
                showAlert(self, type: .noData)
            }
        }
    }

    @IBAction func recoverPasswordButtonPressed(_ sender: UIButton) {
        createViewController(String(describing: SettingsViewController.self))
    }
}

// MARK: - Extension UITextFieldDelegate
extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
// MARK: - UIViewController
extension UIViewController {
    func createViewController(_ identifier: String) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyboard.instantiateViewController(identifier: identifier)
        navigationController?.pushViewController(newViewController, animated: true)
        navigationController?.modalPresentationStyle = .fullScreen
    }
}
