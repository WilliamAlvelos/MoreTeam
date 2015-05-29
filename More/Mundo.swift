//
//  Mundo.swift
//  More
//
//  Created by William Alvelos on 29/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import Foundation
import CoreData


@objc(Mundo)
class Mundo: NSManagedObject {
    
    @NSManaged var ambiental: UInt32
    @NSManaged var dinheiro: Double
    @NSManaged var economico: UInt32
    @NSManaged var marketing: UInt32
    @NSManaged var social: UInt32
 

}
