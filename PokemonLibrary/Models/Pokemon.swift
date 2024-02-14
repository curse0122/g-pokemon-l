//
//  Pokemon.swift
//  PokemonLibrary
//
//  Created by nier on 2024/2/12.
//

import Foundation

struct Pokemon: Codable {
    
    typealias Species = PokemonLanguage
    
    var id: Int
    var name: String
    var species: Species
    var sprites: Sprite
    var types: [Types]
    var stats: [PokemonStat]
    
    struct Sprite: Codable {
        var frontDefault: String? = nil
        var frontFemale: String? = nil
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
            case frontFemale = "front_female"
        }
    }
    
    struct Types: Codable {
        let slot: Int
        let type: PokemonLanguage
    }
}

