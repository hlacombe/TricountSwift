//
//  ShowPersonViewController.swift
//  ProjetSwift
//
//  Created by Thibaut on 02/04/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit

class ShowPersonViewController: UIViewController {

    @IBOutlet weak var tabBilan: UITableView!
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var tabTransactions: UITableView!
    @IBOutlet weak var dates: UILabel!
    
    var person: Person!
    var tableDepenseController: PersonExpensesTableController?
    var tableRemboursementController: RemboursementTableController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableDepenseController = PersonExpensesTableController(tableView: tabTransactions)
        self.tableRemboursementController = RemboursementTableController(tableView: tabBilan)
        self.person = CurrentPersonSingleton.shared.person
        // Do any additional setup after loading the view.
        self.fullname.text = person.fullname
        if let dateArrive = person.dateArrivee {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            let dateDebutStr = formatter.string(from: dateArrive)
            self.dates.text = dateDebutStr
        }
    }
}
