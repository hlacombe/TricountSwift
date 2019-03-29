//
//  TripViewModel.swift
//  ProjetSwift
//
//  Created by Hugo LACOMBE on 26/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit
import CoreData
import Foundation

protocol TripViewModelDelegate {

    func dataSetChanged()

    func tripDeleted(at indexPath: IndexPath)

    func tripUpdated(at indexPath: IndexPath)

    func tripAdded(at indexPath: IndexPath)
}

class TripViewModel: NSObject {
    
    var delegate : TripViewModelDelegate? = nil
    var tripsFetched : NSFetchedResultsController<Voyage>
    
    init(data: NSFetchedResultsController<Voyage>){
        self.tripsFetched = data
    }
    //-------------------------------------------------------------------------------------------------
    // MARK: View Model functions
    /// add a new person in set of persons
    ///
    /// - Parameter person: Person to be added
    public func add(voyage: Voyage){
        if let indexPath = self.tripsFetched.indexPath(forObject: voyage){
            self.delegate?.tripAdded(at: indexPath)
        }
    }
    
    public func delete(voyage: Voyage){
        if let indexPath = self.tripsFetched.indexPath(forObject: voyage){
            TripDAO.delete(voyage: voyage)
            self.delegate?.tripDeleted(at: indexPath)
        }
    }
    
    public var count : Int {
        return self.tripsFetched.fetchedObjects?.count ?? 0
    }
    public func get(voyageAt index: Int) -> Voyage?{
        return self.tripsFetched.object(at: IndexPath(row: index, section: 0))
    }

}
