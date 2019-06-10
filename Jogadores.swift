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
    var listWinners: [[Pessoa]] = []
    var nomeSorteio = ""
    var listaSorteio: [String] = []
    
//    func imprimirGanhadores() -> String{
//        let ganhadores = winners.joined(separator: ", ")
//        return ganhadores
//    }
    
    
    
//    func getWinners(name: [Pessoa]) -> String {
//        for i in 0...name.count - 1 {
//
//        }
//        return name.nome
//    }
    
    func toStringNomes() -> String {
        let nomesWinners = Jogadores.shared.winners.map({$0.nome})
        let x = nomesWinners.joined(separator: ", ")
        return x
        }
    
    func clearGrupo(){
        winners = []
    }
}
