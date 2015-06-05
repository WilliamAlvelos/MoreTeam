//
//  Fabrica.swift
//  More
//
//  Created by Felipe Costa Nascimento on 5/27/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit
import CoreData


class FabricaNode : SKSpriteNode{
    
    var dadosFabrica:Fabrica!
    
    var delegate:AbstractSceneDelegate?
    let IMAGE_NAME = "swing_factory-"
    let NUM_TEXTURES = 5
    var actionSwing:SKAction!
    
    
    init(size:CGSize){
        super.init(texture: SKTexture(imageNamed: "\(IMAGE_NAME)06.png"), color: nil, size: size)
        
        inicializarDadosFabrica()
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
        dadosFabrica = Fabrica(entity: entity!, insertIntoManagedObjectContext: managedContext)
        dadosFabrica.setValue(1, forKey: "tipo")
        dadosFabrica.setValue(0, forKey: "qtdFuncionario")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        println("tocou na fabrica")
        delegate?.goToFabrica(dadosFabrica)
    }
    
    
    private func inicializarActionSwing(){
        var arrayTextures:Array<SKTexture> = Array()
        
        for i in 1 ... NUM_TEXTURES{
            arrayTextures.append(SKTexture(imageNamed: "\(IMAGE_NAME)0\(i).png"))
        }
        
        
        actionSwing = SKAction.repeatActionForever(SKAction.animateWithTextures(arrayTextures, timePerFrame: 0.09))
        
    }
    
    
    func startSwingAnimation(){
        self.runAction(actionSwing)
    }
    
}
