//
//  CharacterTableViewCell.swift
//  HarryPotterAPI
//
//  Created by Elena Pavlova on 24.08.2022.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: CharacterImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var houseLabel: UILabel!
    
    func configure(with character: Character) {
        
        photoImageView.fetchImage(from: character.image)
        nameLabel.text = character.name
        houseLabel.text = character.house
    }
}
