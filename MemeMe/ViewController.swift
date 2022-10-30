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
    
    @IBOutlet var cameraPickerButton: UIBarButtonItem!
    @IBOutlet var shareButton: UIBarButtonItem!
    
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var toolBar: UIToolbar!
    
    let topTextFieldDelegate = MemeUITextFieldDelegate()
    let bottomTextFieldDelegate = MemeUITextFieldDelegate()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let frontCameraAvailable = UIImagePickerController.isCameraDeviceAvailable(UIImagePickerController.CameraDevice.front)
        let rearCameraAvailable = UIImagePickerController.isCameraDeviceAvailable(UIImagePickerController.CameraDevice.rear)
        
        cameraPickerButton.isEnabled = frontCameraAvailable || rearCameraAvailable
        
        subscribeToKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topTextField.delegate = topTextFieldDelegate
        bottomTextField.delegate = bottomTextFieldDelegate
        
        topTextField.setPlaceholder(text: "top")
        bottomTextField.setPlaceholder(text: "bottom")
        
        shareButton.isEnabled = false
        imagePickerView.contentMode = .scaleAspectFit
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: Actions
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary // deprecated soon
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .camera
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func cancelMeme(_ sender: Any) {
        topTextField.text = ""
        bottomTextField.text = ""
        shareButton.isEnabled = false
        imagePickerView.image = nil
    }
    
    // Saves and shares
    @IBAction func saveMeme(_ sender: Any) {
        navigationBar.isHidden = true
        toolBar.isHidden = true
        
        let memeImage = generateMemeImage(view: view)
        
        navigationBar.isHidden = false
        toolBar.isHidden = false
        
        let activityController = UIActivityViewController(activityItems: [memeImage!], applicationActivities: nil)
        
        present(activityController, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate protocol methods

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.image = image
            shareButton.isEnabled = true
        }
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    // MARK: Subscription management to keyboard show/hide

    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Callbacks to keyboard show/hide

    @objc func keyboardWillShow(_ notification: Notification) {
        let keyboardHeight = getKeyboardHeight(notification)
        
        if view.frame.origin.y + keyboardHeight != 0, bottomTextField.isEditing {
            view.frame.origin.y -= keyboardHeight
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }

    // MARK: Utils

    // This works imilarly to getting a bounding rectangle
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
}
