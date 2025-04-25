//
//  SuperHeroDetail.swift
//  cursoSwift
//
//  Created by Fabian Armenta on 03/02/25.
//

import SwiftUI
import SDWebImageSwiftUI
import Charts

struct SuperHeroDetail: View {
    let id:String
    @State var superHero:ApiNetwork.SuperHeroCompleted? = nil
    @State var loading:Bool = true
    var body: some View {
        VStack{
            if loading{
                ProgressView().tint(.white)
            } else if let superHero = superHero{
                WebImage(url: URL(string: superHero.image.url))
                    .resizable()
                    .scaledToFill()
                    .frame(height: 250)
                //cortar forzado
                    .clipped()
                Text(superHero.name).bold().font(.title).foregroundColor(.white)
                ForEach(superHero.biography.aliases, id: \.self){ alias in
                    Text(alias).foregroundColor(.gray).italic()
                    
                }
                superheroStats(stats: superHero.powerstats)
                Spacer()
            }
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(.backgroundApp)
        //Hacer que aparezca inmediatamente
            .onAppear{
                Task{
                    do{
                       superHero = try await ApiNetwork().getHerobyId(id: id )
                    }
                    catch{
                        superHero = nil
                    }
                    loading = false
                }
            }
    }
}

struct superheroStats:View {
    let stats:ApiNetwork.Powerstats
    var body: some View {
        VStack{
            
            Chart{
                SectorMark(angle: .value("Count", Int(stats.combat) ?? 0),
                           //Grososr del circulo
                           innerRadius: .ratio(0.6),
                           //Separacion de los huecos
                           angularInset: 2
                ).cornerRadius(5)
                    .foregroundStyle(by: .value("Category", "Combat"))
                SectorMark(angle: .value("Count", Int(stats.durability) ?? 0),
                           innerRadius: .ratio(0.6),
                           angularInset: 2
                ).cornerRadius(5)
                    .foregroundStyle(by: .value("Category", "Durability"))
                SectorMark(angle: .value("Count", Int(stats.intelligence) ?? 0),
                           innerRadius: .ratio(0.6),
                           angularInset: 2
                ).cornerRadius(5)
                    .foregroundStyle(by: .value("Category", "Intelligence"))
                SectorMark(angle: .value("Count", Int(stats.power) ?? 0),
                           innerRadius: .ratio(0.6),
                           angularInset: 2
                ).cornerRadius(5)
                    .foregroundStyle(by: .value("Category", "Power"))
                SectorMark(angle: .value("Count", Int(stats.speed) ?? 0),
                           innerRadius: .ratio(0.6),
                           angularInset: 2
                ).cornerRadius(5)
                    .foregroundStyle(by: .value("Category", "Speed"))
                SectorMark(angle: .value("Count", Int(stats.strength) ?? 0),
                           innerRadius: .ratio(0.6),
                           angularInset: 2
                ).cornerRadius(5)
                    .foregroundStyle(by: .value("Category", "Strength"))
            }
            
        }.padding(16).frame(maxWidth:.infinity, maxHeight:350).background(.white)
            .cornerRadius(16)
            .padding(24)
        
    }
}

#Preview {
    SuperHeroDetail(id:"14")
}

//7:16
