//
//  CurrentActivitySingleton.swift
//  ProjetSwift
//
//  Created by Thibaut on 03/04/2019.
//  Copyright © 2019 Thibaut ALLARD-SERRE. All rights reserved.
//

import UIKit

class CurrentActivitySingleton{
    
    static let shared: CurrentActivitySingleton = CurrentActivitySingleton()
    
    var activity: Activity? = nil

    
    private init(){}
    
}

