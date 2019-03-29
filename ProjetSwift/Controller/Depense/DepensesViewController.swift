//
//  DepensesViewController.swift
//  ProjetSwift
//
//  Created by Thibaut ALLARD-SERRE on 29/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit

class DepensesViewController: UIViewController {

    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var table: UITableView!
    
    var currentVoyage: Voyage?
    //var tableController: DepensesTableController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentVoyage = CurrentVoyageSingleton.shared.voyage
        //self.tableController = DepensesTableController(tableView: table, current: currentVoyage!)
        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
