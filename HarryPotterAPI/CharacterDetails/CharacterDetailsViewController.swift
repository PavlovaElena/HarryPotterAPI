//
//  CharacterDetailsViewController.swift
//  HarryPotterAPI
//
//  Created by Елена Павлова on 22.04.2022.
//

import UIKit

class CharacterDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: CharacterImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var houseLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var actorLabel: UILabel!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var character: Character!
    var viewModel: CharacterDetailsViewModelProtocol! {
        didSet {
            nameLabel.text = viewModel.characterName
            dateOfBirthLabel.text = viewModel.dateOfBirth
            houseLabel.text = viewModel.houseName
            actorLabel.text = viewModel.actor
            imageView.fetchImage(from: viewModel.characterImage)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CharacterDetailsViewModel(character: character)
        
        navigationBar.topItem?.title = "\(character.name)"
        houseLabel.textColor = setHouseColor(viewModel.houseName)
    }

    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    private func setHouseColor (_ house: String) -> UIColor {
        switch house {
        case "Gryffindor":
            return .systemRed
        case "Hufflepuff":
            return .systemYellow
        case "Ravenclaw":
            return .systemBlue
        case "Slytherin":
            return .systemGreen
        default:
            return .black
        }
    }
}
