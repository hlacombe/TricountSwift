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
    var tableController: PersonInActivityTableController?
    var picker = UIPickerView()
    
    //used to store the selected creditor for this expense
    var cred: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        crediteur.inputView = picker
        crediteur.isExclusiveTouch = true
        if (source as? EditActivityViewController) != nil {
            let act = CurrentActivitySingleton.shared.activity
            self.validerBtn.setTitle("Modifier", for: .normal)
            self.intitule.text = act!.nom
            self.montant.text = String(act!.montantTotal)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.tableController?.personsViewModel.delegate = nil
        self.tableController = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableController = PersonInActivityTableController(tableView: table)
        for n in 0...self.tableController!.personsViewModel.count-1 {
            if self.tableController?.personsViewModel.get(personAt: n) == (CurrentActivitySingleton.shared.activity?.pdepenses?.array.first as? Depense)?.crediteur {
                self.picker.selectRow(n, inComponent: 0, animated: true)
                self.cred = self.tableController?.personsViewModel.get(personAt: n)
                self.crediteur.text = cred?.fullname
            }
        }
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
                if let sourceController = source as? EditActivityViewController {
                    var map: Dictionary<Person, Double> = Dictionary<Person, Double>()
                    let cells = self.table.visibleCells as? [PersonActivityCell]
                    for cell in cells!{
                        let indexPath = table.indexPath(for: cell)
                        map.updateValue(Double(cell.montant.text!) ?? 0.0, forKey: self.tableController!.personsViewModel.get(personAt: indexPath!.row)!)
                    }
                    sourceController.edit(activity: CurrentActivitySingleton.shared.activity!, nom: self.intitule.text!, crediteur: self.cred!, montantTotal: Double(self.montant!.text!)!, map: map)
                }
            }
        }
        self.source = nil
    }
 

}
