//
//  Character.swift
//  HarryPotterAPI
//
//  Created by Елена Павлова on 22.04.2022.
//

import Foundation

struct Character: Decodable {
    let name: String
    let dateOfBirth: String
    let house: String
    let wizard: Bool
    let actor: String
    let image: String
}
