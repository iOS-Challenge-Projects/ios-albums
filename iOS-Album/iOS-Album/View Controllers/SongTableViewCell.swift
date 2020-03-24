//
//  SongTableViewCell.swift
//  iOS-Album
//
//  Created by FGT MAC on 3/23/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    
    //MARK: - Oulets
    @IBOutlet weak var titleTexfField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Actions
    @IBAction func AddSongButtonPressed(_ sender: UIButton) {
    }
    

}
