//
//  Ganhadores.swift
//  desafioSorteio
//
//  Created by Rafael Ignacio da Silva Nicolau on 03/06/19.
//  Copyright © 2019 Rafael Ignacio da Silva Nicolau. All rights reserved.
//

import Foundation
import UIKit

class Jogadores: Pessoa {
    
    var participantes: [String] = []
    var winners: [String] = []
    var drawn: [String] = []
    
    func imprimirGanhadores() -> String{
        let ganhadores = winners.joined(separator: ", ")
        return ganhadores
    }
    
    func addGrupo(nome: String) {
        participantes.append(nome)
    }
    
    func clearGrupo(){
        winners = []
    }
}
