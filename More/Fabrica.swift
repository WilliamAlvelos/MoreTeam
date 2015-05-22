//
//  Fabrica.swift
//  More
//
//  Created by William Alvelos on 21/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//


import UIKit
import SpriteKit
import CoreData


class Fabrica: SKScene, SKPhysicsContactDelegate, NSFetchedResultsControllerDelegate{
    
    
    
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    let myLabel = SKLabelNode(fontNamed:"Heveltica")
    
    var trabalhador:Trabalhadores? = nil
    
    var trabalhadores = 0;
    
    var frc:NSFetchedResultsController = NSFetchedResultsController()
    
    
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
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        
        frc = getFetchedResultsController()
        frc.delegate = self
        frc.performFetch(nil)
        
        trabalhadores = retornaDados().count
        
        
        
        let fundoFabrica = SKSpriteNode(imageNamed: "FabricaGame.jpg")
        fundoFabrica.xScale = 1.0
        fundoFabrica.yScale = 1.0
        fundoFabrica.position = CGPointMake(frame.size.width/2 ,frame.size.height/2)
        
        
        self.addChild(fundoFabrica);
        

        myLabel.text = NSString(format: "%d", trabalhadores) as String
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + 100);
        
        let play = SKSpriteNode(imageNamed: "Play")
        play.xScale = 0.5
        play.yScale = 0.5
        play.position = CGPointMake(frame.size.width/2 ,frame.size.height/2)
        play.name = "play"
        
        
        
        
        self.addChild(play)
        self.addChild(myLabel)
        
        
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            var node = self.nodeAtPoint(location)
            
            if (node.name == "play") {
                trabalhadores++;
                myLabel.text = NSString(format: "%d", trabalhadores) as String
                
                salvarDados();
                
            }
            
        }
    }

    
    
    func salvarDados(){
        let ent = NSEntityDescription.entityForName("Trabalhadores", inManagedObjectContext:context!)
        
        let trabalhador = Trabalhadores(entity: ent!, insertIntoManagedObjectContext: context)
        
        //trabalhador.felicidade
        //trabalhador.quantidade = trabalhadores;
        
        context?.save(nil)
    }
    
    func editarDados(){
        
        //carro?.nome = textCarro.text
        //carro?.ano = textAno.text
        
        trabalhador?.quantidade = NSString(format: "%d", trabalhadores) as String
        
        context?.save(nil)
        
    }
    

}
