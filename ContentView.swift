//
//  ContentView.swift
//  sensorDeTemperaturaIoT
//
//  Created by Turma02-19 on 07/11/25.
//

import SwiftUI

struct Data: Decodable, Hashable{
    let timestamp: String
    let umidade: String
}

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    @State var umidadeMaisRecente = Data(timestamp: "2025-11-07T18:25:47.318Z", umidade: "0.0")
    let formatter = ISO8601DateFormatter()
    
    
    //    func UmidadeMaisRecente()-> Data? {
    //
    //        return viewModel.dados.max {$0.timestamp < $1.timestamp}
    ////        return viewModel.dados.max(by: {
    ////            guard let d1 = formatter.date(from: $0.timestamp),
    ////                  let d2 = formatter.date(from: $1.timestamp)
    ////            else { return false }
    ////            return d1<d2
    ////        })
    //
    //    }
    
    var body: some View {
        
        ZStack{
            Image("fundo")
                .resizable()
                .frame(width: 400)
                .scaledToFit()
                .ignoresSafeArea()
                .background(.black)
                .blur(radius: 9)
            
            
            VStack(alignment:.center){
                
                
                HStack{
                    Image(systemName: "dehumidifier")
                    Text("Umidade \nmais recente")
                }.frame(width:260, height:130)
                    .font(.largeTitle)
                    .background()
                    .cornerRadius(15)
                
                Spacer()
                
                Text("\(umidadeMaisRecente.umidade) %")
                    .font(.title)
                    .frame(width:130, height:55)
                    .background()
                    .cornerRadius(20)
                
                Text("\(umidadeMaisRecente.timestamp)")
                    .frame(width:250, height:35)
                    .background()
                    .cornerRadius(15)
                
                Spacer()
                
            }
            
        }.onAppear(){
            Timer.scheduledTimer(withTimeInterval: 2, repeats: true){ _ in
                viewModel.fetch()
                umidadeMaisRecente = viewModel.dados.max {$0.timestamp < $1.timestamp} ?? Data(timestamp: "2025-11-07T18:25:47.318Z", umidade: "0.0")
            }
            
            
        }
    }
}

#Preview {
    ContentView()
}
