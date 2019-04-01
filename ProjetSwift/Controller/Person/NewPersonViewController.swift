//
//  NewPersonViewController.swift
//  ProjetSwift
//
//  Created by Thibaut ALLARD-SERRE on 29/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit

class NewPersonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func create(firstname: String, lastname: String, dateArrivee: Date){
        let newPerson = Person(context: CoreDataManager.context)
        newPerson.plastname = lastname
        newPerson.pfirstname = firstname
        newPerson.pdateDepart = dateArrivee
        newPerson.isHidden = false
        newPerson.voyage = CurrentVoyageSingleton.shared.voyage
        CurrentVoyageSingleton.shared.voyage?.addToNewRelationship(newPerson)
        CoreDataManager.save()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let personDetailsViewController = segue.destination as? PersonDetailsViewController {
            personDetailsViewController.source = self
        }
    }
    
}
