//
//  File.swift
//  ProjetSwift
//
//  Created by Hugo LACOMBE on 26/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import Foundation

extension Activity{
    
    public var date  : Date? {
        get{ return self.pdate}
        set{ self.pdate = newValue }
    }
    
    public var montantTotal  : Double {
        get{ return (self.pmontantTotal ) }
        set{ self.pmontantTotal = newValue }
    }
    
    public var nom  : String? {
        get{ return self.pnom ?? nil }
        set{ self.pnom = newValue }
    }
    
    
}
