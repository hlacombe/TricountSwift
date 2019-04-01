//
//  DepenseViewController.swift
//  ProjetSwift
//
//  Created by Hugo LACOMBE on 01/04/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit

class DepenseViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    
    var tableController: PersonTableController?
    var currentVoyage: Voyage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentVoyage = CurrentVoyageSingleton.shared.voyage
        self.tableController = PersonTableController(tableView: table, current: currentVoyage!)
    }
    
    @IBAction func unwindFromDetails(source: UIStoryboardSegue){
        tableController?.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
}
