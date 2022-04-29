//
//  MainViewController.swift
//  HomeWork13
//
//  Created by Екатерина Лаптева on 24.04.22.
//

import UIKit
import Alamofire
import Kingfisher


class MainViewController: UIViewController {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    let images = ["picture1", "picture2", "picture4", "picture5", "picture6", "picture7", "picture8", "picture9", "picture10"]
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCell
        let imageName = images[indexPath.item]
        let image = UIImage(named: imageName)
        cell.dishImageView.image = image
        return cell
    }
}
//MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let rowItem: CGFloat = 3
        let addindSpace = 20 * (rowItem + 1)
        let possibleWidth = collectionView.frame.width - addindSpace
        let size = possibleWidth / rowItem
        return CGSize(width: size, height: size)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let sectionsInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return sectionsInserts
    }
}
