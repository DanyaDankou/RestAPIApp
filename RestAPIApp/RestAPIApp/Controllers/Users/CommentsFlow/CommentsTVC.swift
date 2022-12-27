//
//  CommentsTVC.swift
//  RestAPIApp
//
//  Created by comp on 27.12.22.
//

import UIKit

class CommentsTVC: UITableViewController {
    
    var posts: Post?
    var comments: [Comment] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        comments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comments = comments[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = comments.name
        cell.detailTextLabel?.text = comments.body
        return cell
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
     func fetchPosts() {
              guard let postId = posts?.id else { return }
              let pathUrl = "\(ApiConstants.commentsPath)?postId=\(postId)"

              guard let url = URL(string: pathUrl) else { return }

              let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
                  guard let data = data else { return }
                  do {
                      self.comments = try JSONDecoder().decode([Comment].self, from: data)
                      print(self.comments)
                  } catch let error {
                      print(error)
                  }
                  DispatchQueue.main.async {
                      self.tableView.reloadData()
                  }
              }
              task.resume()
          }

}
