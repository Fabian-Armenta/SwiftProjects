//
//  MenuView.swift
//  cursoSwift
//
//  Created by Fabian Armenta on 28/01/25.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination:IMCView()){
                    Text("IMC CALCULATOR")
                }
                NavigationLink(destination:SuperHeroSearcher()){
                    Text("SuperHero Searcher")
                }
                NavigationLink(destination:FavPlaces()){
                    Text("Fav Places")
                }
            }
        }
    }
}

#Preview {
    MenuView()
}
