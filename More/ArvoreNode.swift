//
//  ArvoreNode.swift
//  More
//
//  Created by Felipe Costa Nascimento on 6/2/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit

class ArvoreNode: SKSpriteNode {
    
    let IMAGE_NAME = "swing_tree-"
    let NUM_TEXTURES = 4
    var actionSwing:SKAction!
    
    
    init(size:CGSize){
        super.init(texture: SKTexture(imageNamed: "\(IMAGE_NAME)03.png"), color: nil, size: size)
        
        //self.zPosition = 1
        inicializarActionSwing()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        println("tocou na fabrica")
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
