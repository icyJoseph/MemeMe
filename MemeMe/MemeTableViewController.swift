//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Joseph Chamochumbi on 2023-01-14.
//

import Foundation
import UIKit

class MemeTableViewController: UITableViewController {
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell")!

        let meme = memes[indexPath.row]

        cell.textLabel?.text = meme.topText

        cell.imageView?.image = meme.memeImage

        return cell
    }

    // TODO: Detailed view
    // override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // }
}
