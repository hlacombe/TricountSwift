//
//  TripViewController.swift
//  ProjetSwift
//
//  Created by Thibaut ALLARD-SERRE on 26/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import Foundation
import UIKit

class TripViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tripName: UITextField!
    @IBOutlet weak var tripDestination: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var dateDebut: UIDatePicker!
    @IBOutlet weak var dateFin: UIDatePicker!
    @IBOutlet weak var labelTrip: UILabel!
    @IBOutlet weak var validerButton: UIButton!
    
    var trip: Voyage?
    var labeltrip: String?
    var source: UIViewController?
    var buttonText: String?
    
    override func viewDidLoad() {
        if let tn = trip?.nom {
            tripName.text = tn
        }
        if let td = trip?.destination {
            tripDestination.text = td
        }
        if let dd = trip?.dateDepart {
            dateDebut.date = dd
        }
        if let df = trip?.dateArrivee {
            dateFin.date = df
        }
        if let lt = labeltrip {
            labelTrip.text = lt
        }
        if let bt = buttonText {
            validerButton.setTitle(bt, for: .normal)
        }
    }
    
    func alert(){
        let alert = UIAlertController(title: "Voyage invalide", message: "Votre voyage doit avoir un nom et une destination", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in return } ))
        self.present(alert, animated: false)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == tripName || textField == tripDestination {
            if textField.text == "" {
                textField.backgroundColor = #colorLiteral(red: 0.9426003886, green: 0.1370869242, blue: 0.0439281667, alpha: 0.7642220511)
                textField.placeholder = textField.placeholder! + " - Champ requis"
            }
            else {
                textField.backgroundColor = #colorLiteral(red: 0.2599510105, green: 0.9793555699, blue: 0.0942075538, alpha: 0.7642220511)
            }
        }
    }
   
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if tripName.text != "" && tripDestination.text != "" {
            return true
        }
        else {
            alert()
            return false
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let tripName = tripName.text, let dest = tripDestination.text {
            if let sourceController = source as? NewTripViewController {
                sourceController.create(name: tripName, dest: dest, dateDebut: dateDebut.date, dateFin: dateFin.date)
                
            }
            else if let editTripViewController = source as? EditTripViewController {
                if tripName != trip?.nom || dest != trip?.destination || dateFin.date != trip?.dateArrivee || dateDebut.date != trip?.dateDepart {
                    editTripViewController.edit(trip: trip!, name: tripName, dest: dest, dateDebut: dateDebut.date, dateFin: dateFin.date)
                }
            }
        }
        self.source = nil
    }
}
