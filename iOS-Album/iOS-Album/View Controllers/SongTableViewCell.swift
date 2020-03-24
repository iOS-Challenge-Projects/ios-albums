//
//  SongTableViewCell.swift
//  iOS-Album
//
//  Created by FGT MAC on 3/23/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import UIKit



protocol SongTableViewCellDelegate: class {
    
    func addSong(with title: String, duration: String)
}


//MARK: - ViewCell

class SongTableViewCell: UITableViewCell {
    
    //MARK: - Oulets
    @IBOutlet weak var titleTexfField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    
    //MARK: - Properties
    var song: Song?
    
    weak var delegate: SongTableViewCellDelegate?
    
    func updateViews()  {
        if let song = song {
            titleTexfField.text = song.name
            durationTextField.text = song.duration
            addSongButton.isHidden = true
        }
    }
    
    override func prepareForReuse() {
        titleTexfField.text = ""
        durationTextField.text = ""
        addSongButton.isHidden = false
    }
    
    
    //MARK: - Actions
    @IBAction func AddSongButtonPressed(_ sender: UIButton) {
        
        
        if let duration = durationTextField.text, let title = titleTexfField.text {
             delegate?.addSong(with: title, duration: duration)
        }
       
    }
}
