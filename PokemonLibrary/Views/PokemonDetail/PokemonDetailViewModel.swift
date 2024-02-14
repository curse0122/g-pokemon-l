//
//  PokemonDetailViewModel.swift
//  PokemonLibrary
//
//  Created by nier on 2024/2/12.
//

import Foundation
import Combine

class PokemonDetailViewModel: ObservableObject {
    
    private var _manager: PokemonDataManager?
    private var subs = Set<AnyCancellable>()
    
    var manager: PokemonDataManager {
        get { return _manager ?? PokemonDataManager() }
        set { _manager = newValue }
    }
    
    func getSpecies(pokemonID: Int) async -> PokemonSpecies? {
        var species: PokemonSpecies?
        
        do {
            let (data, _) = try await PokemonAPI.shared.species(id: pokemonID)
            species = try JSONDecoder().decode(PokemonSpecies.self, from: data)
        } catch {
            print(error)
        }
        
        return species
    }
    
    func getEvolutionChain(url chainURL: String) async -> String {
        var evolution = _manager?.evolutionChain[chainURL]
        
        guard evolution == nil,
              let url = URL(string: chainURL) else { return chainURL }
        
        do {
            let (data, _) = try await PokemonAPI.shared.data(url: url)
            let chain = try JSONDecoder().decode(PokemonEvolutionChain.self, from: data)
            
            evolution = parseEvolutionChain(root: chain.chain)
            
            var pokemonURLs: [String] = []
            
            evolution?.flatMap { $0 }
                .forEach {
                    if _manager?.getData(pokemonName: $0.name) == nil,
                       let url = $0.url,
                       !pokemonURLs.contains(url) {
                        pokemonURLs.append(url)
                    }
                }
            
            await getPokemons(pokemonURLs)
            
            _manager?.evolutionChain[chainURL] = evolution
        } catch {
            print(error)
        }
        
        return chainURL
    }
    
    func getPokemons(_ pokemonURLs: [String]) async {
        let urls = pokemonURLs
            .map { url in
                return url.replacingOccurrences(of: "pokemon-species", with: "pokemon")
            }
        
        do {
            let data = try await withThrowingTaskGroup(of: (Data, URLResponse).self) { group in
                urls.forEach {
                    guard let url = URL(string: $0) else { return }
                    group.addTask {
                        return try await PokemonAPI.shared.data(url: url)
                    }
                }
                
                let decoder = JSONDecoder()
                var results: [PokemonData] = []
                
                for try await (data, _) in group {
                    let pokemon = try decoder.decode(Pokemon.self, from: data)
                    let pokemonData = PokemonData(id: pokemon.id, pokemon: pokemon)
                    
                    results.append(pokemonData)
                }
                
                return results
            }
            
            await MainActor.run {
                _manager?.addNewPokemons(data)
            }
        } catch {
            print(error)
        }
    }
    
    func parseEvolutionChain(root: PokemonEvolution) -> [[PokemonEvolution.Species]] {
        var chain: [[PokemonEvolution.Species]] = []
        
        func findList(node: PokemonEvolution, currentChain: [PokemonEvolution.Species]) {
            var newChain = currentChain
            newChain.append(node.species)
            
            if node.evolvesTo.isEmpty {
                chain.append(newChain)
            } else {
                for child in node.evolvesTo {
                    findList(node: child, currentChain: newChain)
                }
            }
        }
        
        findList(node: root, currentChain: [])
        
        return chain
    }
}

