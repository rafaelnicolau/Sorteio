//
//  HistoryViewController.swift
//  desafioSorteio
//
//  Created by Rafael Ignacio da Silva Nicolau on 03/06/19.
//  Copyright © 2019 Rafael Ignacio da Silva Nicolau. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
   
    @IBOutlet weak var tbHist: UITableView!
    @IBOutlet weak var msg: UILabel!
    
    
        override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tbHist.isScrollEnabled = false
        loadData()
    }
    
    func loadData(){
        tbHist.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return Historico.shared.listaSorteios.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Historico.shared.listaSorteios[section].nome
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Historico.shared.listaSorteios[section].ganhadores.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nameWinner = Historico.shared.listaSorteios[indexPath.section].ganhadores[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_hist") as! HistoryTableViewCell
        cell.lbNomeWinner.text = nameWinner.nome
        return cell
    }
    
    @IBAction func btLimpar(_ sender: Any) {
        Historico.shared = Historico()
        tbHist.reloadData()
    }
    
}
