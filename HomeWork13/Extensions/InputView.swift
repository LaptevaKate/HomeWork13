//
//  InputView.swift
//  HomeWork13
//
//  Created by Екатерина Лаптева on 26.04.22.
//

import Foundation
import UIKit

extension UIToolbar {
    func addDoneButtonOnKeyboard() -> UIToolbar {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let items = [flexSpace]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        return doneToolbar
    }
}
