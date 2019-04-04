//
//  NewTripViewController.swift
//  ProjetSwift
//
//  Created by Thibaut ALLARD-SERRE on 26/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit

class NewTripViewController: UIViewController {
    
    var image : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view.
    }
    
    func create(name: String, dest: String, dateDebut: Date, dateFin: Date){
        let newVoyage = Voyage(context: CoreDataManager.context)
        newVoyage.pnom = name
        newVoyage.pdestination = dest
        newVoyage.dateArrivee = dateDebut
        newVoyage.dateDepart = dateFin
        if let img = image {
            let data = img.jpegData(compressionQuality: 0.1)
            newVoyage.pimg=data
        }
        CoreDataManager.save()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let tripViewController = segue.destination as? TripViewController {
            tripViewController.source = self
        }
    }
}
