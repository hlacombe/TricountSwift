//
//  ActivityViewModel.swift
//  ProjetSwift
//
//  Created by Hugo LACOMBE on 01/04/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//
import UIKit
import CoreData
import Foundation

protocol ActivityViewModelDelegate {
    
    func dataSetChanged()
    
    func activityDeleted(at indexPath: IndexPath)
    
    func activityUpdated(at indexPath: IndexPath)
    
    func activityAdded(at indexPath: IndexPath)
}

class ActivityViewModel: NSObject {
    
    var delegate : ActivityViewModelDelegate? = nil
    var activitesFetched : NSFetchedResultsController<Activity>
    
    init(data: NSFetchedResultsController<Activity>){
        self.activitesFetched = data
    }
    //-------------------------------------------------------------------------------------------------
    // MARK: View Model functions
    /// add a new person in set of persons
    ///
    /// - Parameter person: Person to be added
    public func add(activity: Activity){
        if let indexPath = self.activitesFetched.indexPath(forObject: activity){
            self.delegate?.activityAdded(at: indexPath)
        }
    }
    
    public func delete(activity: Activity){
        if let indexPath = self.activitesFetched.indexPath(forObject: activity){
            ActivityDAO.delete(activity: activity)
            self.delegate?.activityDeleted(at: indexPath)
        }
    }
    
    public var count : Int {
        return self.activitesFetched.fetchedObjects?.count ?? 0
    }
    
    public func get(activityAt index: Int) -> Activity?{
        return self.activitesFetched.object(at: IndexPath(row: index, section: 0))
    }
    
}
