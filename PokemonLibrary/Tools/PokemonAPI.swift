//
//  PokemonAPI.swift
//  PokemonLibrary
//
//  Created by nier on 2024/2/12.
//

import Foundation

class PokemonAPI {
    
    static let shared = PokemonAPI()
    
    func data(url: URL) async throws -> (Data, URLResponse) {
        let req = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        
        return try await URLSession.shared.data(for: req)
    }
    
    func list(limit: Int = 20, offset: Int = 0) async throws -> (Data, URLResponse) {
        let api = "https://pokeapi.co/api/v2/pokemon?offset=\(offset)&limit=\(limit)"
        let req = URLRequest(url: .init(string: api)!, cachePolicy: .returnCacheDataElseLoad)
        
        return try await URLSession.shared.data(for: req)
    }
    
    func pokemon(id: Int) async throws -> (Data, URLResponse) {
        let api = "https://pokeapi.co/api/v2/pokemon/\(id)/"
        let req = URLRequest(url: .init(string: api)!, cachePolicy: .returnCacheDataElseLoad)
        
        return try await URLSession.shared.data(for: req)
    }
    
    func species(id: Int) async throws -> (Data, URLResponse) {
        let api = "https://pokeapi.co/api/v2/pokemon-species/\(id)/"
        let req = URLRequest(url: .init(string: api)!, cachePolicy: .returnCacheDataElseLoad)
        
        return try await URLSession.shared.data(for: req)
    }
    
    func getPokemonType(_ type: String) -> PokemonType {
        switch type {
        case "normal":
            return .normal
        case "fighting":
            return .fighting
        case "flying":
            return .flying
        case "poison":
            return .poison
        case "ground":
            return .ground
        case "rock":
            return .rock
        case "bug":
            return .bug
        case "ghost":
            return .ghost
        case "steel":
            return .steel
        case "fire":
            return .fire
        case "water":
            return .water
        case "grass":
            return .grass
        case "electric":
            return .electric
        case "psychic":
            return .psychic
        case "ice":
            return .ice
        case "dragon":
            return .dragon
        case "dark":
            return .dark
        case "fairy":
            return .fairy
        case "stellar":
            return .stellar
        default:
            return .unknown
        }
    }
}
