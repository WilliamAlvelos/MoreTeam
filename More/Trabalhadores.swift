//
//  Trabalhador.swift
//  More
//
//  Created by William Alvelos on 21/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import Foundation
import CoreData

@objc(Trabalhadores)
class Trabalhadores: NSManagedObject {
    
    @NSManaged var quantidade: String
    @NSManaged var felicidade: String
    
}