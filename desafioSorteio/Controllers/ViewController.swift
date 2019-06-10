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
    @IBOutlet weak var btAddPart: UIButton!
    @IBOutlet weak var btStart: UIButton!
    @IBOutlet weak var lbSorteio: UILabel!
    
    
    var nomeSort = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btAddPart.isHidden = true
        btStart.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func btSort(_ sender: Any) {
    addNomeSort()
    }
    
    @IBAction func btAdd(_ sender: Any) {
        addPart()
    }
    
    @IBAction func btStart(_ sender: Any) {
        sorteados()
    }
    
    func addNomeSort(){
        if let sort = tfSorteio.text{
            if sort.isEmpty{
                alerta(title: "Atenção", message: "Não pode criar Sorteio sem nome")
                return
            }else if Jogadores.shared.listaSorteio.contains(where: {$0.description == sort}){
                alerta(title: "Atenção", message: "Já existe um Sorteio com esse nome.")
                return
            }else {
               Jogadores.shared.nomeSorteio = sort
                lbSorteio.text = Jogadores.shared.nomeSorteio
                btAddPart.isHidden = false
                tfSorteio.text = ""
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tfParticipantes.resignFirstResponder()
        addPart()
        tfParticipantes.resignFirstResponder()
        return true
    }
    
    func alerta(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default ))
        self.present(alert, animated: true, completion: nil)
    }
    
    func addPart(){
        if let part = tfParticipantes.text{
            if part.isEmpty == true {
                alerta(title: "Atenção", message: "Não pode incluir participante sem nome.")
                return
            }else if Jogadores.shared.participantes.contains (where: {$0.nome == part}){
                alerta(title: "Atenção", message: "Não pode repetir nome do Participante.")
            }else {
                Jogadores.shared.participantes.append(Pessoa(nome: part))
                btStart.isHidden = false
            }
            tbList.reloadData()
        }
        tfParticipantes.text = ""
    }
    
    func clear(){
        lbSorteio.text = ""
        tfSorteio.text = ""
        tfQuant.text = ""
        tfParticipantes.text = ""
        btAddPart.isHidden = true
        btStart.isHidden = true
        Jogadores.shared.participantes = []
        Jogadores.shared.winners = []
    }
   
    func sorteados(){
        if let qnt = tfQuant.text {
            if qnt.isEmpty == true {
                alerta(title: "Atenção", message: "Favor incluir pelo menos um Sorteado.")
                return
            } else if Jogadores.shared.participantes.count < Int(qnt) ?? 0{
                alerta(title: "Atenção", message: "A quantidade de sorteados não pode ser maior que os Participantes.")
                return
            }else {
                Jogadores.shared.drawn = Jogadores.shared.participantes.shuffled()
                for i in 0...Jogadores.shared.drawn.count - 1 {
                    if i < Int(qnt)! {
                       Jogadores.shared.winners.append(Jogadores.shared.drawn[i])
                    }
                }
            }
            Jogadores.shared.listWinners.append(Jogadores.shared.winners)
            alerta(title: "Ganhadores", message: "\(Jogadores.shared.toStringNomes())")
            Jogadores.shared.listaSorteio.append(Jogadores.shared.nomeSorteio)
            clear()
            tbList.reloadData()
            }
        }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Jogadores.shared.participantes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let part = Jogadores.shared.participantes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ParticipantesCellTableViewCell
        cell.lbNome.text = part.nome
        
        return cell
        
    }
 
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let part = Jogadores.shared.participantes[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            self.deleteAction(part: part.nome, indexpath: indexPath)
        }
        let editAction = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            self.editAction(part: part.nome, indexpath: indexPath)
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
                if Jogadores.shared.participantes.contains(where: {$0.nome == newName}){
                    let alert = UIAlertController(title: "Atenção", message: "Não pode repetir nome do Participante.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true, completion: nil)
                }
                Jogadores.shared.participantes[indexpath.row].nome = newName
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
            Jogadores.shared.participantes.remove(at: indexpath.row)
            self.tbList.deleteRows(at: [indexpath], with: .automatic)
        }
        let cancelAction = UIAlertAction(title: "Não", style: .default, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
}

