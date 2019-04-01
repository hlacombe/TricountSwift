//
//  DepenseTableViewController.swift
//  ProjetSwift
//
//  Created by Hugo LACOMBE on 01/04/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit

class DepenseTableViewController: NSObject, UITableViewDataSource, DepenseViewModelDelegate {
    
    let currentVoyage: Voyage?
    var tableView   : UITableView
    var depenseViewModel : DepenseViewModel
    let fetchResultController : DepenseFetchResultController
    
    init(tableView: UITableView, current: Voyage) {
        self.currentVoyage = current
        self.tableView        = tableView
        self.fetchResultController = DepenseFetchResultController(view : tableView)
        self.depenseViewModel = DepenseViewModel(data: self.fetchResultController.depensesFetched)
        super.init()
        self.tableView.dataSource       = self
        self.depenseViewModel.delegate    = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return depenseViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DepenseCell", for: indexPath) as! DepenseCell
        return cell
    }
    
    func dataSetChanged() {
        tableView.reloadData()
    }
    
    func depenseDeleted(at indexPath: IndexPath) {
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    func depenseUpdated(at indexPath: IndexPath) {
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.top)
    }
    
    func depenseAdded(at indexPath: IndexPath) {
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.top)
    }

}
