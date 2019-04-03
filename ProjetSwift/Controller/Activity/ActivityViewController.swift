//
//  DepensesViewController.swift
//  ProjetSwift
//
//  Created by Thibaut ALLARD-SERRE on 29/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {

    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var table: UITableView!
    
    var tableController: ActivityTableController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindfromActivityDetails(source: UIStoryboardSegue){
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.tableController?.activityViewModel.delegate = nil
        self.tableController = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableController = ActivityTableController(tableView: table)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditActivity" {
            if let btn = sender as? UIButton{
                if let contentView = btn.superview{
                    if let cell = contentView.superview as? ActivityCell {
                        CurrentActivitySingleton.shared.activity = tableController?.activityViewModel.get(activityAt: self.table.indexPath(for: cell)!.row)
                        
                    }
                }
            }
        }
        
    }
}
