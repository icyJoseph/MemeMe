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

    let topTextFieldDelegate = MemeUITextFieldDelegate()
    let bottomTextFieldDelegata = MemeUITextFieldDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()

        topTextField.delegate = topTextFieldDelegate
        bottomTextField.delegate = bottomTextFieldDelegata

        topTextField.text = "top"
        bottomTextField.text = "bottom"
    }
}
