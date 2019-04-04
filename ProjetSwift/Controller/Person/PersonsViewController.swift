//
//  PersonsViewController.swift
//  ProjetSwift
//
//  Created by Hugo LACOMBE on 26/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit

class PersonsViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var nomVoyage: UILabel!
    @IBOutlet weak var date: UILabel!
    
    var tableController: PersonTableController?
    var currentVoyage: Voyage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentVoyage = CurrentVoyageSingleton.shared.voyage
        self.nomVoyage.text = currentVoyage?.nom
        if let dateDebut = currentVoyage?.dateArrivee,let dateFin = currentVoyage?.dateDepart{
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            let dateDebutStr = formatter.string(from: dateDebut)
            let dateFinStr = formatter.string(from: dateFin)
            self.date.text = dateDebutStr + " - " + dateFinStr
        }
        let debts = CurrentVoyageSingleton.shared.currentDebts
        for p in debts.keys{
            p.solde = debts[p]!
        }
        CoreDataManager.save()
    }

    @IBAction func unwindFromPersonDetails(source: UIStoryboardSegue){
        tableController?.tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.tableController?.personsViewModel.delegate = nil
        self.tableController = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableController = PersonTableController(tableView: table, current: currentVoyage!)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditPerson"{
            if let btn = sender as? UIButton{
                if let contentView = btn.superview{
                    if let cell = contentView.superview as? PersonCell {
                        CurrentPersonSingleton.shared.person = tableController?.personsViewModel.get(personAt: self.table.indexPath(for: cell)!.row)
                    }
                }
            }
        }
        else {
            if segue.identifier == "ShowPerson" {
                if let cell = sender as? PersonCell {
                    CurrentPersonSingleton.shared.person = tableController?.personsViewModel.get(personAt: self.table.indexPath(for: cell)!.row)
                }
            }
        }
    }
    
    @IBAction func ChangeStatusPerson(_ sender: Any) {
        if let btn = sender as? UIButton{
            if let contentView = btn.superview{
                if (contentView.superview as? PersonCell) != nil {
                    if let cell = contentView.superview as? PersonCell {
                        if let person = tableController?.personsViewModel.get(personAt: self.table.indexPath(for: cell)!.row) {
                            if person.isHidden {
                                person.isHidden = false
                                person.pdateDepart = nil
                            }
                            else {
                                person.isHidden = true
                                let date = Date()
                                person.pdateDepart = date
                            }
                        }
                    }
                }
            }
        }
    }
    
    func deletePerson(person: Person){
        self.tableController = PersonTableController(tableView: table, current: currentVoyage!)
        tableController?.personsViewModel.delete(person: person)
        tableController?.dataSetChanged()
        self.tableController?.personsViewModel.delegate = nil
        self.tableController = nil
    }
}
