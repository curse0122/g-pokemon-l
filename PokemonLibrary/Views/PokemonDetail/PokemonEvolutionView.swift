//
//  PokemonEvolutionView.swift
//  PokemonLibrary
//
//  Created by nier on 2024/2/12.
//

import SwiftUI

struct PokemonEvolutionView: View {
    
    @EnvironmentObject var manager: PokemonDataManager
    
    @State var pokemonIndex: [[Int]] = []
    
    var chain: String
    
    var body: some View {
        Section("evolution") {
            ForEach(pokemonIndex, id: \.self) { index in
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(index, id: \.self) { i in
                            NavigationLink(
                                destination: {
                                    PokemonDetailView(pokemonData: $manager.data[i])
                                }, label: {
                                    let pokemon = manager.data[i].pokemon
                                    
                                    VStack {
                                        if let url = URL(string: pokemon.sprites.frontDefault ?? "") {
                                            PokemonImage(imageURL: url)
                                                .frame(width: 60, height: 60)
                                        }
                                        
                                        Text(pokemon.species.name.capitalized)
                                    }
                                    .frame(width: 100)
                                }
                            )
                        }
                    }
                }
            }
        }
        .onAppear {
            var listIndex: [[Int]] = []
            
            if let evolutionChain = manager.evolutionChain[chain] {
                listIndex = evolutionChain.map {
                    $0.map { manager.pokemonNameMap[$0.name]! }
                }
            }
            
            self.pokemonIndex = listIndex
        }
    }
}

#Preview {
    PokemonEvolutionView(chain: "")
}
