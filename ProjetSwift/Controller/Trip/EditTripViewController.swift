//
//  EditTripViewController.swift
//  ProjetSwift
//
//  Created by Thibaut ALLARD-SERRE on 26/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit

class EditTripViewController: UIViewController {

    var trip: Voyage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
        
    // MARK: - Navigation
    func edit(trip: Voyage, name: String, dest: String, dateDebut: Date, dateFin: Date){
        trip.pnom = name
        trip.pdestination = dest
        trip.dateArrivee = dateDebut
        trip.dateDepart = dateFin
        CoreDataManager.save()
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        if let tripViewController = segue.destination as? TripViewController {
            tripViewController.trip = trip
            tripViewController.labeltrip = "Votre voyage"
            tripViewController.buttonText = "Modifier"
            tripViewController.source = self
        }
    }
}
    



