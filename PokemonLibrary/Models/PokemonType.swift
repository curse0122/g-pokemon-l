//
//  PokemonType.swift
//  PokemonLibrary
//
//  Created by nier on 2024/2/12.
//

import Foundation
import SwiftUI

struct PokemonType {
    
    var id: Int
    var name: String
    var color: String
}

extension PokemonType {
    
    static let normal = PokemonType(
        id: 1,
        name: "Normal",
        color: "#A8A77E"
    )
    
    static let fighting = PokemonType(
        id: 2,
        name: "Fighting",
        color: "#B13D31"
    )
    
    static let flying = PokemonType(
        id: 3,
        name: "Flying",
        color: "#A492E9"
    )
    
    static let poison = PokemonType(
        id: 4,
        name: "Poison",
        color: "#95469C"
    )
    
    static let ground = PokemonType(
        id: 5,
        name: "Ground",
        color: "#DBC175"
    )
    
    static let rock = PokemonType(
        id: 6,
        name: "Rock",
        color: "#B4A14B"
    )
    
    static let bug = PokemonType(
        id: 7,
        name: "Bug",
        color: "#AAB942"
    )
    
    static let ghost = PokemonType(
        id: 8,
        name: "Ghost",
        color: "#6C5994"
    )
    
    static let steel = PokemonType(
        id: 9,
        name: "Steel",
        color: "#B8B8CE"
    )
    
    static let fire = PokemonType(
        id: 10,
        name: "Fire",
        color: "#E28544"
    )
    
    static let water = PokemonType(
        id: 11,
        name: "Water",
        color: "#708FE9"
    )
    
    static let grass = PokemonType(
        id: 12,
        name: "Grass",
        color: "#8BC660"
    )
    
    static let electric = PokemonType(
        id: 13,
        name: "Electric",
        color: "#F0D153"
    )
    
    static let psychic = PokemonType(
        id: 14,
        name: "Psychic",
        color: "#E66388"
    )
    
    static let ice = PokemonType(
        id: 15,
        name: "Ice",
        color: "#A5D6D7"
    )
    
    static let dragon = PokemonType(
        id: 16,
        name: "Dragon",
        color: "#683BEE"
    )
    
    static let dark = PokemonType(
        id: 17,
        name: "Dark",
        color: "#6C594A"
    )
    
    static let fairy = PokemonType(
        id: 18,
        name: "Fairy",
        color: "#E29DAC"
    )
    
    static let unknown = PokemonType(
        id: 10001,
        name: "Unknown",
        color: "#749E90"
    )
    
    static let stellar = PokemonType(
        id: 10002,
        name: "Stellar",
        color: "#8DC5B3"
    )
}

