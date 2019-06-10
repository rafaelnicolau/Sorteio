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
        loadData()
    }
    
    func loadData(){
        tbHist.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return Jogadores.shared.listaSorteio.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Jogadores.shared.listaSorteio[section]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return Jogadores.shared.listWinners[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let listWinners = Jogadores.shared.listWinners[indexPath.section][indexPath.row].nome

            let cell = tableView.dequeueReusableCell(withIdentifier: "cell_hist") as! HistoryTableViewCell
            cell.lbNomeWinner.text = listWinners
            return cell
    }
}
