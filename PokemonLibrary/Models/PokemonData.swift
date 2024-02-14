//
//  PokemonData.swift
//  PokemonLibrary
//
//  Created by nier on 2024/2/12.
//

import Foundation

struct PokemonData: Identifiable {
    
    var id: Int
    var pokemon: Pokemon
    var species: PokemonSpecies?
    var isOwned: Bool = false
}
