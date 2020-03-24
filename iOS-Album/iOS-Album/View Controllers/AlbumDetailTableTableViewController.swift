//
//  AlbumDetailTableTableViewController.swift
//  iOS-Album
//
//  Created by FGT MAC on 3/23/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import UIKit

class AlbumDetailTableTableViewController: UITableViewController {
    
    
    //MARK: - Oulets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var urlArtTextField: UITextField!
    
    //MARK: - Properties
    
    var albumController: AlbumController?
    
    var album: Album? {
        didSet{
            updateViews()
        }
    }
    
    var tempSongs: [Song] = []
    
    
//MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    //MARK: - Actions
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tempSongs.count + 1
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
    

        return cell
    }
 
    
    //MARK: - Methods
    
    func updateViews() {
        if let album = album {
            titleTextField.text = album.name
            artistTextField.text = album.artist
            
            genreTextField.text = album.genres.joined(separator: ",")
            
            var urlArtTextFieldString = ""
            for g in album.coverArt {
                urlArtTextFieldString = "\(g)"
            }
            
            urlArtTextField.text = urlArtTextFieldString
            
            navigationItem.title = album.name
            
            tempSongs = album.songs
        }
    }

}

extension AlbumDetailTableTableViewController: SongTableViewCellDelegate {
    func addSong(with title: String, duration: String) {
        let newSong = Song(duration: duration, name: title)
        
        tempSongs.append(newSong)
        
        tableView.reloadData()
    }
    
    
}
