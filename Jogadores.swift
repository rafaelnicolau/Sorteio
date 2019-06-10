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
    
    static var shared = Jogadores()

    
    var participantes: [Pessoa] = []
    var winners: [Pessoa] = []
    var drawn: [Pessoa] = []
    var nomeSorteio = ""
    var listaSorteio: [String] = []
    
//    func imprimirGanhadores() -> String{
//        let ganhadores = winners.joined(separator: ", ")
//        return ganhadores
//    }
    
    func clearGrupo(){
        winners = []
    }
}
