//
//  EditActivityViewController.swift
//  ProjetSwift
//
//  Created by Thibaut on 03/04/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit

class EditActivityViewController: UIViewController, UITextFieldDelegate {
    
    var image : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func edit(activity: Activity, nom: String, crediteur: Person, montantTotal : Double, map: Dictionary<Person, Double>){
        activity.nom = nom
        activity.montantTotal = montantTotal
        var tmpMap = map
        for depense in (activity.pdepenses?.array as! [Depense]) {
            depense.montant = map[depense.debiteur!]!
            tmpMap.removeValue(forKey: depense.debiteur!)
        }
        if tmpMap.count != 0 {
            for person in tmpMap.keys {
                let newDepense = Depense(context: CoreDataManager.context)
                newDepense.crediteur = crediteur
                newDepense.debiteur = person
                newDepense.montant = tmpMap[person]!
                newDepense.activite = activity
            }
        }
        if let img = image {
            let data = img.jpegData(compressionQuality: 0.1)
            activity.pimg=data
        }
        CoreDataManager.save()
        CurrentVoyageSingleton.shared.updateDebts()
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
        if let activityDetailViewController = segue.destination as? ActivityDetailViewController {
            activityDetailViewController.source = self
        }
    }
    

}
