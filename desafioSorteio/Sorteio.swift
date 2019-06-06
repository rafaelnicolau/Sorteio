//
//  Sorteio.swift
//  desafioSorteio
//
//  Created by Rafael Ignacio da Silva Nicolau on 31/05/19.
//  Copyright © 2019 Rafael Ignacio da Silva Nicolau. All rights reserved.
//

import Foundation
import UIKit

class Sorteio: UIViewController {
    
    func addSort() {
        if let sort = tfSorteio.text {
            if sorteio == [] {
                sorteio.append(sort)
            }else if sorteio.contains(where: {$0.description == sort}){
                let alert = UIAlertController(title: "Atenção", message: "Já foi realizado sorteio com esse nome.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
            }else {
                sorteio.append(sort)
            }
        }
    
}
