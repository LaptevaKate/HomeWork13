//
//  MainViewController.swift
//  HomeWork13
//
//  Created by Екатерина Лаптева on 24.04.22.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    var imagesArray = ImageSavingSettings.getAllImages()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //MARK: - IBActions
    @IBAction func plusImageButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Gallery",
                                      style: .default,
                                      handler: { [weak self] _ in
            self?.openGallery()
        }))
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel))
        present(alert, animated: true)
    }
}
//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCell
        let image = imagesArray[indexPath.item]
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
extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            imagesArray += [pickedImage]
            ImageSavingSettings.add(pickedImage)
            collectionView.reloadData()
    }
        picker.dismiss(animated: true, completion: nil)
    }
}
private extension MainViewController {
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Warning", message: "No permission", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
