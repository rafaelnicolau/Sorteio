//
//  ganhadores.swift
//  desafioSorteio
//
//  Created by Rafael Ignacio da Silva Nicolau on 03/06/19.
//  Copyright © 2019 Rafael Ignacio da Silva Nicolau. All rights reserved.
//

import Foundation
import UIKit

class Ganhadores {
    
    var grupo: [String] = []
    
    func imprimirGanhadores() -> String{
        let ganhadores = grupo.joined(separator: ",")
        return ganhadores
    }
}
