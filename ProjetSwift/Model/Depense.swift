//
//  Depense.swift
//  ProjetSwift
//
//  Created by Hugo LACOMBE on 26/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import Foundation

extension Depense{
    
    public var montant  : Double {
        get{ return self.pmontant}
        set{ self.pmontant = newValue }
    }
    
    public var crediteur  : Person? {
        get{ return (self.pcrediteur ?? nil) }
        set{ self.pcrediteur = newValue }
    }
    
    public var debiteur  : Person? {
        get{ return self.pdebiteur ?? nil }
        set{ self.pdebiteur = newValue }
    }
    
    public var activite  : Activity? {
        get{ return self.psourceActivity ?? nil }
        set{ self.psourceActivity = newValue }
    }
    
}

