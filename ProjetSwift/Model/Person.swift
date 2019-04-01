//
//  Person.swift
//  ProjetSwift
//
//  Created by Hugo LACOMBE on 22/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit
import CoreData

extension Person {
    
    public var firstname : String {
        get{ return self.pfirstname  ?? "" }
        set{ pfirstname = newValue }
    }
    public var lastname  : String {
        get{ return self.plastname  ?? "" }
        set{ plastname = newValue }
    }
    public var solde : Double {
        return 0.0
    }
    
    public var fullname: String {
        return self.firstname + " " + self.lastname
    }

    public var dateArrivee: Date? {
        get{ return self.pdateArrivee}
        set{ pdateArrivee = newValue }
    }
    
    public var hasDebt: Bool {
        get{ return self.pHasDebt}
        set{ pHasDebt = newValue }
    }
    
    public var isHidden: Bool {
        get{ return self.pHidden}
        set{ pHidden = newValue }
    }
    
    convenience init(firstname: String, lastname: String){
        self.init(context: CoreDataManager.context)
        self.pfirstname = firstname
        self.plastname  = lastname
    }
}
