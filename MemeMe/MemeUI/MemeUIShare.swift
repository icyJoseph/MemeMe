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

    func saveMeme() {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: memeImage)
        }, completionHandler: { success, reason in
            if success {
                print("Successfully saved image")

                // MARK: Save to Global Data

                let object = UIApplication.shared.delegate
                let appDelegate = object as! AppDelegate

                appDelegate.memes.append(self)
            }
            else if let reason {
                print("Failed to save", reason)
            }
            else {
                print("No reason, but saving has failed")
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
