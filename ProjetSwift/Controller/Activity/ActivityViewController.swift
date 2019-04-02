//
//  DepensesViewController.swift
//  ProjetSwift
//
//  Created by Thibaut ALLARD-SERRE on 29/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {

    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var table: UITableView!
    
    var currentVoyage: Voyage?
    var tableController: ActivityTableController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentVoyage = CurrentVoyageSingleton.shared.voyage
        self.tableController = ActivityTableController(tableView: table)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindfromActivityDetails(source: UIStoryboardSegue){
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
