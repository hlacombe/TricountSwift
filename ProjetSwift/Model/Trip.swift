//
//  Trip.swift
//  ProjetSwift
//
//  Created by Hugo LACOMBE on 22/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//
import UIKit

extension Voyage{
    
    public var nom  : String {
        get{ return self.pnom  ?? "" }
        set{ self.pnom = newValue }
    }
    
    public var destination  : String {
        get{ return self.pdestination  ?? "" }
        set{ self.pdestination = newValue }
    }
    
    public var dateDepart  : Date? {
        get{ return self.pdateDepart ?? nil }
        set{ self.pdateDepart = newValue }
    }
    
    public var dateArrivee  : Date? {
        get{ return self.pdateArrive ?? nil }
        set{ self.pdateArrive = newValue }
    }
    
}
