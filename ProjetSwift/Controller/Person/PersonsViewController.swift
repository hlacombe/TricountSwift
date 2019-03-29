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
    
}
