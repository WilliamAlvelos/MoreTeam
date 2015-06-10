//
//  FilaLoja.swift
//  More
//
//  Created by Lucca Marmion on 27/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit

class TrabalhadorNode: SKSpriteNode {
    
    let CollisionNodeCliente     : UInt32 = 0x1 << 1
    let CollisionNodeBalcao : UInt32 = 0x1 << 2
    
    var trabalhadorAnimacao : SKAction!
    var trabalhadorNode : SKSpriteNode!
    
    
    init()
    {
        super.init(texture: SKTexture(imageNamed: "worker_store-61"), color: nil, size: CGSize(width: 135, height: 191))
        
        self.xScale = 0.5
        self.yScale = 0.5
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 70, height: 5), center: CGPoint(x: 110, y: 40))
        self.name = "trabalhadorNode"
        self.zPosition = 3
        self.physicsBody?.dynamic = false
        //        self.physicsBody?.allowsRotation = false
        self.physicsBody!.categoryBitMask = CollisionNodeBalcao
        self.physicsBody?.contactTestBitMask = CollisionNodeCliente
        
        animacaoTrabalhador()
        
    }
    
    private func animacaoTrabalhador ()
    {
        
        var trabalhadorArray = Array<SKTexture>()
        
        for i in 61 ... 90 {
            trabalhadorArray.append(SKTexture(imageNamed: "worker_store-\(i)"))
        }
        
        trabalhadorAnimacao = SKAction.repeatAction(SKAction.animateWithTextures(trabalhadorArray, timePerFrame: 0.025), count: 2)
        
    }
    
    func iniciarAnimacao() {
        
        self.runAction(trabalhadorAnimacao)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}