//
//  PhotoCollectionViewCell.swift
//  RestAPIApp
//
//  Created by comp on 4.01.23.
//

import UIKit
import Alamofire
import AlamofireImage

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var thumbnailUrl: String?{
    didSet {
            getThumbnail()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func getThumbnail() {
        guard let thumbnailUrl = thumbnailUrl else { return }
        if let image = CacheManager.shared.imageCache.image(withIdentifier: thumbnailUrl) {
            self.activityIndicator.stopAnimating()
            self.imageView.image = image
        } else {
            AF.request(thumbnailUrl).responseImage { [weak self] response in
            if case .success(let image) = response.result {
                print("image downloaded: \(image)")
                self?.activityIndicator.stopAnimating()
                self?.imageView.image = image
            }
        }
    }
}
}
