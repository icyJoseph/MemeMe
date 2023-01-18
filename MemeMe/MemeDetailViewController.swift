//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Joseph Chamochumbi on 2023-01-17.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController {
    var meme: Meme!

    @IBOutlet var topText: MemeUITextField!
    @IBOutlet var bottomText: MemeUITextField!
    @IBOutlet var memeImage: UIImageView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        topText.textAlignment = .center
        bottomText.textAlignment = .center

        topText.text = meme.topText
        bottomText.text = meme.bottomText
        memeImage.image = meme.originalImage

        topText.isUserInteractionEnabled = false
        bottomText.isUserInteractionEnabled = false
    }
}
