//
//  TrabalhadorDAOCoreData.swift
//  More
//
//  Created by William Alvelos on 29/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TrabalhadoresDAOCoreData: NSFetchedResultsControllerDelegate, TrabalhadoresDAO{

    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var frc:NSFetchedResultsController = NSFetchedResultsController()
    
    
    func getFetchedResultsController()->NSFetchedResultsController{
        
        var context: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        
        frc = NSFetchedResultsController(fetchRequest: TrabalhadoresFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        return frc
    }
    
    
    func TrabalhadoresFetchRequest()->NSFetchRequest{
        let fetchRequest = NSFetchRequest(entityName: "Trabalhadores")
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return fetchRequest
    }
    
    
    func inserirTrabalhador(TrabalhadorNovo:Trabalhadores){
        let ent = NSEntityDescription.entityForName("Trabalhadores", inManagedObjectContext: context!)
        
        var trabalhador = Trabalhadores(entity: ent!, insertIntoManagedObjectContext: context)
        
        trabalhador = TrabalhadorNovo
        
        context?.save(nil)
    }
    

}