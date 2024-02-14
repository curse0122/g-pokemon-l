//
//  PokemonStat.swift
//  PokemonLibrary
//
//  Created by nier on 2024/2/12.
//

import Foundation

struct PokemonStat: Codable {
    
    typealias Stat = PokemonLanguage
    
    var value: Int
    var stat: Stat
    
    enum CodingKeys: String, CodingKey {
        case value = "base_stat"
        case stat
    }
}
