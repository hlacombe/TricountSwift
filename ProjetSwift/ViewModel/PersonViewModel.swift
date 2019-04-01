//
//  PersonViewModel.swift
//  ProjetSwift
//
//  Created by Hugo LACOMBE on 26/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit
import CoreData

protocol PersonsViewModelDelegate {
    
    func dataSetChanged()
    
    func personDeleted(at indexPath: IndexPath)
    
    func personUpdated(at indexPath: IndexPath)
    
    func personAdded(at indexPath: IndexPath)
}

class PersonViewModel: NSObject {
    
    var delegate : PersonsViewModelDelegate? = nil
    var personsFetched : NSFetchedResultsController<Person>
    
    init(data: NSFetchedResultsController<Person>){
        self.personsFetched = data
    }
    //-------------------------------------------------------------------------------------------------
    // MARK: View Model functions
    /// add a new person in set of persons
    ///
    /// - Parameter person: Person to be added
    public func add(person: Person){
        if let indexPath = self.personsFetched.indexPath(forObject: person){
            self.delegate?.personAdded(at: indexPath)
        } }
    public var count : Int {
        return self.personsFetched.fetchedObjects?.count ?? 0
    }
    
        
    public func delete(person: Person){
        if let indexPath = self.personsFetched.indexPath(forObject: person){
            PersonDAO.delete(person: person)
            self.delegate?.personDeleted(at: indexPath)
        }
    }
    
    
    public func get(personAt index: Int) -> Person?{
        return self.personsFetched.object(at: IndexPath(row: index, section: 0))
    }

}
