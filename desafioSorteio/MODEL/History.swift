//
//  History.swift
//  desafioSorteio
//
//  Created by Rafael Ignacio da Silva Nicolau on 04/06/19.
//  Copyright © 2019 Rafael Ignacio da Silva Nicolau. All rights reserved.
//

import Foundation

class History {
    static let shared = History()
    
    var sorteios = Sorteio()
    var winners = Ganhadores()
    var participantes = Participantes()
    var sections: [String] = []
    var listWinners: [[String]] = []
   
}
