//
//  DebtCalculator.swift
//  ProjetSwift
//
//  Created by Hugo LACOMBE on 26/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit
import Foundation

class DebtCalculator{

    var debts: Dictionary<Person, Double>
    var depenses: [Depense]?
    var proposedRefunds: Dictionary<Person, Double>
    var participants: [Person]?
    var solde: Double
    
    init(){
        self.solde = 0.0
        self.proposedRefunds = Dictionary<Person, Double>()
        let voyage: Voyage = CurrentVoyageSingleton.shared.voyage!
        self.depenses = DepenseDAO.fetchDepenseForVoyage(forVoyage: voyage)
        self.debts = Dictionary<Person, Double>()
        //self.participants = PersonDAO.fetchPersonForVoyage(forVoyage: voyage)
        generateDebts()
    }
    
    func generateDebts(){
        guard participants != nil else {
            return
        }
        for p in participants!{
            debts.updateValue(balanceForPerson(for: p), forKey: p)
        }
        while solde != 0.0 {
            if let c = getTopCreditor(),let d = getTopDebitor(){
            proposeRefund(creditor: c, debitor: d)
            updateSolde()
            }
        }
    }
    
    func balanceForPerson(for name: Person) -> Double{
        var balance: Double = 0.0
        guard depenses != nil else {
            return balance
        }
        for depense in depenses! {
            if depense.crediteur == name{
                balance = balance + depense.montant
            }
            if depense.debiteur == name{
                balance = balance + depense.montant
            }
        }
        return balance
    }
    
    func proposeRefund(creditor: Person, debitor: Person){
        let montant = min(abs(debts[creditor]!), abs(debts[debitor]!))
        self.proposedRefunds.updateValue(-montant, forKey: creditor)
        self.proposedRefunds.updateValue(-montant, forKey: debitor)
        self.debts.updateValue(debts[creditor]!-montant, forKey: creditor)
        self.debts.updateValue(debts[debitor]!-montant, forKey: debitor)
    }
    
    func getTopCreditor() -> Person?{
        let greatest = debts.max { a, b in a.value < b.value }
        return greatest?.key
    }
    
    func getTopDebitor() -> Person?{
        let greatest = debts.min { a, b in a.value < b.value }
        return greatest?.key
    }
    
    func updateSolde(){
        var result: Double = 0.0
        for p in debts.keys {
            result = result + debts[p]!
        }
    }

}
