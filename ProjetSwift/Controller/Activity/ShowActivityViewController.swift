//
//  ShowActivityViewController.swift
//  ProjetSwift
//
//  Created by Thibaut on 03/04/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit

class ShowActivityViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var intitule: UILabel!
    @IBOutlet weak var crediteur: UILabel!
    @IBOutlet weak var montantTotal: UILabel!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var image: UIImageView!
    
    var tableController: ShowPersonInActivityTableController?

    override func viewDidLoad() {
        super.viewDidLoad()
        let act = CurrentActivitySingleton.shared.activity
        self.crediteur.text = "Payée par " +  ((act!.pdepenses!.firstObject as? Depense)?.crediteur?.fullname)!
        if let img = act?.pimg{
            image.image = UIImage.init(data: img)
        }
        self.montantTotal.text = "Montant total " + String(act!.montantTotal) + "€"
        self.tableController = ShowPersonInActivityTableController(tableView: table)
        self.intitule.text = act?.nom
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
