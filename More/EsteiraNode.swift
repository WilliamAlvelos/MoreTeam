//
//  EsteiraNode.swift
//  More
//
//  Created by William Alvelos on 01/06/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import Foundation
import SpriteKit

class EsteiraNode: SKSpriteNode{

    
    var esteira = SKSpriteNode(imageNamed: "conveyor_belt-23")
    
    var esteira2 = SKSpriteNode(imageNamed: "conveyor_belt-23")

    
    init(){
        super.init(texture: nil, color: UIColor.grayColor(), size: CGSizeMake(esteira.size.width, esteira.size.height))

    }
    
    
    func moveEsteira(){
        
        var moveEsteiraSprite = SKAction.moveByX(0, y:esteira.size.height, duration: 0.5)
        var moveGroundSpritesForever = SKAction.repeatActionForever(SKAction.sequence([moveEsteiraSprite]))
        esteira.position = CGPointMake(0, -esteira.size.height/2)
        esteira2.position = CGPointMake(0, esteira.position.y - esteira2.size.height)
        
        esteira.runAction(moveGroundSpritesForever)
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
