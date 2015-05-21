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

class Fabrica: SKScene, SKPhysicsContactDelegate{
    
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var funcionario:Trabalhadores? = nil
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        let fundoFabrica = SKSpriteNode(imageNamed: "FabricaGame.jpg")
        fundoFabrica.xScale = 1.0
        fundoFabrica.yScale = 1.0
        fundoFabrica.position = CGPointMake(frame.size.width/2 ,frame.size.height/2)
        
        
        self.addChild(fundoFabrica);
        
        
    }
    
    
    
    func salvarDados(){
        let ent = NSEntityDescription.entityForName("Trabalhadores", inManagedObjectContext:context!)
        
        let trabalhador = Trabalhadores(entity: ent!, insertIntoManagedObjectContext: context)
        
        //trabalhador.felicidade
        //trabalhador.quantidade
        
        context?.save(nil)
    }
    
    func editarDados(){
        
        //carro?.nome = textCarro.text
        //carro?.ano = textAno.text
        
        context?.save(nil)
        
    }
    

}
