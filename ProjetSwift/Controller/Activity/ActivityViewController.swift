//
//  DepensesViewController.swift
//  ProjetSwift
//
//  Created by Thibaut ALLARD-SERRE on 29/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {

    
    @IBOutlet weak var nom: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var date: UILabel!
    
    var tableController: ActivityTableController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentVoyage = CurrentVoyageSingleton.shared.voyage
        self.nom.text = currentVoyage?.nom
        if let dateDebut = currentVoyage?.dateArrivee,let dateFin = currentVoyage?.dateDepart{
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            let dateDebutStr = formatter.string(from: dateDebut)
            let dateFinStr = formatter.string(from: dateFin)
            self.date.text = dateDebutStr + " - " + dateFinStr
        }
    }
    
    @IBAction func unwindfromActivityDetails(source: UIStoryboardSegue){
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.tableController?.activityViewModel.delegate = nil
        self.tableController = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableController = ActivityTableController(tableView: table)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditActivity" {
            if let btn = sender as? UIButton{
                if let contentView = btn.superview{
                    if let cell = contentView.superview as? ActivityCell {
                        CurrentActivitySingleton.shared.activity = tableController?.activityViewModel.get(activityAt: self.table.indexPath(for: cell)!.row)
                        
                    }
                }
            }
        }
        if segue.identifier == "ShowActivity" {
            if let cell = sender as? ActivityCell {
                CurrentActivitySingleton.shared.activity = tableController?.activityViewModel.get(activityAt: self.table.indexPath(for: cell)!.row)
            }
        }
    }
    @IBAction func deleteActivity(_ sender: Any) {
        if let btn = sender as? UIButton{
            if let contentView = btn.superview{
                if let cell = contentView.superview as? ActivityCell{
                    if let act = tableController?.activityViewModel.get(activityAt: self.table.indexPath(for: cell)!.row) {
                        for dep in act.pdepenses?.array as! [Depense] {
                            dep.crediteur = nil
                            dep.debiteur = nil
                        }
                        tableController?.activityViewModel.delete(activity: act)
                            tableController?.dataSetChanged()
                    }
                }
            }
        }
    }
    
    
}
