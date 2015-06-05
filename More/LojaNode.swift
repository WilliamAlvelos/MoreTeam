//
//  Loja.swift
//  More
//
//  Created by Felipe Costa Nascimento on 5/27/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit
import CoreData



class LojaNode : SKSpriteNode{
    
    
    var dadosLoja:Loja!
    
    var delegate:AbstractSceneDelegate?
    let IMAGE_NAME = "swing_store-"
    let NUM_TEXTURES = 4
    var actionSwing:SKAction!
    
    
    init(size:CGSize){
        super.init(texture: SKTexture(imageNamed: "\(IMAGE_NAME)01.png"), color: nil, size: size)
        
        inicializarDadosFabrica()
        
        //self.zPosition = 1
        self.anchorPoint = CGPointMake(0.5, 0.1)
        self.name = "loja"
        self.userInteractionEnabled = true
        inicializarActionSwing()
    }
    
    
    private func inicializarDadosFabrica(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let entity =  NSEntityDescription.entityForName("Loja", inManagedObjectContext: managedContext)
        dadosLoja = Loja(entity: entity!, insertIntoManagedObjectContext: managedContext)
        dadosLoja.setValue(0, forKey: "qtdFuncionario")
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        delegate?.goToLoja(dadosLoja)
    }
    
    
    private func inicializarActionSwing(){
        var arrayTextures:Array<SKTexture> = Array()
        
        for i in 1 ... NUM_TEXTURES{
            //arrayTextures.addObject(SKTexture(imageNamed: "\(IMAGE_NAME)\(i).png"))
            arrayTextures.append(SKTexture(imageNamed: "\(IMAGE_NAME)0\(i).png"))
        }
        
        
        actionSwing = SKAction.repeatActionForever(SKAction.animateWithTextures(arrayTextures, timePerFrame: 0.09))
        
    }
    
    
    func startSwingAnimation(){
        self.runAction(actionSwing)
    }
    
}
