//
//  PersonDetailsViewController.swift
//  ProjetSwift
//
//  Created by Thibaut ALLARD-SERRE on 29/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit

class PersonDetailsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var dateArrivee: UIDatePicker!
    @IBOutlet weak var validerBtn: UIButton!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    var person : Person!
    var btnlabel: String?
    var titleLabel: String?
    
    var source: UIViewController?
    
    override func viewDidLoad() {
        self.person = CurrentPersonSingleton.shared.person

        if ((source as? EditPersonViewController) != nil) {
            self.validerBtn.setTitle("Modifier", for: .normal)
            if person.lastname != "" {
                self.lastname.text = person.lastname
            }
            self.firstname.text = person.firstname
            if let da = person.dateArrivee {
                self.dateArrivee.date = da
            }
            for act in (ActivityDAO.fetchAll() )! {
                if act.pvoyage == CurrentVoyageSingleton.shared.voyage {
                    for d in act.pdepenses?.array as! [Depense] {
                        if d.crediteur == person || d.debiteur == person {
                            //Verifie si la personne a des depenses associées a elle
                            self.deleteBtn.isEnabled = false
                            self.deleteBtn.setTitleColor(#colorLiteral(red: 1, green: 0.03390688225, blue: 0.03076805447, alpha: 0.3860860475), for: .normal)
                        }
                    }
                }
            }
        }
        else {
            self.deleteBtn.isHidden = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == firstname {
            if textField.text == "" {
                textField.backgroundColor = #colorLiteral(red: 0.9426003886, green: 0.1370869242, blue: 0.0439281667, alpha: 0.5125990317)
                textField.placeholder = textField.placeholder! + " - Champ requis"
            }
            else {
                textField.backgroundColor = #colorLiteral(red: 0.2599510105, green: 0.9793555699, blue: 0.0942075538, alpha: 0.5)
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let btn = sender as? UIButton
        if btn == self.validerBtn {
            if firstname.text != "" {
                return true
            }
            else {
                alert()
                return false
            }
        }
        else {
            return true
        }
    }
    
    func alert(){
        let alert = UIAlertController(title: "Personne invalide", message: "Veuillez remplir un prénom", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in return } ))
        self.present(alert, animated: false)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if ((sender as? UIButton) != nil) {
            let btn = (sender as? UIButton)
            if btn == self.deleteBtn{
                let dest = segue.destination as? PersonsViewController
                dest?.deletePerson(person: person)
            }
        }
        if let firstname = firstname.text {
            if let sourceController = source as? NewPersonViewController {
                let btn = (sender as? UIButton)
                if btn == self.validerBtn {
                    if let lastname = lastname.text {
                        sourceController.create(firstname: firstname, lastname: lastname, dateArrivee: self.dateArrivee.date)
                    }
                    else {
                        sourceController.create(firstname: firstname, lastname: "", dateArrivee: self.dateArrivee.date)
                    }
                }
            }
            if let sourceController = source as? EditPersonViewController {
                sourceController.edit(person: person, firstname: firstname, lastname: lastname.text ?? "", datedebut: dateArrivee.date)
            }
        }
        self.source = nil
    }
    

}
