//
//  AlbumsTableViewController.swift
//  iOS-Album
//
//  Created by FGT MAC on 3/23/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    //MARK: - Properties
    var albumController: AlbumController?

    override func viewDidLoad() {
        super.viewDidLoad()

        albumController?.getAlbums{_ in
            self.tableView.reloadData()
        }
       
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return albumController?.albums.count ?? 0
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath)

        if let data = albumController?.albums[indexPath.row]  {
            cell.textLabel?.text = data.name
            cell.detailTextLabel?.text = data.artist
        }
        
        
        
        return cell
    }
 


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailsSegue"{
            if let detailVC = segue.destination as? AlbumDetailTableTableViewController {
                
                //get index
                if let indexPath = tableView.indexPathForSelectedRow{
                    detailVC.albumController = albumController
                    detailVC.album = albumController?.albums[indexPath.row]
                }
            }
        }else if segue.identifier == "addSegue"{
            if let addVC = segue.destination as? AlbumDetailTableTableViewController {
                addVC.albumController = albumController
            }
        }
    }


}
