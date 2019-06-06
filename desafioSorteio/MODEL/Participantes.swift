//
//  Participantes.swift
//  desafioSorteio
//
//  Created by Rafael Ignacio da Silva Nicolau on 31/05/19.
//  Copyright © 2019 Rafael Ignacio da Silva Nicolau. All rights reserved.
//

import Foundation
import UIKit

class Participantes {
    private var nome = ""
    var all: [String] = []//["Rafael", "Thiago", "Gilson", "Victor", "Tomaz", "Alexandre"]
    
    
    func getNome() -> String {
        return self.nome
    }
    
    func setNome(nome: String) {
        self.nome = nome
    }
    
    func addGrupo(nome: String) {
        all.append(nome)
    }
    
    func printNomes(){
        for i in 0...all.count - 1{
            print(all[i])
        }
    }
    
    func shufler(){
        all.shuffle()
    }
    
    func removePart(nome: String){
        for i in 0...all.count - 1 {
            if nome == all[i]{
                all.remove(at: i)
            }
        }
    }

}


