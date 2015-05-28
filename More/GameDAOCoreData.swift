//
//  GameDAOCoreData.swift
//  More
//
//  Created by William Alvelos on 28/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class GameDAOCoreData: GameDAO, NSFetchedResultsControllerDelegate{
    
    
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var frc:NSFetchedResultsController = NSFetchedResultsController()
    
    init(){
        frc = getFetchedResultsController()
        frc.delegate = self
        frc.performFetch(nil)
    }
    
    func retornaDados() ->[Trabalhadores]{
        
        let fetchedLists: [Trabalhadores]? = frc.fetchedObjects as? [Trabalhadores]
        
        return fetchedLists!
    }
    
    
    func getFetchedResultsController()-> NSFetchedResultsController{
        
        var context: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        
        frc = NSFetchedResultsController(fetchRequest: trabalhadoresFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        return frc
    }
    
    func trabalhadoresFetchRequest() -> NSFetchRequest{
        let fetchRequest = NSFetchRequest(entityName: "Trabalhadores")
        let sortDescriptor = NSSortDescriptor(key: "quantidade", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return fetchRequest
    }
    
    
    
    func salvarDados(){
        let ent = NSEntityDescription.entityForName("Trabalhadores", inManagedObjectContext:context!)
        
        let trabalhador = Trabalhadores(entity: ent!, insertIntoManagedObjectContext: context)
        
        //trabalhador.quantidade = trabalhadores;
        
        context?.save(nil)
    }
    
    func editarDados(){
        
        
        //trabalhador?.quantidade = NSString(format: "%d", trabalhadores) as String
        
        context?.save(nil)
        
    }


}



