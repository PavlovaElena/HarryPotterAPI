//
//  CharacterDetailsViewModel.swift
//  HarryPotterAPI
//
//  Created by Elena Pavlova on 30.08.2022.
//

import Foundation

protocol CharacterDetailsViewModelProtocol {
    var characterImage: String { get }
    var characterName: String { get }
    var houseName: String { get }
    var dateOfBirth: String { get }
    var actor: String { get }
    
    init (character: Character)
}

class CharacterDetailsViewModel: CharacterDetailsViewModelProtocol {
   
    var characterImage : String {
        character.image
    }
    
    var characterName: String {
        character.name
    }
    
    var dateOfBirth: String {
        character.dateOfBirth != ""
        ? "was born \(character.dateOfBirth)"
        : "Date of birth unknown"
    }
    
    var houseName: String {
        switch character.house {
        case "" where character.wizard == false: return "No wizard"
        case "" where character.wizard == true: return "Hogwarts house unknown"
        default: return character.house
        }
    }
    
    var actor: String {
        character.actor != ""
        ? "played by \(character.actor)"
        : "No information about the actor"
    }
    
    private let character: Character
    
    required init(character: Character) {
        self.character = character
    }
}
