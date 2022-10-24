//
//  MemUITextFieldDelegate.swift
//  MemeMe
//
//  Created by Joseph Chamochumbi on 2022-10-24.
//

import Foundation
import UIKit

class MemeUITextFieldDelegate: NSObject, UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let current = textField.text

        if let current {
            let uppercased = (current as NSString).replacingCharacters(in: range, with: string).uppercased()

            textField.text = uppercased
        }

        if let textRange = persistCursorPosition(textField, range: range, string: string) {
            textField.selectedTextRange = textRange
        }

        return false
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        // TODO: Only the first time perhaps?
        // TODO: Otherwise use the placeholder solution
        textField.text = ""
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func persistCursorPosition(_ textField: UITextField, range: NSRange, string: String) -> UITextRange? {
        let selectedRange = NSMakeRange(range.location + string.count, 0)
        let from = textField.position(from: textField.beginningOfDocument, offset: selectedRange.location)

        if let from {
            let to = textField.position(from: from, offset: selectedRange.length)

            if let to {
                return textField.textRange(from: from, to: to)
            }
        }

        return nil
    }
}
