//
//  IMCResult.swift
//  cursoSwift
//
//  Created by Fabian Armenta on 29/01/25.
//

import SwiftUI

struct IMCResult: View {
    let userWeight: Double
    let userHeight: Double
    var body: some View {
        VStack{
            Spacer()
            Text("Tu resultado").font(.title).bold().foregroundColor(.white)
            let result = calculateIMC(weight: userWeight, height: userHeight)
            InformationView(result: result)
        }.frame(maxWidth:.infinity, maxHeight:.infinity).background(.backgroundApp)
    }
}

func calculateIMC(weight: Double, height: Double) -> Double {
    return weight/((height / 100)*(height / 100))
}

struct InformationView:View {
    let result:Double
    var body: some View {
        
        let information = getImcResult(result: result)
        
        VStack{
            Spacer()
            Text(information.0).foregroundColor(information.2).font(.title).bold()
            Spacer()
            Text("\(result, specifier: "%.2f")").font(.system(size: 80)).bold().foregroundColor(.white)
            Spacer()
            Text(information.1).foregroundColor(.white).font(.title2).padding(.horizontal, 12)
            Spacer()
        }.frame(maxWidth:.infinity, maxHeight: .infinity).background(.backgroundComponent).cornerRadius(18)
            .padding(16)
    }
}

func getImcResult(result: Double) -> (String, String, Color) {
    let title:String
    let description:String
    let color:Color
    
    switch result {
    case 0.00...19.99:
        title="Peso Bajo"
        description="Estás por debajo del peso recomendado según el IMC"
        color=Color.yellow
    case 20.00...24.99:
        title="Peso Normal"
        description="Estás en el peso promedio según la IMC"
        color=Color.green
    case 25.00...29.99:
        title="Sobrepeso"
        description="Estás por encima del peso recomendado según el IMC"
        color=Color.orange
    case 30.00...100:
        title="Obesidad"
        description="Estás muy por encima del peso recomendado según el IMC"
        color=Color.red
    default:
        title="ERROR"
        description="Ha ocurrido un error"
        color=Color.gray
    }
    return(title, description, color)
}

#Preview {
    IMCResult(userWeight: 80, userHeight: 190)
}

//5:12 min
