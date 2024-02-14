//
//  PokemonEvolution.swift
//  PokemonLibrary
//
//  Created by nier on 2024/2/12.
//

import Foundation

struct PokemonEvolution: Codable {
    
    typealias Species = PokemonLanguage
    
    var evolvesTo: [PokemonEvolution]
    var species: Species
    
    enum CodingKeys: String, CodingKey {
        case evolvesTo = "evolves_to"
        case species
    }
}

struct PokemonEvolutionChain: Codable {
    
    typealias Species = PokemonLanguage
    
    var chain: PokemonEvolution
}
