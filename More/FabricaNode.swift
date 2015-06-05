//
//  Fabrica.swift
//  More
//
//  Created by Felipe Costa Nascimento on 5/27/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit
import CoreData


class FabricaNode : AbstractConstruction{

    let NUM_TEXTURES = 5
    
    
    init(size:CGSize){
        super.init(imageNamed: "swing_factory-01.png", size: size)
        
        inicializarDadosFabrica()
        self.IMAGE_NAME = "swing_factory-"
        self.anchorPoint = CGPointMake(0.5, 0.1)
        self.zPosition = 1
        self.name = "fabrica"
        self.userInteractionEnabled = true
        inicializarActionSwing()
    }
    
    private func inicializarDadosFabrica(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let entity =  NSEntityDescription.entityForName("Fabrica", inManagedObjectContext: managedContext)
        constructionData = Fabrica(entity: entity!, insertIntoManagedObjectContext: managedContext)
        constructionData.setValue(1, forKey: "tipo")
        constructionData.setValue(0, forKey: "qtdFuncionario")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        println("tocou na fabrica")
        delegate?.goToFabrica(constructionData)
    }
    
    
    private func inicializarActionSwing(){
        var arrayTextures:Array<SKTexture> = Array()
        
        var i = NUM_TEXTURES
        
        while(i >= 1){
            arrayTextures.append(SKTexture(imageNamed: "\(IMAGE_NAME)0\(i).png"))
            i--
        }
        
        
        actionSwing = SKAction.repeatActionForever(SKAction.animateWithTextures(arrayTextures, timePerFrame: 0.09))
        
    }
    
    
}
