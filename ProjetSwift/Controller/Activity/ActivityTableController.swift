//
//  DepensesTableController.swift
//  ProjetSwift
//
//  Created by Thibaut ALLARD-SERRE on 29/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit

class ActivityTableController: NSObject, UITableViewDataSource, ActivityViewModelDelegate {

    var tableView   : UITableView
    var activityViewModel : ActivityViewModel
    let fetchResultController : ActivityFetchResultController
    
    init(tableView: UITableView) {
        self.tableView        = tableView
        self.fetchResultController = ActivityFetchResultController(view : tableView)
        self.activityViewModel = ActivityViewModel(data: self.fetchResultController.activitiesFetched)
        super.init()
        self.tableView.dataSource = self
        self.activityViewModel.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityCell
        let activity = self.activityViewModel.get(activityAt: indexPath.row)
        cell.intitule.text = activity!.nom
        cell.montant.text = String(activity!.montantTotal)
        return cell
    }
    
    func dataSetChanged() {
        tableView.reloadData()
    }
        func activityDeleted(at indexPath: IndexPath) {
            self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
        }
    
        func activityUpdated(at indexPath: IndexPath) {
            self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
        }
    
        func activityAdded(at indexPath: IndexPath) {
            self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
        }
    
    

}

