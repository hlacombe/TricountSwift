//
//  PersonTableController.swift
//  ProjetSwift
//
//  Created by Hugo LACOMBE on 26/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit
import Foundation

class PersonTableController: NSObject, UITableViewDataSource, PersonsViewModelDelegate {
    
    let currentVoyage: Voyage?
    var tableView   : UITableView
    var personsViewModel : PersonViewModel
    let fetchResultController : PersonFetchResultController
    
    init(tableView: UITableView, current: Voyage) {
        self.currentVoyage = current
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as! PersonCell
        if let person = personsViewModel.get(personAt: indexPath.row){
            if let l : String = person.lastname {
                cell.Nom.text = person.firstname + " " + l
            } else {
                cell.Nom.text = person.firstname

            }
            cell.bilan.text = person.solde.description
        }
        return cell
    }
    
    func dataSetChanged() {
        tableView.reloadData()
    }
    
    func personDeleted(at indexPath: IndexPath) {
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    func personUpdated(at indexPath: IndexPath) {
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    func personAdded(at indexPath: IndexPath) {
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
}
