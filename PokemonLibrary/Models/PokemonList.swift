//
//  PokemonList.swift
//  PokemonLibrary
//
//  Created by nier on 2024/2/12.
//

import Foundation

struct PokemonList: Codable {
    
    typealias Item = PokemonLanguage
    
    var count: Int
    var next: String?
    var results: [Item]
}
