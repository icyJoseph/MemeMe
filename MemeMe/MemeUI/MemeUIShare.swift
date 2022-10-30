//
//  MemeUIShare.swift
//  MemeMe
//
//  Created by Joseph Chamochumbi on 2022-10-30.
//

import Foundation
import UIKit

struct Meme {
    let memeImage: UIImage
    let originalImage: UIImage
    let topText: String
    let bottomText: String
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
