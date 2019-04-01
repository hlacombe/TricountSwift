//
//  CurrentActivitySingleton.swift
//  ProjetSwift
//
//  Created by Hugo LACOMBE on 01/04/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit

class CurrentActivitySingleton{
    
    static let shared: CurrentActivitySingleton = CurrentActivitySingleton()
    
    var voyage: Activity? = nil
    
    private init(){}

}
