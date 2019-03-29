//
//  ViewController.swift
//  ProjetSwift
//
//  Created by Thibaut ALLARD-SERRE on 22/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    
    var tableController: TripTableController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableController = TripTableController(tableView: table)

    }
    
    /*@IBAction func unwind(sender : UIStoryboardSegue){
    }*/

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditTrip" {
            if let dest = segue.destination as? EditTripViewController{
                if let btn = sender as? UIButton{
                    if let contentView = btn.superview{
                        if let cell = contentView.superview as? TripCell{
                            dest.trip = tableController.tripsViewModel.get(voyageAt: self.table.indexPath(for: cell)!.row)
                        }
                    }
                }
            }
        }
        if segue.identifier == "VoyageDetails" {
            if let cell = sender as? TripCell{
                if let trip = tableController.tripsViewModel.get(voyageAt: self.table.indexPath(for: cell)!.row){
                CurrentVoyageSingleton.shared.voyage = trip
                }
            }
        }
    }
    
    @IBAction func unwindfromTrip(source: UIStoryboardSegue){
    }

    
    @IBAction func deleteTrip(_ sender: Any) {
        if let btn = sender as? UIButton{
            if let contentView = btn.superview{
                if let cell = contentView.superview as? TripCell{
                    if let trip = tableController.tripsViewModel.get(voyageAt: self.table.indexPath(for: cell)!.row) {
                        tableController.tripsViewModel.delete(voyage: trip)
                        tableController.dataSetChanged()
                    }
                }
            }
        }
    }
}

