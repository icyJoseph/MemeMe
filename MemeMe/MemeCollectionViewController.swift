//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Joseph Chamochumbi on 2023-01-18.
//

import Foundation
import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
    @IBOutlet var memeImage: UIImageView!
}

class MemeCollectionViewController: UICollectionViewController {
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!

    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let space: CGFloat = 3.0
        let dimension = ((view.frame.size.width) - (2 * space)) / 3.0

        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        collectionView.reloadData()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // MARK: ensure the first row is filled

        return max(memes.count, 2)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> MemeCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemeCollectionCell", for: indexPath) as! MemeCollectionViewCell

        if memes.indices.contains(indexPath.row) {
            let meme = memes[indexPath.row]

            cell.memeImage?.image = meme.memeImage

            return cell
        }

        cell.memeImage?.image = UIImage()

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailedViewController = storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController

        if memes.indices.contains(indexPath.row) {
            detailedViewController.meme = memes[indexPath.row]

            parent?.navigationController?.pushViewController(detailedViewController, animated: true)
        }
    }
}
