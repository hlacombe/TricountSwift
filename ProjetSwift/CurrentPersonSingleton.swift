//
//  CurrentPersonSingleton.swift
//  ProjetSwift
//
//  Created by Thibaut ALLARD-SERRE on 29/03/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit
class CurrentPersonSingleton{
    
    static let shared: CurrentPersonSingleton = CurrentPersonSingleton()
    
    var person: Person? = nil
    
    private init(){}
    
}
