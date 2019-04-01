//
//  DepenseFetchViewController.swift
//  ProjetSwift
//
//  Created by Hugo LACOMBE on 01/04/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit
import CoreData

class DepenseFetchResultController: NSObject, NSFetchedResultsControllerDelegate {
    
    let tableView  : UITableView
    
    init(view : UITableView){//}, model : PersonSetViewModel){
        self.tableView  = view
        
        super.init()
        do{
            try self.depensesFetched.performFetch()
        }
        catch let error as NSError{
            fatalError(error.description)
        } }
    //-------------------------------------------------------------------------------------------------
    // MARK: - FetchResultController
    lazy var depensesFetched : NSFetchedResultsController<Depense> = {
        // prepare a request
        let request : NSFetchRequest<Depense> = Depense.fetchRequest()
        request.predicate = NSPredicate(format: "psourceActivity == %@", CurrentActivitySingleton.shared.voyage!)
        request.sortDescriptors =
            [NSSortDescriptor(key:#keyPath(Depense.pmontant),ascending:true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext:
            CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>){
        self.tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>){
        self.tableView.endUpdates()
        CoreDataManager.save()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at
        indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath{
                self.tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath{
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath{
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            } default:
            break
        } }

}
