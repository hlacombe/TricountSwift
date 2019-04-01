//
//  PersonDetailsViewController.swift
//  ProjetSwift
//
//  Created by Thibaut ALLARD-SERRE on 29/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit

class PersonDetailsViewController: UIViewController {

    @IBOutlet weak var transactionTab: UITableView!
    @IBOutlet weak var bilanLabel: UILabel!
    @IBOutlet weak var bilanTab: UITableView!
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var dateArrivee: UIDatePicker!
    @IBOutlet weak var titleTop: UILabel!
    @IBOutlet weak var validerBtn: UIButton!
    @IBOutlet weak var transactionLabel: UILabel!
    
    var person : Person!
    var btnlabel: String?
    var titleLabel: String?
    
    var source: UIViewController?
    
    override func viewDidLoad() {
        self.person = CurrentPersonSingleton.shared.person

        if ((source as? NewPersonViewController) != nil) {
            self.bilanTab.isHidden = true
            self.bilanLabel.isHidden = true
            self.transactionTab.isHidden = true
            self.transactionLabel.isHidden = true
        }
        if ((source as? EditPersonViewController) != nil) {
            self.titleTop.text = "Modification d'un voyageur"
            self.validerBtn.setTitle("Modifier", for: .normal)
            if person.lastname != "" {
                self.lastname.text = person.lastname
            }
            self.firstname.text = person.firstname
            if let da = person.dateArrivee {
                self.dateArrivee.date = da
            }
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let firstname = firstname.text {
            if let sourceController = source as? NewPersonViewController {
                if let lastname = lastname.text {
                    sourceController.create(firstname: firstname, lastname: lastname, dateArrivee: dateArrivee.date)
                }
                else {
                    sourceController.create(firstname: firstname, lastname: "", dateArrivee: dateArrivee.date)
                }
            }
        }
        self.source = nil
    }
    

}
