//
//  Loja.swift
//  More
//
//  Created by Felipe Costa Nascimento on 5/27/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit
import CoreData



class LojaNode : AbstractConstruction{
    
    let NUM_TEXTURES = 4
    
    
    init(size:CGSize){
        super.init(imageNamed: "swing_store-01.png", size: size)
        
        inicializarDadosFabrica()
        self.IMAGE_NAME = "swing_store-"
        self.zPosition = 1
        self.anchorPoint = CGPointMake(0.5, 0.1)
        self.name = "loja"
        self.userInteractionEnabled = true
    }
    
    
    private func inicializarDadosFabrica(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let entity =  NSEntityDescription.entityForName("Loja", inManagedObjectContext: managedContext)
        constructionData = Loja(entity: entity!, insertIntoManagedObjectContext: managedContext)
        constructionData.setValue(0, forKey: "qtdFuncionario")
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        delegate?.goToLoja(constructionData)
    }
    
    
    private func inicializarActionSwing(){
        var arrayTextures:Array<SKTexture> = Array()
        
        for i in 1 ... NUM_TEXTURES{
            //arrayTextures.addObject(SKTexture(imageNamed: "\(IMAGE_NAME)\(i).png"))
            arrayTextures.append(SKTexture(imageNamed: "\(IMAGE_NAME)0\(i).png"))
        }
        
        
        actionSwing = SKAction.repeatActionForever(SKAction.animateWithTextures(arrayTextures, timePerFrame: 0.09))
        
    }
    
    
    
}
