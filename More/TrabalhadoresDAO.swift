//
//  TrabalhadoresDAO.swift
//  More
//
//  Created by William Alvelos on 29/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import Foundation
import CoreData

protocol TrabalhadoresDAO{
    
    
    func getFetchedResultsController()->NSFetchedResultsController;
    
    func TrabalhadoresFetchRequest()->NSFetchRequest;
    
    func inserirTrabalhador(TrabalhadorNovo:Trabalhadores);
    
    
}