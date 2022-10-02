//
//  CharacterListViewModel.swift
//  HarryPotterAPI
//
//  Created by Elena Pavlova on 02.09.2022.
//

import Foundation

protocol CharacterListViewModelProtocol {
    func fetchCharacters(completion: @escaping() -> Void)
    func numberOfRows() -> Int
    func cellViewModel(at indexPath: IndexPath) -> CharacterCellViewModelProtocol
    func detailsViewModel(at indexPath: IndexPath) -> CharacterDetailsViewModelProtocol
}

class CharacterListViewModel: CharacterListViewModelProtocol {
    private var characters: [Character] = []
    
    func fetchCharacters(completion: @escaping () -> Void) {
        NetworkManager.shared.fetch(from: link) { [weak self] result in
            switch result {
            case .success(let characters):
                self?.characters = characters
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfRows() -> Int {
        characters.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CharacterCellViewModelProtocol {
        let character = characters[indexPath.row]
        return CharacterCellViewModel(character: character)
    }
    
    func detailsViewModel(at indexPath: IndexPath) -> CharacterDetailsViewModelProtocol {
        let character = characters[indexPath.row]
        return CharacterDetailsViewModel(character: character)
    }
}
