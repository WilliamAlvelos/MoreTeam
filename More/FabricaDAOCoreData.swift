//
//  FabricaDAO.swift
//  More
//
//  Created by William Alvelos on 29/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class FabricaDAOCoreData: NSFetchedResultsControllerDelegate, FabricaDAO{
    
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var fabrica:Fabrica? = nil
    
    var frc:NSFetchedResultsController = NSFetchedResultsController()
    
    init(){
        frc = getFetchedResultsController()
        frc.delegate = self
        frc.performFetch(nil)
    }
    
    func getFetchedResultsController()-> NSFetchedResultsController{
        
        var context: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        
        frc = NSFetchedResultsController(fetchRequest: FabricaFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        return frc
    }
    
    func FabricaFetchRequest() -> NSFetchRequest{
        let fetchRequest = NSFetchRequest(entityName: "Fabrica")
        let sortDescriptor = NSSortDescriptor(key: "idFabrica", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return fetchRequest
    }
    
    
    func inserirFabrica(fabricaNova:Fabrica){
        let ent = NSEntityDescription.entityForName("Fabrica", inManagedObjectContext: context!)
        
        var fabrica = Fabrica(entity: ent!, insertIntoManagedObjectContext: context)
        
        fabrica = fabricaNova
        
        context?.save(nil)
    }
    
    func editarFabrica(fabricaNova: Fabrica){
        
        fabrica? = fabricaNova
        
        context?.save(nil)
        
    }
    
    func excluirFabrica(fabricaNova: Fabrica){
        
        context?.delete(fabricaNova)
    }
    
    
    
    
    
}