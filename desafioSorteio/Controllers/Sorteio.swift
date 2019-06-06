//
//  File.swift
//  desafioSorteio
//
//  Created by Rafael Ignacio da Silva Nicolau on 03/06/19.
//  Copyright © 2019 Rafael Ignacio da Silva Nicolau. All rights reserved.
//

import Foundation
import UIKit

class Sorteio {
    var nomeSorteio:[String] = []
    var list: [String] = []
    
    func addSorteio(nome: String) {
        self.nomeSorteio.append(nome)
    }
    
    func addShufflerListSort(nome: String) -> [String]{
        self.list.append(nome)
        self.list.shuffle()
        return list
    }
    
}
