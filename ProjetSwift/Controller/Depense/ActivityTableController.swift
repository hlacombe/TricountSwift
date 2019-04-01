//
//  DepensesTableController.swift
//  ProjetSwift
//
//  Created by Thibaut ALLARD-SERRE on 29/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit
/*
class ActivityTableController: NSObject, UITableViewDataSource, ActivityViewModelDelegate {

    var tableView   : UITableView
    var activityViewModel : ActivityViewModel
    let fetchResultController : ActivityFetchResultController
    
    init(tableView: UITableView) {
        self.tableView        = tableView
        self.fetchResultController = ActivityFetchResultController(view : tableView)
        self.activityViewModel = ActivityViewModel(data: self.fetchResultController.tripsFetched)
        super.init()
        self.tableView.dataSource = self
        self.tripsViewModel.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityViewModel.count
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
    
    func ActivityDeleted(at indexPath: IndexPath) {
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    func ActivityUpdated(at indexPath: IndexPath) {
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    func ActivityAdded(at indexPath: IndexPath) {
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    

}

*/
