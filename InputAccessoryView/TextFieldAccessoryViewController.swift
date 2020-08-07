//
//  TextFieldAccessoryViewController.swift
//  InputAccessoryView
//
//  Created by Shawn Gee on 8/7/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import SwiftUI
import UIKit

class TextFieldAccessoryViewController: UIHostingController<TextFieldAccessoryView> {
    
    // MARK: - Init
    
    convenience init () {
        self.init(rootView: TextFieldAccessoryView())
    }
    
    private override init(rootView: TextFieldAccessoryView) {
        super.init(rootView: rootView)
        view.frame = CGRect(x: 0, y: 0, width: 0 , height: 40)
        view.backgroundColor = .darkGray
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods

    func addTextField(_ textField: UITextField) {
        rootView.textFields.append(textField)
    }
    
    func removeTextField(_ textField: UITextField) {
        rootView.textFields.removeAll(where: { $0 == textField })
    }
    
    func setCurrentTextFieldTag(_ tag: Int) {
        rootView.currentTextFieldTag = tag
    }
    
    func advanceToNextTextField() {
        rootView.nextTextField()
    }
}
