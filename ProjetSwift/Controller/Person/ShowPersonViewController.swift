//
//  ShowPersonViewController.swift
//  ProjetSwift
//
//  Created by Thibaut on 02/04/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit

class ShowPersonViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tabBilan: UITableView!
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var tabTransactions: UITableView!
    @IBOutlet weak var dates: UILabel!
    
    var person: Person!
    var tableDepenseController: PersonExpensesTableController?
    var tableRemboursementController: RemboursementTableController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableRemboursementController = RemboursementTableController(tableView: tabBilan)
        self.person = CurrentPersonSingleton.shared.person
        // Do any additional setup after loading the view.
        self.fullname.text = person.fullname
        var dateDebutStr: String
        if let dateArrive = person.dateArrivee {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            dateDebutStr = formatter.string(from: dateArrive)
            self.dates.text = dateDebutStr
            if let dateDepart = person.pdateDepart{
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                let dateDebutStr2 = formatter.string(from: dateDepart)
                self.dates.text = dateDebutStr + " - " + dateDebutStr2
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func Refund(_ sender: Any) {
        if let btn = sender as? UIButton{
            if let contentView = btn.superview{
                if let cell = contentView.superview as? RemboursementCell {
                    self.tableRemboursementController!.refund(index: self.tabBilan.indexPath(for: cell)!.row)
                }
                self.tabBilan.reloadData()
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.tableDepenseController?.personsViewModel.delegate = nil
        self.tableDepenseController = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
         self.tableDepenseController = PersonExpensesTableController(tableView: tabTransactions)
    }
    
    
}
