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
    
    
    var sorteio = Sorteio()
    var players = Jogadores()
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
            }else {
                sorteio.nomeSorteio = sort
                lbSorteio.text = sort
                btAddPart.isHidden = false
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
            }else if players.participantes.contains(where: {$0.description == part}){
                alerta(title: "Atenção", message: "Não pode repetir nome do Participante.")
            }else {
                players.participantes.append(part)
                btStart.isHidden = false
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
    
    func clear(){
        tfSorteio.text = ""
        tfQuant.text = ""
        tfParticipantes.text = ""
        btAddPart.isHidden = true
        btStart.isHidden = true
        players.participantes = []
    }
   
    func sorteados(){
        if let qnt = tfQuant.text {
            if qnt.isEmpty == true {
                alerta(title: "Atenção", message: "Favor incluir pelo menos um Sorteado.")
                return
            } else if players.participantes.count < Int(qnt) ?? 0{
                alerta(title: "Atenção", message: "A quantidade de sorteados não pode ser maior que os Participantes.")
                return
            }else {
                players.drawn = players.participantes.shuffled()
                for i in 0...players.drawn.count - 1 {
                    if i < Int(qnt)! {
                       players.winners.append(players.drawn[i])
                    }
                }
            }
            alerta(title: "Ganhadores", message: "\(players.imprimirGanhadores())")
            clear()
            tbList.reloadData()
            }
        }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.participantes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let part = players.participantes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ParticipantesCellTableViewCell
        cell.lbNome.text = part
        
        return cell
        
    }
 
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let part = players.participantes[indexPath.row]
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
                if self.players.participantes.contains(where: {$0.description == newName}){
                    let alert = UIAlertController(title: "Atenção", message: "Não pode repetir nome do Participante.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true, completion: nil)
                }
            self.players.participantes[indexpath.row] = newName
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
            self.players.participantes.remove(at: indexpath.row)
            self.tbList.deleteRows(at: [indexpath], with: .automatic)
        }
        let cancelAction = UIAlertAction(title: "Não", style: .default, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "HistoryViewController") {
            let vc = segue.destination as! HistoryViewController
        }
    }
}

