//
//  MemeTabBarController.swift
//  MemeMe
//
//  Created by Joseph Chamochumbi on 2023-01-10.
//

import Foundation
import UIKit

class MemeTabViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let createMemeIcon = UIImage(systemName: "plus")?.withRenderingMode(.automatic)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: createMemeIcon, style: .plain, target: self, action: #selector(createMeme))
    }

    @objc func createMeme(sender: Any) {
        performSegue(withIdentifier: "createMemeSegue", sender: sender)
    }
}
