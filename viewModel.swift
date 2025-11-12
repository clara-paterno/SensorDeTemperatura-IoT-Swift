//
//  viewModel.swift
//  sensorDeTemperaturaIoT
//
//  Created by Turma02-19 on 07/11/25.
//

import Foundation

class ViewModel: ObservableObject{
    
    @Published var dados: [Data] = []
    
    func fetch(){
        
        guard let url =  URL(string: "http://192.168.128.32:1880/leituraendpoint") else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){[weak self] data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do {
                let parsed = try JSONDecoder().decode([Data].self, from: data)
                
                DispatchQueue.main.async{
                    
                    self?.dados = parsed
                }
            }
            
            catch{
                print(error)
            }
            
        }
        
        task.resume()
    }
}
