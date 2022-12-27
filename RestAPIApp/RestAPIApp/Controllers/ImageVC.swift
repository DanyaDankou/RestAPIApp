//
//  ImageVC.swift
//  RestAPIApp
//
//  Created by comp on 27.12.22.
//

import UIKit

class ImageVC: UIViewController {
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
    }

    private let imageURLStr = "https://images.unsplash.com/photo-1584806728314-bf2de23844d1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80"

    private func fetchImage() {
        guard let url = URL(string: imageURLStr) else {
            return
        }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            DispatchQueue.main.async {
                
                self.activityIndicatorView.stopAnimating()
                
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                if let response = response { print(response) }
        
                print("\n", data ?? "", "\n")
                
                if let data = data, let image = UIImage(data: data)
                { self.image.image = image } else {
                }
                
            }
        }
        task.resume()
    }
}
