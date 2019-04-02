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
        self.tableController = PersonTableController(tableView: table, current: currentVoyage!)
        self.nomVoyage.text = currentVoyage?.nom
        if let dateDebut = currentVoyage?.dateArrivee,let dateFin = currentVoyage?.dateDepart{
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            let dateDebutStr = formatter.string(from: dateDebut)
            let dateFinStr = formatter.string(from: dateFin)
            self.date.text = dateDebutStr + " - " + dateFinStr
        }
    }

    @IBAction func unwindFromDetails(source: UIStoryboardSegue){
        tableController?.tableView.reloadData()
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
        if segue.identifier == "ShowPerson" {
            if let cell = sender as? PersonCell {
                CurrentPersonSingleton.shared.person = tableController?.personsViewModel.get(personAt: self.table.indexPath(for: cell)!.row)
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
                            }
                            else {
                                person.isHidden = true
                            }
                            tableController?.dataSetChanged()
                        }
                    }
                }
            }
        }
    }
    
    func deletePerson(person: Person){
        tableController?.personsViewModel.delete(person: person)
        tableController?.dataSetChanged()
    }
}
