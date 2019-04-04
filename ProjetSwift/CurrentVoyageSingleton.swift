//
//  CurrentVoyageSingleton.swift
//  ProjetSwift
//
//  Created by Hugo LACOMBE on 26/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit

class CurrentVoyageSingleton{
    
    static let shared: CurrentVoyageSingleton = CurrentVoyageSingleton()
    
    var voyage: Voyage? = nil
    
    var currentDebts:Dictionary<Person, Double> {
        return DebtCalculator().currentDebts
    }
    
    var debts: Dictionary<Person, Double> {
        return DebtCalculator().debts
    }
    
    func proposedDebts(person: Person) -> [proposal] {
        let dc = DebtCalculator()
        let res = dc.debtsForPerson(person: person)
        return res
    }
    
    private init(){}

}
