//
//  PokemonDetailView.swift
//  PokemonLibrary
//
//  Created by nier on 2024/2/12.
//

import SwiftUI

struct PokemonDetailView: View {
    
    @EnvironmentObject var manager: PokemonDataManager
    @ObservedObject var viewModel = PokemonDetailViewModel()
    
    @Binding var data: PokemonData
    @State var evolutionChain: String = ""
    
    init(pokemonData data: Binding<PokemonData>) {
        _data = data
    }
    
    var body: some View {
        List {
            let pokemon = data.pokemon
            
            Section {
                Text("No. \(data.pokemon.id)")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                
                VStack {
                    if let url = URL(string: pokemon.sprites.frontDefault ?? ""),
                       let femaleURL = URL(string: pokemon.sprites.frontFemale ?? "") {
                        ScrollView(.horizontal) {
                            HStack {
                                VStack {
                                    Text("Male")
                                        .bold()
                                        .foregroundStyle(Color.blue)
                                    
                                    PokemonImage(imageURL: url)
                                        .frame(width: 300, height: 300)
                                }
                                
                                VStack {
                                    Text("Female")
                                        .bold()
                                        .foregroundStyle(Color.red)
                                    
                                    PokemonImage(imageURL: femaleURL)
                                        .frame(width: 300, height: 300)
                                }
                            }
                        }
                        .scrollTargetBehavior(.paging)
                    } else if let url = URL(string: pokemon.sprites.frontDefault ?? "") {
                        PokemonImage(imageURL: url)
                            .frame(width: 300, height: 300)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
                VStack {
                    if let species = data.species {
                        Text(species.getNameText())
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(species.getGenusText())
                    } else {
                        ProgressView()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                HStack {
                    ForEach(pokemon.types, id: \.slot) { type in
                        HStack(spacing: 5) {
                            let pokemonType = PokemonAPI.shared.getPokemonType(type.type.name)
                            
                            Image("\(pokemonType.name)_icon")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .aspectRatio(contentMode: .fit)
                                .padding(2.5)
                                .background(Color(hex: pokemonType.color))
                                .cornerRadius(10)
                            
                            let text = NSLocalizedString(pokemonType.name.lowercased(), comment: "")
                            Text(text)
                        }
                    }
                }
                
                PokemonStatsView(stats: pokemon.stats)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .alignmentGuide(.listRowSeparatorLeading, computeValue: { _ in -15 })
            
            if !evolutionChain.isEmpty {
                PokemonEvolutionView(chain: evolutionChain)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Toggle(isOn: $data.isOwned) {
                    Image(systemName: "checkmark.circle")
                }
            }
        }
        .onChange(of: data.isOwned) {
            manager.userChanagePokemonOwnedStatus(id: data.id)
        }
        .navigationTitle(data.pokemon.name.capitalized)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            viewModel.manager = manager
            
            if data.species == nil {
                let species = await viewModel.getSpecies(pokemonID: data.id)
                
                data.species = species
            }
            
            guard let evolutionURL = data.species?.evolution.url else { return }
            
            evolutionChain = await viewModel.getEvolutionChain(url: evolutionURL)
        }
    }
}

#Preview {
    PokemonDetailView(pokemonData: .constant(PokemonData(
        id: 1,
        pokemon: Pokemon(
            id: 1,
            name: "bulbasaur",
            species: .init(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon-species/1/"),
            sprites: .init(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"),
            types: [
                .init(slot: 1, type: .init(name: "grass")),
                .init(slot: 2, type: .init(name: "poison"))
            ],
            stats: [
                .init(value: 45, stat: .init(name: "hp")),
                .init(value: 49, stat: .init(name: "attack")),
                .init(value: 49, stat: .init(name: "defense")),
                .init(value: 65, stat: .init(name: "special-attack")),
                .init(value: 65, stat: .init(name: "special-defense")),
                .init(value: 65, stat: .init(name: "speed"))
            ]
        ),
        isOwned: true
    )))
}
