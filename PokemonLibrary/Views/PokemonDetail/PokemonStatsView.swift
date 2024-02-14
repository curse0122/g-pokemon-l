//
//  PokemonStatsView.swift
//  PokemonLibrary
//
//  Created by nier on 2024/2/12.
//

import SwiftUI

struct PokemonStatsView: View {
    
    var stats: [PokemonStat]
    
    var body: some View {
        VStack {
            let statInfo = self.info
            HStack {
                VStack {
                    Text("\(statInfo["hp"] ?? 0)")
                    Text("HP")
                }
                .frame(width: 100, height: 60)
                .background(Color(hex: "#FF5959"), in: RoundedRectangle(cornerRadius: 15))
                
                VStack {
                    Text("\(statInfo["attack"] ?? 0)")
                    Text("attack")
                }
                .frame(width: 100, height: 60)
                .background(Color(hex: "#F5AC78"), in: RoundedRectangle(cornerRadius: 15))
                
                VStack {
                    Text("\(statInfo["defense"] ?? 0)")
                    Text("defense")
                }
                .frame(width: 100, height: 60)
                .background(Color(hex: "#FAE078"), in: RoundedRectangle(cornerRadius: 15))
            }
            
            HStack {
                VStack {
                    Text("\(statInfo["special-attack"] ?? 0)")
                    Text("special-attack")
                }
                .frame(width: 100, height: 60)
                .background(Color(hex: "#9DB7F5"), in: RoundedRectangle(cornerRadius: 15))
                
                VStack {
                    Text("\(statInfo["special-defense"] ?? 0)")
                    Text("special-defense")
                }
                .frame(width: 100, height: 60)
                .background(Color(hex: "#A7DB8D"), in: RoundedRectangle(cornerRadius: 15))
                
                VStack {
                    Text("\(statInfo["speed"] ?? 0)")
                    Text("speed")
                }
                .frame(width: 100, height: 60)
                .background(Color(hex: "#FA92B2"), in: RoundedRectangle(cornerRadius: 15))
            }
        }
    }
    
    var info: [String: Int] {
        var res: [String: Int] = [:]
        
        stats.forEach {
            res[$0.stat.name] = $0.value
        }
        
        return res
    }
}

#Preview {
    PokemonStatsView(stats: [
        .init(value: 45, stat: .init(name: "hp")),
        .init(value: 49, stat: .init(name: "attack")),
        .init(value: 49, stat: .init(name: "defense")),
        .init(value: 65, stat: .init(name: "special-attack")),
        .init(value: 65, stat: .init(name: "special-defense")),
        .init(value: 65, stat: .init(name: "speed"))
    ])
}
