//
//  MemeUIShare.swift
//  MemeMe
//
//  Created by Joseph Chamochumbi on 2022-10-30.
//

import Foundation
import Photos
import UIKit

struct Meme {
    let memeImage: UIImage
    let originalImage: UIImage
    let topText: String
    let bottomText: String

    func saveMeme(saveToCameraRoll: Bool) {
        // MARK: Save to Global Data

        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate

        appDelegate.memes.append(self)

        if !saveToCameraRoll { return }

        // MARK: Save to device's camera roll

        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: memeImage)
        }, completionHandler: { success, reason in
            if success {
                print("Saved image to camera roll")
            }
            else if let reason {
                print("Failed to save to camera roll", reason)
            }
            else {
                print("Unexpected error while saving to camera roll")
            }
        })
    }
}

func generateMemeImage(view: UIView) -> UIImage? {
    UIGraphicsBeginImageContext(view.frame.size)
    view.drawHierarchy(in: view.frame, afterScreenUpdates: true)

    if let memeImage = UIGraphicsGetImageFromCurrentImageContext() {
        UIGraphicsEndImageContext()

        return memeImage
    }

    return nil
}
