//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Joseph Chamochumbi on 2023-01-14.
//

import Foundation
import UIKit

class MemeTableViewCell: UITableViewCell {
    @IBOutlet var memeImageView: UIImageView!

    @IBOutlet var memeLabel: UILabel!
}

class MemeTableViewController: UITableViewController {
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = MemeTableViewCell.SeparatorStyle.none
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> MemeTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell") as! MemeTableViewCell

        let meme = memes[indexPath.row]

        cell.memeLabel?.text = meme.topText + " " + meme.bottomText

        cell.memeImageView?.image = meme.memeImage

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailedViewController = storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController

        detailedViewController.meme = memes[indexPath.row]

        parent?.navigationController?.pushViewController(detailedViewController, animated: true)
    }
}
