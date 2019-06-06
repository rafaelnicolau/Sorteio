//
//  ViewController.swift
//  desafioSorteio
//
//  Created by Rafael Ignacio da Silva Nicolau on 30/05/19.
//  Copyright © 2019 Rafael Ignacio da Silva Nicolau. All rights reserved.
//

import UIKit
import Foundation


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
  
    @IBOutlet weak var tfSorteio: UITextField!
    @IBOutlet weak var tfParticipantes: UITextField!
    @IBOutlet weak var tfQuant: UITextField!
    @IBOutlet weak var tbList: UITableView!
    
    var sorteio = History.shared.sorteios.list
    var listaSorteados = History.shared.winners.drawn
    var ganhadores = History.shared.winners.list
    var participantes = History.shared.participantes.all
    var nomeSort = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfQuant.delegate = self
        tfParticipantes.delegate = self
        tfQuant.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
   
    @IBAction func btAdd(_ sender: Any) {
        addPart()
    }
    
    @IBAction func btStart(_ sender: Any) {
        sorteados()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tfParticipantes.resignFirstResponder()
        addPart()
        tfParticipantes.resignFirstResponder()
        return true
    }
    
    func compararValoresLabel() -> Bool {
        if let quant = tfQuant.text {
            if quant == "0" || quant == "" {
                return false
            }
        }
        return true
    }
    
    func verificarCampos() -> Bool {
        if let sort = tfSorteio.text, let qnt = tfQuant.text{
            if sort.isEmpty == true || qnt.isEmpty == true {
                return false
            }
        }
          return true
    }
    
    func addSort() -> Bool {
        if let sort = tfSorteio.text, let quant = tfQuant.text{
            if  sort.isEmpty == true && quant.isEmpty == true {
                let alert = UIAlertController(title: "Atenção", message: "Não pode incluir Sorteio sem nome.", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "OK", style: .default ))
                self.present(alert, animated: true, completion: nil)
                return false
            }
            if sort.isEmpty == false && compararValoresLabel() == false{
                let alert = UIAlertController(title: "Atenção", message: "Favor incluir pelo menos um Sorteado.", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "OK", style: .default ))
                self.present(alert, animated: true, completion: nil)
                print(History.shared.participantes.all)
                return false
            }
            if History.shared.sorteios.nomeSorteio == [] {
                History.shared.sorteios.addSorteio(nome: sort)
                History.shared.sections.append(sort)
            }else if History.shared.sorteios.nomeSorteio.contains(where: {$0.description == sort}){
                let alert = UIAlertController(title: "Atenção", message: "Já foi realizado sorteio com esse nome.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
                return false
            }else {
                History.shared.sorteios.addSorteio(nome: sort)
                History.shared.sections.append(sort)
            }
              nomeSort = sort
        }
        return true
    }
    
    func addPart(){
        if let part = tfParticipantes.text{
            if part == "" || part.isEmpty == true {
                let alert = UIAlertController(title: "Atenção", message: "Não pode incluir participante sem nome.", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "OK", style: .default ))
                self.present(alert, animated: true, completion: nil)
                return
            }else if History.shared.participantes.all.contains(where: {$0.description == part}){
                let alert = UIAlertController(title: "Atenção", message: "Não pode repetir nome do Participante.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
            }else {
            History.shared.participantes.addGrupo(nome: part)
            }
            tbList.reloadData()
        }
        clearPart()
    }
    
    func clearPart(){
        tfParticipantes.text = ""
    }
    
    func clearSort(){
        tfSorteio.text = ""
    }
    
    func clearQtSort(){
        tfQuant.text = ""
    }
   
    func sorteados(){
         if addSort() == true && compararValoresLabel() == true {
        if let qnt = tfQuant.text {
            if qnt == "" || qnt == "0" {
                let alert = UIAlertController(title: "Atenção", message: "Favor incluir pelo menos um Sorteado.", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "OK", style: .default ))
                self.present(alert, animated: true, completion: nil)
                return
            } else if History.shared.participantes.all.count < Int(qnt) ?? 0{
                let alert = UIAlertController(title: "Atenção", message: "A quantidade de sorteados não pode ser maior que os Participantes.", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "OK", style: .default ))
                self.present(alert, animated: true, completion: nil)
                return
            }else {
                History.shared.winners.drawn = History.shared.participantes.all.shuffled()
                for i in 0...History.shared.winners.drawn.count - 1 {
                    if i < Int(qnt)! {
                        History.shared.winners.list.append(History.shared.winners.drawn[i])
                    }
                }
                History.shared.listWinners.append(History.shared.winners.list)
                let alert = UIAlertController(title: "Sorteio: \(nomeSort)", message: "\(History.shared.winners.imprimirGanhadores())", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "OK", style: .default ))
                self.present(alert, animated: true, completion: nil)
                History.shared.winners.clearGrupo()
            }
            clearQtSort()
            History.shared.participantes.all = []
            clearSort()
            tbList.reloadData()
            }
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return History.shared.participantes.all.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let part = History.shared.participantes.all[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ParticipantesCellTableViewCell
        cell.lbNome.text = part
        
        return cell
        
    }
 
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let part = History.shared.participantes.all[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            self.deleteAction(part: part, indexpath: indexPath)
        }
        let editAction = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            self.editAction(part: part, indexpath: indexPath)
        }
        
        editAction.backgroundColor = .gray
        deleteAction.backgroundColor = .red
        return [editAction, deleteAction]
    }
    
    func editAction(part: String, indexpath: IndexPath){
        let alert = UIAlertController(title: "Editar", message: "Deseja alterar o nome do participante?", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Alterar", style: .default) { (action) in
            guard let textField = alert.textFields?.first else {
                return
            }
            if let newName = textField.text{
                if newName.count == 0 {
                    return
                }
                if History.shared.participantes.all.contains(where: {$0.description == newName}){
                    let alert = UIAlertController(title: "Atenção", message: "Não pode repetir nome do Participante.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true, completion: nil)
                }
            History.shared.participantes.all[indexpath.row] = newName
            self.tbList.reloadData()
            } else {
                return
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        alert.addTextField()
        guard let textField = alert.textFields?.first else{
            return
        }
        textField.placeholder = "Novo Participante"
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    
    
    
    func deleteAction(part: String, indexpath: IndexPath){
        let alert = UIAlertController(title: "Delete", message: "Deseja apagar este participante?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Sim", style: .default) { (Action) in
            History.shared.participantes.all.remove(at: indexpath.row)
            self.tbList.deleteRows(at: [indexpath], with: .automatic)
        }
        let cancelAction = UIAlertAction(title: "Não", style: .default, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
}

