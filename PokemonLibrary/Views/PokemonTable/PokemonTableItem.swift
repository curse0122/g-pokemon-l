//
//  PokemonTableItem.swift
//  PokemonLibrary
//
//  Created by nier on 2024/2/12.
//

import SwiftUI

struct PokemonTableItem: View {
    
    @Binding var pokemonData: PokemonData
    
    var body: some View {
        HStack {
            let pokemon = pokemonData.pokemon
            
            if let url = URL(string: pokemon.sprites.frontDefault ?? "") {
                PokemonImage(imageURL: url)
                    .frame(width: 60, height: 60)
            } else {
                ProgressView()
            }
            
            VStack(spacing: 5) {
                HStack {
                    Text(pokemon.species.name.capitalized)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    if pokemonData.isOwned {
                        Image(systemName: "checkmark.circle")
                    }
                    
                    Spacer()
                }
                
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
                        }
                    }
                    
                    Spacer()
                    
                    Text("No. \(pokemon.id)")
                        .font(.subheadline)
                }
            }
        }
    }
}

#Preview {
    PokemonTableItem(pokemonData: .constant(.init(
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
