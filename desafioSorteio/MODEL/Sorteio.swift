//
//  Sorteio.swift
//  desafioSorteio
//
//  Created by Rafael Ignacio da Silva Nicolau on 11/06/19.
//  Copyright © 2019 Rafael Ignacio da Silva Nicolau. All rights reserved.
//

import Foundation

class Sorteio {
    
    var nome: String = ""
    var participantes = [Pessoa]()
    var ganhadores = [Pessoa]()
    
    
    func toStringGanhadores() -> String {
        let nomesGanhadores = ganhadores.map({$0.nome})
           nomesGanhadores.joined(separator: ", ")
        return "\(nomesGanhadores)"
    }
    
}
