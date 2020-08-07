//
//  SSTextField.swift
//  InputAccessoryView
//
//  Created by Shawn Gee on 8/7/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import SwiftUI

struct SSTextField: UIViewRepresentable {
    class ViewModel {
        var placeholder: String
        var text: Binding<String>
        var font: UIFont?
        var accessoryViewController: TextFieldAccessoryViewController?
        var tag: Int?
        
        init(_ placeholder: String, _ text: Binding<String>) {
            self.placeholder = placeholder
            self.text = text
        }
    }
    
    private var model: ViewModel
    
    init(_ placeholder: String, text: Binding<String>) {
        model = ViewModel(placeholder, text)
    }
    
    // MARK: - Lifecycle Methods
    
    func makeCoordinator() -> SSTextField.Coordinator {
        return Coordinator(self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SSTextField>) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        
        if let accessoryViewController = model.accessoryViewController, let tag = model.tag {
            textField.inputAccessoryView = accessoryViewController.view
            textField.tag = tag
            accessoryViewController.addTextField(textField)
        }
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<SSTextField>) {
        let textField = uiView
        textField.placeholder = model.placeholder
        textField.text = model.text.wrappedValue
        textField.font = model.font
    }
    
    static func dismantleUIView(_ uiView: UITextField, coordinator: SSTextField.Coordinator) {
        let textField = uiView
        if let accessoryViewController = coordinator.parent.model.accessoryViewController {
            accessoryViewController.removeTextField(textField)
        }
    }
    
    // MARK: - Modifiers
    
    func font(_ font: UIFont) -> SSTextField {
        model.font = font
        return self
    }
    
    func accessoryViewController(_ avc: TextFieldAccessoryViewController, tag: Int) -> SSTextField {
        model.accessoryViewController = avc
        model.tag = tag
        return self
    }
    
    // MARK: - Coordinator
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: SSTextField
        
        init(_ parent: SSTextField) {
            self.parent = parent
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            if let accessoryViewController = parent.model.accessoryViewController {
                accessoryViewController.setCurrentTextFieldTag(textField.tag)
            }
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            if let text = textField.text {
                parent.model.text.wrappedValue = text
            }
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if let accessoryViewController = parent.model.accessoryViewController {
                accessoryViewController.advanceToNextTextField()
            }
            return true
        }
    }
}
