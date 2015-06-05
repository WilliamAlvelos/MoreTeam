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
    
    @NSManaged var tipo: Int
    @NSManaged var indexPosicao: Int
    @NSManaged var qtdFuncionario: Int
    //@NSManaged var idFabrica: UInt16
    
}


