//
//  NewDepenseViewController.swift
//  ProjetSwift
//
//  Created by Thibaut ALLARD-SERRE on 29/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit

class NewActivityViewController: UIViewController {

    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func create(nom: String, crediteur: Person, montantTotal : Double, map: Dictionary<Person, Double>){
        let newActivity = Activity(context: CoreDataManager.context)
        newActivity.nom = nom
        newActivity.montantTotal = montantTotal
        newActivity.pvoyage = CurrentVoyageSingleton.shared.voyage
        CurrentVoyageSingleton.shared.voyage?.addToActivites(newActivity)
        for person in map.keys {
            let newDepense = Depense(context: CoreDataManager.context)
            newDepense.crediteur = crediteur
            newDepense.debiteur = person
            newDepense.montant = map[person]!
            newDepense.activite = newActivity
        }
        if let img = image {
            let data = img.jpegData(compressionQuality: 0.1)
            newActivity.pimg=data
        }
        CurrentVoyageSingleton.shared.updateDebts()
        CoreDataManager.save()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let ActivityDetailViewController = segue.destination as? ActivityDetailViewController {
            ActivityDetailViewController.source = self
            CurrentActivitySingleton.shared.activity = nil
        }
    }
 

}
