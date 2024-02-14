//
//  PokemonImage.swift
//  PokemonLibrary
//
//  Created by nier on 2024/2/12.
//

import SwiftUI

struct PokemonImage: View {
    
    let imageURL: URL
    
    var body: some View {
        AsyncImage(
            url: imageURL,
            content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            },
            placeholder: {
                ProgressView()
            })
    }
}

#Preview {
    PokemonImage(imageURL: .init(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")!)
}
