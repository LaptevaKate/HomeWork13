//
//  AlertForMainVC.swift
//  HomeWork13
//
//  Created by Екатерина Лаптева on 2.05.22.
//

import Foundation
import UIKit


extension MainViewController {
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Warning",
                                      message: "No permission",
                                      preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning",
                                       message: "No permission",
                                       preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func openLink() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            presentUrlAlert()
        }
    }

    func presentUrlAlert() {
        let alert = UIAlertController(title: "Download from URL",
                                  message: "Enter url to download picture",
                                  preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Enter url to download picture"
        }
        let okAction = UIAlertAction(title: "OK",
                                 style: .default) { [weak self] action in
            guard let self = self, let text = alert.textFields?.first?.text else { return }
            if let url = URL(string: text) {
                self.downloadImage(url: url)
            } else {
                self.presentAlert(text: "Wrong URL!")
            }
        }
        let cancelAction = UIAlertAction(title: "CANCEL",
                                     style: .cancel,
                                     handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
    func presentAlert(text: String) {
        let alert = UIAlertController(title: "Attention",
                                  message: text,
                                  preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                 style: .default,
                                 handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}
