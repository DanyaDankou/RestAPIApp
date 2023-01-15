//
//  PhotoVC.swift
//  RestAPIApp
//
//  Created by comp on 4.01.23.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage

final class PhotoVC: UIViewController {

    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var imageView: UIImageView!
    
    var photo: JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = photo?["title"].string
        getPhoto()
    }
    private func getPhoto() {
        guard let photo = photo,
              let imageURL = photo["url"].string else { return }
        NetworkService.getPhoto(imageURL: imageURL) { [weak self]  image, error in
            self?.activityIndicatorView.stopAnimating()
            self?.imageView.image = image
        }
    }
}

