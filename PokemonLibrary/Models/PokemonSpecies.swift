//
//  PokemonSpecies.swift
//  PokemonLibrary
//
//  Created by nier on 2024/2/12.
//

import Foundation

struct PokemonSpecies: Codable {
    
    var evolution: Evolution
    var genera: [Genus]
    var id: Int
    var name: String
    var names: [Name]
    
    func getGenusText() -> String {
        let key: String
        var text = ""
        
        if Locale.current.identifier == "zh_TW" {
            key = "zh-Hant"
        } else {
            key = "en"
        }
        
        for genus in genera {
            if genus.language.name == key {
                text = genus.genus
                break
            }
        }
        
        return text
    }
    
    func getNameText() -> String {
        let key: String
        var text = ""
        
        if Locale.current.identifier == "zh_TW" {
            key = "zh-Hant"
        } else {
            key = "en"
        }
        
        for name in names {
            if name.language.name == key {
                text = name.name
                break
            }
        }
        
        return text
    }
    
    enum CodingKeys: String, CodingKey {
        case evolution = "evolution_chain"
        case genera
        case id
        case name
        case names
    }
    
    struct Evolution: Codable {
        var url: String
    }
    
    struct Genus: Codable {
        var genus: String
        var language: PokemonLanguage
    }
    
    struct Name: Codable {
        var name: String
        var language: PokemonLanguage
    }
}
