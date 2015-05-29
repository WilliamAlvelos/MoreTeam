//
//  LojaDAO.swift
//  More
//
//  Created by William Alvelos on 29/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//


import Foundation
import CoreData
import UIKit


class LojaDAOCoreData: NSFetchedResultsControllerDelegate, LojaDAO{

    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    var loja:Loja? = nil
    
    var frc:NSFetchedResultsController = NSFetchedResultsController()

    init(){
        frc = getFetchedResultsController()
        frc.delegate = self
        frc.performFetch(nil)
    }

    func getFetchedResultsController()-> NSFetchedResultsController{
        
        var context: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        
        frc = NSFetchedResultsController(fetchRequest: LojaFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        return frc
    }

    func LojaFetchRequest() -> NSFetchRequest{
        let fetchRequest = NSFetchRequest(entityName: "Loja")
        let sortDescriptor = NSSortDescriptor(key: "posicao", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return fetchRequest
    }
    
    
    
    func inserirLoja(LojaNova:Loja){
        let ent = NSEntityDescription.entityForName("Loja", inManagedObjectContext: context!)
        
        var loja = Loja(entity: ent!, insertIntoManagedObjectContext: context)
        
        loja = LojaNova
        
        context?.save(nil)
    }
    
    func editarLoja(LojaNova: Loja){
        
        loja? = LojaNova
        
        context?.save(nil)
        
    }
    
    func excluirLoja(LojaNova: Loja){
        
        context?.delete(LojaNova)
    }


}

    