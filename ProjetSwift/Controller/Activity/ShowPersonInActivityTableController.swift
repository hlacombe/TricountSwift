//
//  ShowPersonInActivityTableControllerTableViewController.swift
//  ProjetSwift
//
//  Created by Thibaut on 03/04/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit

class ShowPersonInActivityTableController: NSObject, UITableViewDataSource, PersonsViewModelDelegate {

    var tableView   : UITableView
    var personsViewModel : PersonViewModel
    let fetchResultController : PersonFetchResultController
    
    init(tableView: UITableView) {
        self.tableView        = tableView
        self.fetchResultController = PersonFetchResultController(view : tableView)
        self.personsViewModel = PersonViewModel(data: self.fetchResultController.personsFetched)
        super.init()
        self.tableView.dataSource       = self
        self.personsViewModel.delegate    = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personsViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonActivityCell", for: indexPath) as! PersonActivityCell
        if let person = personsViewModel.get(personAt: indexPath.row){
            cell.nom.text = person.fullname
            if CurrentActivitySingleton.shared.activity != nil {
                if findDebt(person: person) != 0.0 {
                    cell.montant.text = String(findDebt(person: person)!)
                    cell.backgroundColor = #colorLiteral(red: 0.4204992656, green: 0.7878243822, blue: 0.9715430699, alpha: 1)
                }
            }
        }
        return cell
    }
    
    func findDebt(person: Person) -> Double? {
        var res = 0.0
        let act = CurrentActivitySingleton.shared.activity
        for dep in (act?.pdepenses?.array as? [Depense])! {
            if dep.debiteur == person{
                res = dep.montant
            }
        }
        return res
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
