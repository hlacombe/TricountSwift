//
//  TripDAO.swift
//  ProjetSwift
//
//  Created by Hugo LACOMBE on 22/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit
import CoreData

class TripDAO: NSObject {
    
    static let request : NSFetchRequest<Voyage> = Voyage.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    static func delete(voyage: Voyage){
        CoreDataManager.context.delete(voyage)
        
    }
    
    static func search(name: String) -> [Voyage]?{
        self.request.predicate = NSPredicate(format: "nom == %@", name)
        do{
            return try CoreDataManager.context.fetch(request) as [Voyage]
        }
        catch{
            return nil
        } }

}
