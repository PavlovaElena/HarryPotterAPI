//
//  CharacterCellViewModel.swift
//  HarryPotterAPI
//
//  Created by Elena Pavlova on 02.09.2022.
//

import Foundation

protocol CharacterCellViewModelProtocol {
    var characterImage: String { get }
    var characterName: String { get }
    var houseName: String { get }
    init(character: Character)
}

class CharacterCellViewModel: CharacterCellViewModelProtocol {
    var characterImage: String {
        character.image
    }
    
    var characterName: String {
        character.name
    }
    
    var houseName: String {
        character.house
    }
    
    private var character: Character
    
    required init(character: Character) {
        self.character = character
    }
}
