//
//  MundoDAO.swift
//  More
//
//  Created by William Alvelos on 29/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class MundoDAOCoreData: NSFetchedResultsControllerDelegate, MundoDAO{
    
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var mundo:Mundo? = nil
    
    var frc:NSFetchedResultsController = NSFetchedResultsController()
    
    init(){
        frc = getFetchedResultsController()
        frc.delegate = self
        frc.performFetch(nil)
    }
    
    func getFetchedResultsController()-> NSFetchedResultsController{
        
        var context: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        
        frc = NSFetchedResultsController(fetchRequest: MundoFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        return frc
    }
    
    func MundoFetchRequest() -> NSFetchRequest{
        let fetchRequest = NSFetchRequest(entityName: "Mundo")
        let sortDescriptor = NSSortDescriptor(key: "dinheiro", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return fetchRequest
    }
    
    
    func editarMundo(MundoNovo:Mundo){
        
        mundo? = MundoNovo
        
        context?.save(nil)
    }
    
    
}