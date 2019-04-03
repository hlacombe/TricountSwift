//
//  RemboursementTableController.swift
//  ProjetSwift
//
//  Created by Thibaut on 03/04/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit

class RemboursementTableController: NSObject, UITableViewDataSource, PersonsViewModelDelegate  {
    
    let tableView   : UITableView

    init(tableView: UITableView) {
        self.tableView        = tableView
        super.init()
        self.tableView.dataSource       = self
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let p = CurrentVoyageSingleton.shared.proposedDebts(person: CurrentPersonSingleton.shared.person!)
        print(p)
        return p.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "RemboursementCell") as! RemboursementCell
        let dep = CurrentVoyageSingleton.shared.proposedDebts(person: CurrentPersonSingleton.shared.person!)[indexPath.row]
        cell.personne.text = "Remboursement"
        cell.montant.text = String(dep.montant)
        return cell
    }
    
    func dataSetChanged() {
        tableView.reloadData()
    }
    
    func personDeleted(at indexPath: IndexPath) {
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    func personUpdated(at indexPath: IndexPath) {
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.top)
    }
    
    func personAdded(at indexPath: IndexPath) {
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.top)
    }
    
    func personHidden(at indexPath: IndexPath) {
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }

}
