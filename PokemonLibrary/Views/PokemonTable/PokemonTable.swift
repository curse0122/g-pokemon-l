//
//  PokemonTable.swift
//  PokemonLibrary
//
//  Created by nier on 2024/2/12.
//

import SwiftUI

struct PokemonTable: View {
    
    @EnvironmentObject var manager: PokemonDataManager
    @ObservedObject var viewModel = PokemonTableViewModel()
    
    var body: some View {
        VStack {
            NavigationStack {
                List {
                    ForEach(viewModel.displayPokemon, id: \.self) { index in
                        NavigationLink(
                            destination: {
                                PokemonDetailView(pokemonData: $manager.data[index])
                            },
                            label: {
                                PokemonTableItem(pokemonData: $manager.data[index])
                            }
                        )
                    }
                    
                    if !viewModel.showOwned && (viewModel.total < 0 || manager.data.count < viewModel.total) {
                        ProgressView()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .onAppear {
                                viewModel.listIsAtEnd = true
                            }
                            .onDisappear {
                                viewModel.listIsAtEnd = false
                            }
                    }
                }
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Toggle(isOn: $viewModel.showOwned.animation()) {
                            Image(systemName: "checkmark.circle")
                        }
                    }
                }
                .navigationTitle("Pokémon")
            }
        }
        .onAppear {
            viewModel.manager = manager
            viewModel.setup()
        }
    }
}

#Preview {
    PokemonTable()
}
