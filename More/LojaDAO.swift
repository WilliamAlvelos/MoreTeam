//
//  LojaDAO.swift
//  More
//
//  Created by William Alvelos on 29/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import Foundation
import CoreData


protocol LojaDAO{
    
    
    func getFetchedResultsController()->NSFetchedResultsController;
    
    func LojaFetchRequest()->NSFetchRequest;
    
    func inserirLoja(LojaNova:Loja);
    
    func editarLoja(LojaNova: Loja);
    
    func excluirLoja(LojaNova: Loja);
    
}