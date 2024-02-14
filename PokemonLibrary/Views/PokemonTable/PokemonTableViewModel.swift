//
//  PokemonTableViewModel.swift
//  PokemonLibrary
//
//  Created by nier on 2024/2/12.
//

import Foundation
import Combine

class PokemonTableViewModel: ObservableObject {
    
    @Published var total = -1
    @Published var listIsAtEnd = false
    @Published var displayPokemon: [Int] = []
    @Published var showOwned = false
    
    private var _manager: PokemonDataManager?
    private var subs = Set<AnyCancellable>()
    private var nextListURL = ""
    private var fetchPokemon = false
    
    var manager: PokemonDataManager {
        get { return _manager ?? PokemonDataManager() }
        set { _manager = newValue }
    }
    
    func setup() {
        $listIsAtEnd
            .sink { value in
                if value && !self.fetchPokemon {
                    Task {
                        await self.getList()
                    }
                }
            }
            .store(in: &subs)
        
        $showOwned
            .sink { show in
                self.displayPokemon = self._manager?.data.enumerated()
                    .filter { data in
                        if show {
                            return show == data.element.isOwned
                        } else {
                            return true
                        }
                    }.map(\.offset) ?? []
            }
            .store(in: &subs)
    }
    
    func getList() async {
        guard !fetchPokemon else { return }
        
        fetchPokemon = true
        
        do {
            let res: (Data, URLResponse)
            
            if let url = URL(string: nextListURL) {
                res = try await PokemonAPI.shared.data(url: url)
            } else {
                res = try await PokemonAPI.shared.list(limit: 50)
            }
            
            let list = try JSONDecoder().decode(PokemonList.self, from: res.0)
            nextListURL = list.next ?? ""
            
            let urls = list.results.map { return $0.url }
            await getPokemons(urls)
            
            await MainActor.run {
                total = max(total, list.count)
            }
        } catch {
            print(error)
        }
    }
    
    func getPokemons(_ urls: [String?]) async {
        do {
            let data = try await withThrowingTaskGroup(of: (Data, URLResponse).self) { group in
                urls.forEach {
                    guard let url = URL(string: $0 ?? "") else { return }
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
                fetchPokemon = false
                showOwned = showOwned
            }
        } catch {
            print(error)
        }
    }
}
