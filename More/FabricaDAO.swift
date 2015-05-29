//
//  FabricaDAO.swift
//  More
//
//  Created by William Alvelos on 29/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import Foundation
import CoreData



protocol FabricaDAO{
    
    func getFetchedResultsController()->NSFetchedResultsController;
    func FabricaFetchRequest()->NSFetchRequest;
    func inserirFabrica(fabricaNova:Fabrica);
    func editarFabrica(fabricaNova: Fabrica);
    func excluirFabrica(fabricaNova: Fabrica)
    
}