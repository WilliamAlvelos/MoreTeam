//
//  EsteiraNode.swift
//  More
//
//  Created by William Alvelos on 01/06/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import Foundation
import SpriteKit


protocol EsteiraNodeDelegate{
    func actionFinish(esteira:EsteiraNode)

}


class EsteiraNode: SKSpriteNode{
    
    
    var delegate:EsteiraNodeDelegate!
    var velocidade:NSTimeInterval!
    var trabalhadores = 0
    
    init(){
        super.init(texture: nil, color: UIColor.grayColor(), size: CGSizeMake(106, 1192))
    }
    
    
    func moveEsteira(){
        
        
        
        var esteira = SKSpriteNode(imageNamed: "conveyor_belt-23")
        var esteira2 = SKSpriteNode(imageNamed: "conveyor_belt-23")
        
        
        addChild(esteira)
        addChild(esteira2)
        
        var moveEsteiraSprite = SKAction.moveByX(0, y: esteira.size.height , duration:(3.0))
       // var moveSpritesForever = SKAction.repeatActionForever(SKAction.sequence([moveEsteiraSprite]))
        
        
        esteira.position = CGPointMake(0, 0)
        esteira2.position = CGPointMake(0, esteira.position.y - esteira.size.height + 8)
        esteira.zPosition = 0.2
        
        esteira2.zPosition = 0.2
        
        esteira.runAction(moveEsteiraSprite, completion: { () -> Void in
            esteira.removeFromParent()
            self.delegate.actionFinish(self)
        })
        
        esteira2.runAction(moveEsteiraSprite, completion: { () -> Void in
            esteira2.removeFromParent()
        })
        
        
    }
    


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
