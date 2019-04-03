//
//  PersonExpensesTableController.swift
//  ProjetSwift
//
//  Created by Thibaut on 03/04/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit

class PersonExpensesTableController: NSObject, UITableViewDataSource, PersonsViewModelDelegate {
    
    let tableView   : UITableView
    var personsViewModel : PersonExpenseViewModel
    let fetchResultController : PersonExpenseFetchResultController
    
    init(tableView: UITableView) {
        self.tableView        = tableView
        self.tableView.reloadData()
        self.fetchResultController = PersonExpenseFetchResultController(view : tableView)
        self.personsViewModel = PersonExpenseViewModel(data: self.fetchResultController.depensesFetched)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpensePersonCell") as! ExpensePersonCell
        if let dep = personsViewModel.get(depenseAt: indexPath.row){
                cell.LabelActivity.text = dep.activite?.nom
                cell.Montant.text = String(dep.montant)
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
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.top)
    }
    
    func personAdded(at indexPath: IndexPath) {
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.top)
    }
    
    func personHidden(at indexPath: IndexPath) {
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }

}
