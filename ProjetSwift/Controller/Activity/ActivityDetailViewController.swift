//
//  DepenseViewController.swift
//  ProjetSwift
//
//  Created by Thibaut ALLARD-SERRE on 29/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit

class ActivityDetailViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var intitule: UITextField!
    @IBOutlet weak var crediteur: UITextField!
    @IBOutlet weak var montant: UITextField!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var validerBtn: UIButton!
    
    var source : UIViewController?
    var viewModel: PersonViewModel?
    var tableController: PersonInActivityTableController?
    var picker = UIPickerView()
    
    //used to store the selected creditor for this expense
    var cred: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableController = PersonInActivityTableController(tableView: table)
        picker.delegate = self
        picker.dataSource = self
        crediteur.inputView = picker
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.tableController?.personsViewModel.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.tableController?.personsViewModel.get(personAt: row)?.fullname
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.crediteur.text = self.tableController?.personsViewModel.get(personAt: row)?.fullname
        self.cred = self.tableController?.personsViewModel.get(personAt: row)
        self.view.endEditing(false)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let btn = sender as? UIButton {
            if btn == self.validerBtn {
                if let sourceController = source as? NewActivityViewController{
                    var map: Dictionary<Person, Double> = Dictionary<Person, Double>()
                    let cells = self.table.visibleCells as? [PersonActivityCell]
                    for cell in cells!{
                        let indexPath = table.indexPath(for: cell)
                        map.updateValue(Double(cell.montant.text!) ?? 0.0, forKey: self.tableController!.personsViewModel.get(personAt: indexPath!.row)!)
                    }
                    sourceController.create(nom: self.intitule.text!, crediteur: self.cred! , montantTotal: Double(self.montant!.text!)!, map: map)
                }
            }
        }
        self.source = nil
    }
 

}
