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
    let tableView   : UITableView
    var personsViewModel : PersonViewModel
    let fetchResultController : PersonFetchResultController
    var checkedIndexPath:NSIndexPath?
    
    init(tableView: UITableView, current: Voyage) {
        self.currentVoyage = current
        self.tableView        = tableView
        self.tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell") as! PersonCell
        if let person = personsViewModel.get(personAt: indexPath.row){
            cell.Nom.text = person.fullname
            let solde = person.solde
            cell.bilan.text = solde.description + "€"
            if solde < 0 {
                cell.bilan.textColor = #colorLiteral(red: 1, green: 0.03390688225, blue: 0.03076805447, alpha: 1)
            }
            else {
                cell.bilan.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            }
            if person.isHidden {
                cell.Nom.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.400528169)
                cell.hidebtn.setImage(UIImage(named: "addbtn"), for: .normal)
            }
            else{
                cell.Nom.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                cell.hidebtn.setImage(UIImage(named: "hidebtn"), for: .normal)
            }
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
