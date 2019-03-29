//
//  TripTableController.swift
//  ProjetSwift
//
//  Created by Hugo LACOMBE on 26/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit

class TripTableController: NSObject,UITableViewDataSource, TripViewModelDelegate {
    
    var tableView   : UITableView
    var tripsViewModel : TripViewModel
    let fetchResultController : TripFetchResultController
    
    init(tableView: UITableView) {
        self.tableView        = tableView
        self.fetchResultController = TripFetchResultController(view : tableView)
        self.tripsViewModel = TripViewModel(data: self.fetchResultController.tripsFetched)
        super.init()
        self.tableView.dataSource = self
        self.tripsViewModel.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripsViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripCell", for: indexPath) as! TripCell
        if let trip = tripsViewModel.get(voyageAt: indexPath.row){
            cell.nom.text = trip.nom
            cell.destination.text = trip.destination
            if let dateDebut = trip.dateArrivee,let dateFin = trip.dateDepart{
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                let dateDebutStr = formatter.string(from: dateDebut)
                let dateFinStr = formatter.string(from: dateFin)
                cell.dates.text = dateDebutStr + " - " + dateFinStr
            }
        }
        return cell
    }
    
    func dataSetChanged() {
        tableView.reloadData()
    }
    
    func tripDeleted(at indexPath: IndexPath) {
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    func tripUpdated(at indexPath: IndexPath) {
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    func tripAdded(at indexPath: IndexPath) {
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
}
