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
        return p.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "RemboursementCell") as! RemboursementCell
        let dep = CurrentVoyageSingleton.shared.proposedDebts(person: CurrentPersonSingleton.shared.person!)[indexPath.row]
        cell.personne.text = dep.creditor.fullname
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
    
    func refund(index: Int){
        let dep = CurrentVoyageSingleton.shared.proposedDebts(person: CurrentPersonSingleton.shared.person!)[index]
        let creditor = dep.debitor
        let debitor = dep.creditor
        let montant = dep.montant
        
        let newActivity = Activity(context: CoreDataManager.context)
        newActivity.nom = "Remboursement de " + creditor.fullname + " à " + debitor.fullname
        newActivity.montantTotal = montant
        newActivity.pvoyage = CurrentVoyageSingleton.shared.voyage
        CurrentVoyageSingleton.shared.voyage?.addToActivites(newActivity)
        
        let newDepense = Depense(context: CoreDataManager.context)
        newDepense.crediteur = creditor
        newDepense.debiteur = debitor
        newDepense.montant = montant
        newDepense.activite = newActivity
        
        CoreDataManager.save()
        
        //maj solde des personnes
        
        let debts = CurrentVoyageSingleton.shared.currentDebts
        
        for p in debts.keys{
            p.solde = debts[p]!
            CoreDataManager.save()
        }
        
    }


}
