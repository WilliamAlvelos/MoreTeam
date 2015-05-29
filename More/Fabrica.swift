//
//  Fabrica.swift
//  More
//
//  Created by William Alvelos on 29/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import Foundation
import CoreData


@objc(Fabrica)
class Fabrica: NSManagedObject {
    
    @NSManaged var tipo: UInt32
    @NSManaged var posicao: UInt32
    @NSManaged var idFabrica: UInt16
    
}


