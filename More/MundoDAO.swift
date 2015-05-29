//
//  MundoDAO.swift
//  More
//
//  Created by William Alvelos on 29/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import Foundation
import CoreData


protocol MundoDAO{
    
    
    func getFetchedResultsController()->NSFetchedResultsController;
    
    func MundoFetchRequest()->NSFetchRequest;
    
    func editarMundo(MundoNovo:Mundo)
    
}
