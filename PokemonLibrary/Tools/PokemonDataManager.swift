//
//  PokemonDataManager.swift
//  PokemonLibrary
//
//  Created by nier on 2024/2/12.
//

import Foundation
import Combine

class PokemonDataManager: ObservableObject {
    
    @Published var data: [PokemonData] = []
    @Published var ownedPokemon: [Int] = []

    private var subs = Set<AnyCancellable>()
    private var existsIDs: [Int] = []
    private var pokemonIDMap: [Int: Int] = [:]
    
    var pokemonNameMap: [String: Int] = [:]
    var evolutionChain: [String: [[PokemonEvolution.Species]]] = [:]
    
    init () {
        guard let owned = UserDefaults.standard.array(forKey: "owned") else { return }
        
        ownedPokemon = owned.compactMap { $0 as? Int }
    }
    
    func setup() {
        $data
            .sink { data in
                self.existsIDs = data.map(\.id)
                
                var pokemonIDMap: [Int: Int] = [:]
                var pokemonNameMap: [String: Int] = [:]
                
                data.enumerated().forEach {
                    pokemonIDMap[$0.element.id] = $0.offset
                    pokemonNameMap[$0.element.pokemon.species.name] = $0.offset
                }
                
                self.pokemonIDMap = pokemonIDMap
                self.pokemonNameMap = pokemonNameMap
            }
            .store(in: &subs)
        
        $ownedPokemon
            .sink { owned in
                UserDefaults.standard.setValue(owned, forKey: "owned")
                UserDefaults.standard.synchronize()
            }
            .store(in: &subs)
    }
    
    func addNewPokemons(_ pokemons: [PokemonData]) {
        var newData = data
        
        let newPokemons = pokemons.filter {
            return !existsIDs.contains($0.id)
        }.map {
            var data = $0
            
            if ownedPokemon.contains(data.id) {
                data.isOwned = true
            }
            
            return data
        }
        
        newData.append(contentsOf: newPokemons)
        
        data = newData.sorted { $0.id < $1.id }
    }
    
    func getDataIndex(pokemonID id: Int) -> Int? {
        return pokemonIDMap[id]
    }
    
    func getData(pokemonID id: Int) -> PokemonData? {
        guard let index = pokemonIDMap[id] else { return nil }
        return data[index]
    }
    
    func getData(pokemonName name: String) -> PokemonData? {
        guard let index = pokemonNameMap[name] else { return nil }
        return data[index]
    }
    
    func userChanagePokemonOwnedStatus(id: Int) {
        if let index = ownedPokemon.first(where: { $0 == id }) {
            ownedPokemon.remove(at: index)
        } else {
            ownedPokemon.append(id)
        }
    }
}
