//
//  DepenseDAO.swift
//  ProjetSwift
//
//  Created by Hugo LACOMBE on 26/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit
import CoreData

class DepenseDAO: NSObject {
    
    static let request : NSFetchRequest<Depense> = Depense.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    static func delete(depense: Depense){
        CoreDataManager.context.delete(depense)
    }
    
    static func fetchCreditorsForPerson(forPerson person: Person) -> [Depense]?{
        self.request.predicate = NSPredicate(format: "pcrediteur == %@", person)
        do{
            return try CoreDataManager.context.fetch(request) as [Depense]
        }
        catch{
            return nil
        } }

    static func fetchDepenseForVoyage(forVoyage voyage: Voyage) -> [Depense]?{
        let acts = voyage.activites
        self.request.predicate = NSPredicate(format: "psourceActivity IN %@", acts!)
        do{
            return try CoreDataManager.context.fetch(request) as [Depense]
        }
        catch{
            return nil
        } }
}
