//
//  IMCView.swift
//  cursoSwift
//
//  Created by Fabian Armenta on 28/01/25.
//

import SwiftUI

struct IMCView: View {
    
    @State var gender:Int = 0
    @State var age:Int = 18
    @State var weight:Int = 80
    @State var height:Double = 150
    var body: some View {
        VStack{
            HStack{
                ToggleButton(text: "Hombre", imageName: "heart.fill", gender: 0, SelectedGender: $gender)
                ToggleButton(text: "Mujer", imageName: "star.fill", gender: 1, SelectedGender: $gender)
            }
            HeightCalculator(SelectedHeight: $height)
            HStack{
                CounterButton(title: "Edad", number: $age)
                CounterButton(title: "Peso", number: $weight)
            }
            IMCCalculatorButton(userWeight: Double(weight), userHeight:height)
                    
        }.frame(maxWidth:.infinity, maxHeight:.infinity)
            .background(.backgroundApp)
            .toolbar{
                ToolbarItem(placement:.principal){
                    Text("IMC Calculator").foregroundColor(.white)
                }
            }
    }
}

struct ToggleButton:View  {
    let text:String
    let imageName:String
    let gender:Int
    @Binding var SelectedGender:Int
    
    var body: some View{
        
        let color = if (gender == SelectedGender){
            Color.backgroundComponentSelected
        } else {
            Color.backgroundComponent
        }
        Button(action: {
            SelectedGender = gender
        }){
            VStack{
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .foregroundColor(.white)
                InformationText(text: text)
            }.frame(maxWidth: .infinity, maxHeight: .infinity).background(color)
        }
        }
    }

struct InformationText: View{
    let text:String
    var body: some View{
        Text(text).font(.largeTitle).bold().foregroundColor(.white)
    }
}

struct TitleText: View {
    let text:String
    var body: some View{
        Text(text).font(.title2).foregroundColor(.gray)
    }
}

struct HeightCalculator:View {
    @Binding var SelectedHeight:Double
    var body: some View {
        VStack{
            TitleText(text: "Altura")
            InformationText(text: "\(Int(SelectedHeight)) cm")
            Slider(value: $SelectedHeight, in: 110...220, step: 1).accentColor(.purple).padding(.horizontal,18)
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(.backgroundComponent)
    }
}

struct CounterButton:View {
    let title:String
    @Binding var number:Int
    var body: some View{
        VStack{
            TitleText(text: title)
            InformationText(text: String(number))
            HStack(){
                Button(action:{
                    if (number>0){
                        number-=1
                    }
                }){
                    ZStack{
                        Circle().frame(width: 70, height: 70)
                            .foregroundColor(.purple)
                        Image(systemName: "minus")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .frame(width:25, height: 25)
                    }
                }
                Button(action:{
                    if(number<100){
                        number+=1
                    }
                }){
                    ZStack{
                        Circle().frame(width: 70, height: 70)
                            .foregroundColor(.purple)
                        Image(systemName: "plus")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width:25, height: 25)
                    }
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.backgroundComponent)
    }
}

struct IMCCalculatorButton: View {
    let userWeight: Double
    let userHeight: Double
    var body: some View {
        NavigationStack{
            NavigationLink(destination:{IMCResult(userWeight:userWeight, userHeight: userHeight)}) {
                Text("Calcular").font(.title).bold().foregroundColor(.purple).frame(maxWidth: .infinity, maxHeight: 100)
                    .background(.backgroundComponent)
            }
        }
    }
}
#Preview {
    IMCView()
}


