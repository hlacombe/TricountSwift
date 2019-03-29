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
    var proposedDebts = {
        return DebtCalculator().proposedRefunds
    }
    
    private init(){}

}
