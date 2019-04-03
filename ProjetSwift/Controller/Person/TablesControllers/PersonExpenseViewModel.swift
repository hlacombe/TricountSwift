//
//  PersonExpenseViewModel.swift
//  ProjetSwift
//
//  Created by Thibaut on 03/04/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit
import CoreData

class PersonExpenseViewModel: NSObject {

    var delegate : PersonsViewModelDelegate? = nil
    var depensesFetched : NSFetchedResultsController<Depense>
    
    init(data: NSFetchedResultsController<Depense>){
        self.depensesFetched = data
    }
    //-------------------------------------------------------------------------------------------------
    // MARK: View Model functions
    /// add a new person in set of persons
    ///
    /// - Parameter person: Person to be added
    public func add(depense: Depense){
        if let indexPath = self.depensesFetched.indexPath(forObject: depense){
            self.delegate?.personAdded(at: indexPath)
        } }
    
    public var count : Int {
        return self.depensesFetched.fetchedObjects?.count ?? 0
    }
    
    
    public func delete(depense: Depense){
        if let indexPath = self.depensesFetched.indexPath(forObject: depense){
            DepenseDAO.delete(depense: depense)
            self.delegate?.personDeleted(at: indexPath)
        }
    }
    
    
    public func get(depenseAt index: Int) -> Depense?{
        return self.depensesFetched.object(at: IndexPath(row: index, section: 0))
    }
    
}
