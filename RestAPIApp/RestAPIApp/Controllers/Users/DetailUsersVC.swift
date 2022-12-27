//
//  DetailUsersVC.swift
//  RestAPIApp
//
//  Created by comp on 27.12.22.
//

import UIKit

class DetailUserVC: UIViewController {
    
    var user: User?
    
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var username: UILabel!
    @IBOutlet private weak var email: UILabel!
    @IBOutlet private weak var phone: UILabel!
    @IBOutlet private weak var website: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    
    @IBAction func postsAction() {
        let storyboard = UIStoryboard(name: "PostFlow", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PostsTVC") as! PostsTVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func albomsAction() {
//        let storyboard = UIStoryboard(name: "AlbomsAndFotos", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "AlbomsTVC") as! AlbomsTVC
//        vc.user = user
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func todosAction() {
    }
    
    @IBAction func mapAction() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MapVC") as? MapVC else { return }
        vc.address = user?.address
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    private func setupUI() {
        name.text = user?.name
        username.text = user?.username
        email.text = user?.email
        phone.text = user?.phone
        website.text = user?.website
    }
}
