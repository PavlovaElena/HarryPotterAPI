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
    
    var viewModel: CharacterCellViewModelProtocol! {
        didSet {
            photoImageView.fetchImage(from: viewModel.characterImage)
            nameLabel.text = viewModel.characterName
            houseLabel.text = viewModel.houseName
        }
    }
}
