//
//  Historico.swift
//  desafioSorteio
//
//  Created by Rafael Ignacio da Silva Nicolau on 11/06/19.
//  Copyright © 2019 Rafael Ignacio da Silva Nicolau. All rights reserved.
//

import Foundation

class Historico {
    
    static var shared = Historico()
    
    var sorteio: Sorteio?
    var listaSorteios: [Sorteio] = []
}
