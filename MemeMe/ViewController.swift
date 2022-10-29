//
//  ViewController.swift
//  MemeMe
//
//  Created by Joseph Chamochumbi on 2022-10-24.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

        imagePickerView.contentMode = .scaleAspectFit
    }

    @IBAction func pickAnImage(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.image = image
        }

        dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
