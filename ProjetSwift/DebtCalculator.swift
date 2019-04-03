//
//  DebtCalculator.swift
//  ProjetSwift
//
//  Created by Hugo LACOMBE on 26/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit
import Foundation

class proposal{
    var creditor: Person
    var debitor: Person
    var montant: Double
    
    init(c: Person, d: Person, m: Double) {
        self.creditor = c
        self.debitor = d
        self.montant = m
    }
}

class DebtCalculator{
    
    var debts: Dictionary<Person, Double>
    var depenses: [Depense]?
    var proposedRefunds: [proposal]
    var participants: [Person]?
    
    init(){
        self.proposedRefunds = [proposal]()
        let voyage: Voyage = CurrentVoyageSingleton.shared.voyage!
        self.depenses = DepenseDAO.fetchDepenseForVoyage(forVoyage: voyage)
        self.debts = Dictionary<Person, Double>()
        self.participants = PersonDAO.fetchPersonForVoyage()
        generateDebts()
    }
    
    func generateDebts(){
        guard participants != nil else {
            return
        }
        for p in participants!{
            debts[p] = balanceForPerson(for: p)
        }
        while isSomeoneInDebt(){
            if let c = getTopCreditor(),let d = getTopDebitor(){
                self.proposeRefund(creditor: c, debitor: d)
            }
        }
    }
    
    func balanceForPerson(for name: Person) -> Double{
        var balance: Double = 0
        guard depenses != nil else {
            return balance
        }
        for depense in depenses! {
            if depense.crediteur == name{
                balance = balance + depense.montant
            }
            if depense.debiteur == name{
                balance = balance - depense.montant
            }
        }
        return balance
    }
    
    func proposeRefund(creditor: Person, debitor: Person){
        let montant = min(abs(debts[debitor]!), abs(debts[creditor]!))
        let p = proposal(c: creditor, d: debitor, m: montant)
        self.proposedRefunds.append(p)
        self.debts.updateValue(debts[creditor]!-montant, forKey: creditor)
        self.debts.updateValue(debts[debitor]!+montant, forKey: debitor)
    }
    
    func getTopCreditor() -> Person?{
        let greatest = debts.max { a, b in a.value < b.value }
        return greatest?.key
    }
    
    func getTopDebitor() -> Person?{
        let greatest = debts.min { a, b in a.value < b.value }
        return greatest?.key
    }
    
    func isSomeoneInDebt() -> Bool{
        for p in debts.keys {
            if(debts[p]! > 0.0){
                return true
            }
        }
        return false
    }
    
    func debtsForPerson(person: Person) -> [proposal]{
        var result = [proposal]()
        for p in self.proposedRefunds {
            if p.debitor == person{
                result.append(p)
            }
        }
        return result
    }
    
}

