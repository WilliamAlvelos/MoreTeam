//
//  Loja.swift
//  More
//
//  Created by William Alvelos on 29/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import Foundation
import CoreData


@objc(Loja)
class Loja: NSManagedObject {
    
    @NSManaged var quantidade: Int
    @NSManaged var indexPosicao: Int
    
}


