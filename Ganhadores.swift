//
//  Ganhadores.swift
//  desafioSorteio
//
//  Created by Rafael Ignacio da Silva Nicolau on 03/06/19.
//  Copyright © 2019 Rafael Ignacio da Silva Nicolau. All rights reserved.
//

import Foundation
import UIKit

class Ganhadores {
    
    var participants: [String] = []
    var list: [String] = []
    var drawn: [String] = []
    
    func imprimirGanhadores() -> String{
        let ganhadores = list.joined(separator: ", ")
        return ganhadores
    }
    
    func addGrupo(nome: String) {
        participants.append(nome)
    }
    
    func clearGrupo(){
        list = []
    }
    
    func getWinner() -> [String] {
        return self.list
    }
}
