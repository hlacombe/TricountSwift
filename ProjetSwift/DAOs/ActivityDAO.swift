//
//  ActivityDAO.swift
//  ProjetSwift
//
//  Created by Hugo LACOMBE on 26/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit
import CoreData

class ActivityDAO: NSObject {
    
    static let request : NSFetchRequest<Activity> = Activity.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    static func delete(activity: Activity){
        CoreDataManager.context.delete(activity)
    }
    static func fetchAll() -> [Activity]?{
        self.request.predicate = nil
        do{
            return try CoreDataManager.context.fetch(self.request)
        }
        catch{
            return nil
        } }
    
    static var count: Int{
        self.request.predicate = nil
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        } }
    
    /*
    static func search(forFirstname firstname: String, lastname: String) -> [Person]?{
        self.request.predicate = NSPredicate(format: "firstname == %@ AND lastname == %@", firstname, lastname)
        do{
            return try CoreDataManager.context.fetch(request) as [Person]
        }
        catch{
            return nil
        } }
 */
    

}
