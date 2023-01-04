//
//  NetworkService.swift
//  RestAPIApp
//
//  Created by comp on 4.01.23.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class NetworkService {
    
    static func deletePost(postID: Int,
                           callback: @escaping (_ result: JSON?, _ error: Error?) -> Void) {
        let url = ApiConstants.postsPath + "/" + "\(postID)"
        
        AF.request(url, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .response { response in
                
                var jsonValue: JSON?
                var err: Error?
                
                switch response.result {
                    case .success(let data):
                        jsonValue = JSON(data)
                    case .failure(let error):
                        err = error
                }
                callback(jsonValue, err)
            }
    }
    
    static func getPhotos(albumID: Int,
                           callback: @escaping (_ result: [JSON]?, _ error: Error?) -> Void) {
        
        let url = ApiConstants.photosPath + "?" + "albumId=\(albumID)"
        
        AF.request(url).response { response in
                
                var jsonValue: [JSON]?
                var err: Error?
                
                switch response.result {
                    case .success(let data):
                        guard let data = data else { return }
                        jsonValue = JSON(data).arrayValue
                    case .failure(let error):
                        err = error
                }
                callback(jsonValue, err)
            }
    }
    
    static func getPhoto(imageURL: String,
                         callback: @escaping (_ result: UIImage?, _ error: AFError?) -> Void) {
        if let image = CacheManager.shared.imageCache.image(withIdentifier: imageURL) {
            callback(image, nil)
        } else {
            AF.request(imageURL).responseImage { response in
                if case .success(let image) = response.result {
                    CacheManager.shared.imageCache.add(image, withIdentifier: imageURL)
                    callback(image, nil)
                }
            }
        }
    }
}
