//
//  EditPersonViewController.swift
//  ProjetSwift
//
//  Created by Thibaut ALLARD-SERRE on 29/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit

class EditPersonViewController: UIViewController {

    var trip: Voyage!
    var person: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func edit(person: Person, firstname: String, lastname: String, datedebut: Date){
        person.pfirstname=firstname
        if lastname != "" {
            person.plastname=lastname
        }
        person.pdateArrivee=datedebut
        CoreDataManager.save()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let personDetailsViewController = segue.destination as? PersonDetailsViewController {
            personDetailsViewController.source = self
            personDetailsViewController.person = person
        }
    }
    

}
