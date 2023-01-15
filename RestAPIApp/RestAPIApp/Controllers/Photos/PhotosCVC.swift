//
//  PhotosCVC.swift
//  RestAPIApp
//
//  Created by comp on 4.01.23.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage

class PhotosCVC: UICollectionViewController {
    
    var user: User?
    var album: JSON?
    var photos: [JSON] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = album?["title"].string
        collectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let layout = UICollectionViewFlowLayout()
        let sizeWH = UIScreen.main.bounds.width / 2 - 5
        layout.itemSize = CGSize(width: sizeWH, height: sizeWH)
        collectionView.collectionViewLayout = layout
    }
    
    func getData() {
        guard let album = album,
              let albumID = album["id"].int else { return }
            NetworkService.getPhotos(albumID: albumID) { [weak self] response, error in
                guard let photos = response else { return }
                self?.photos = photos
                self?.collectionView.reloadData()
            }
        }
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        cell.thumbnailUrl = photos[indexPath.row]["thumbnailUrl"].string
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPhoto", sender: photos[indexPath.row])
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let photoVC = segue.destination as? PhotoVC,
           let photo = sender as? JSON {
            photoVC.photo = photo
        }
    }
}
