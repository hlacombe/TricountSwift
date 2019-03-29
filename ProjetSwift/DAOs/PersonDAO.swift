//
//  PersonDAO.swift
//  ProjetSwift
//
//  Created by Hugo LACOMBE on 22/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit
import CoreData

class PersonDAO: NSObject {
    
    static let request : NSFetchRequest<Person> = Person.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    static func delete(person: Person){
        CoreDataManager.context.delete(person)
    }
    static func fetchAll() -> [Person]?{
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
    
    static func count(forFirstname firstname: String) -> Int{
        self.request.predicate = NSPredicate(format: "firstname == %@", firstname)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        } }
    
    static func search(forFirstname firstname: String, lastname: String) -> [Person]?{
        self.request.predicate = NSPredicate(format: "firstname == %@ AND lastname == %@", firstname, lastname)
        do{
            return try CoreDataManager.context.fetch(request) as [Person]
        }
        catch{
            return nil
        } }

}

