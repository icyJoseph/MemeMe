//
//  ViewController.swift
//  MemeMe
//
//  Created by Joseph Chamochumbi on 2022-10-24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var topTextField: MemeUITextField!
    @IBOutlet var bottomTextField: MemeUITextField!

    @IBOutlet var imagePickerView: UIImageView!

    let topTextFieldDelegate = MemeUITextFieldDelegate()
    let bottomTextFieldDelegata = MemeUITextFieldDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()

        topTextField.delegate = topTextFieldDelegate
        bottomTextField.delegate = bottomTextFieldDelegata

        topTextField.setPlaceholder(text: "top")
        bottomTextField.setPlaceholder(text: "bottom")
    }

    @IBAction func pickAnImage(_ sender: Any) {
        let pickerController = UIImagePickerController()

        present(pickerController, animated: true, completion: nil)
    }
}
