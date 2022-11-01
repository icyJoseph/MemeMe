//
//  ViewController.swift
//  MemeMe
//
//  Created by Joseph Chamochumbi on 2022-10-24.
//

import UIKit

class MemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
        subscribeToKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topTextField.delegate = topTextFieldDelegate
        bottomTextField.delegate = bottomTextFieldDelegate
        
        topTextField.setPlaceholder(text: "top")
        bottomTextField.setPlaceholder(text: "bottom")
        imagePickerView.contentMode = .scaleAspectFit
        
        shareButton.isEnabled = false

        let frontCameraAvailable = UIImagePickerController.isCameraDeviceAvailable(UIImagePickerController.CameraDevice.front)
        let rearCameraAvailable = UIImagePickerController.isCameraDeviceAvailable(UIImagePickerController.CameraDevice.rear)

        cameraPickerButton.isEnabled = frontCameraAvailable || rearCameraAvailable
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: Actions
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        pickImage(source: .photoLibrary)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        pickImage(source: .camera)
    }
    
    @IBAction func cancelMeme(_ sender: Any) {
        topTextField.text = ""
        bottomTextField.text = ""
        shareButton.isEnabled = false
        imagePickerView.image = nil
    }
    
    @IBAction func shareMeme(_ sender: Any) {
        navigationBar.isHidden = true
        toolBar.isHidden = true
        
        let memeImage = generateMemeImage(view: view)
        
        navigationBar.isHidden = false
        toolBar.isHidden = false
       
        let originalImage = imagePickerView.image
        let topText = topTextField.text
        let bottomText = bottomTextField.text
        
        if let memeImage, let originalImage, let topText, let bottomText {
            let meme = Meme(memeImage: memeImage, originalImage: originalImage, topText: topText, bottomText: bottomText)
            
            let activityController = UIActivityViewController(activityItems: [memeImage], applicationActivities: nil)
            
            activityController.completionWithItemsHandler = {
                (activityType: UIActivity.ActivityType?, completed:
                    Bool, _: [Any]?, _: Error?) in
                
                if let activityType {
                    switch activityType {
                    case .saveToCameraRoll:
                        // no need to save a duplicate
                        if completed { return }
                        // saving to camera roll did not complete
                        // try to save
                        return saveMeme(meme: meme)
                    default:
                        // save photo
                        return saveMeme(meme: meme)
                    }
                }
            }
            
            present(activityController, animated: true, completion: nil)
        }
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

    func pickImage(source: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = source

        present(pickerController, animated: true, completion: nil)
    }
}
