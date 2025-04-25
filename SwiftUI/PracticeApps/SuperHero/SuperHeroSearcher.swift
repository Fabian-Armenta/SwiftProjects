//
//  SuperHeroSearcher.swift
//  cursoSwift
//
//  Created by Fabian Armenta on 30/01/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct SuperHeroSearcher: View {
    @State var superHeroName: String = ""
    @State var wrapper:ApiNetwork.Wrapper? = nil
    @State var loading: Bool = false
    var body: some View {
        VStack{
            TextField("", text: $superHeroName, prompt: Text("Superman...").bold().font(.title2).foregroundColor(.gray))
                .bold()
                .font(.title2)
                .foregroundColor(.white)
                .padding(16)
                .border(.purple, width: 1.5)
                .padding(8)
                .autocorrectionDisabled()
                .onSubmit {
                    loading = true
                    print(superHeroName)
                    Task{
                        do{
                            wrapper = try await ApiNetwork().getHeroesbyQuery(query: superHeroName)
                        }
                        catch{
                            print("ERROR")
                        }
                        loading = false
                    }
                    
                    
                }
            if loading{
                //animacion de loading de carga
                ProgressView().tint(.white)
            }
            NavigationStack{
                List(wrapper?.results ?? []){superHero in
                    ZStack{
                        superheroItem(superhero:superHero)
                        //Hacerlo transparante para al dar click navegar
                        NavigationLink(destination: SuperHeroDetail(id:superHero.id)){EmptyView()}.opacity(0)
                    }.listRowBackground(Color.backgroundApp)
                    
                }.listStyle(.plain)
            }
            Spacer()
        }.frame(maxWidth:.infinity, maxHeight: .infinity).background(.backgroundApp)
    }
}
struct superheroItem:View {
    let superhero:ApiNetwork.SuperHeroe
    var body: some View {
        ZStack{
            WebImage(url:URL(string: superhero.image.url))
                .resizable()
            //indicar que se esta cargando la imagen
                .indicator(.activity)
                .scaledToFill()
                .frame(height: 200)
            VStack{
                Spacer()
                Text(superhero.name).foregroundColor(.white).font(.title)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.white.opacity(0.5))
            }
        }.frame(height:200).cornerRadius(32)
    }
}
#Preview {
    SuperHeroSearcher()
}

//6:29    
