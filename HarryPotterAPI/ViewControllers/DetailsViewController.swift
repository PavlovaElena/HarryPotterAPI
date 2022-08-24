//
//  DetailsViewController.swift
//  HarryPotterAPI
//
//  Created by Елена Павлова on 22.04.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var imageView: CharacterImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var houseLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var actorLabel: UILabel!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var character: Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.topItem?.title = "\(character.name)"
        fillScreen()
    }

    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    private func fillScreen() {
        imageView.fetchImage(from: character.image)
        
        nameLabel.text = character.name
        
        dateOfBirthLabel.text = character.dateOfBirth != ""
        ? "was born \(character.dateOfBirth)"
        : "Date of birth unknown"
        
        switch character.house {
        case "" where character.wizard == false:
            houseLabel.text = "No wizard"
        case "" where character.wizard == true:
            houseLabel.text = "Hogwarts house unknown"
        default:
            houseLabel.text = "\(character.house)"
            houseLabel.textColor = setHouseColor(character.house)
        }
        
        actorLabel.text = character.actor != ""
        ? "played by \(character.actor)"
        : "No information about the actor"
    }
    
    private func setHouseColor (_ house: String) -> UIColor {
        switch house {
        case "Gryffindor":
            return .systemRed
        case "Hufflepuff":
            return .systemYellow
        case "Ravenclaw":
            return .systemBlue
        default:
            return .systemGreen
        }
    }
}
