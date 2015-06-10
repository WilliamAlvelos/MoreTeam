//
//  FilaLoja.swift
//  More
//
//  Created by Lucca Marmion on 27/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit

class ClienteNode: SKSpriteNode {
    
    let CollisionNodeCliente     : UInt32 = 0x1 << 1
    let CollisionNodeBalcao : UInt32 = 0x1 << 2
    let CollisionQuadrado : UInt32 = 0x1 << 3
    var fila : Int!
    
    init(size : CGSize, varFila : Int)
    {
        super.init(texture: SKTexture(imageNamed:"consumer-1"), color: nil, size: size)
        
        self.fila = varFila
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 30, height: 115))
        self.physicsBody?.dynamic = true
        self.physicsBody!.categoryBitMask = CollisionNodeCliente
        self.physicsBody!.contactTestBitMask =
            CollisionNodeCliente | CollisionNodeBalcao
        self.name = "cliente"
        self.zPosition = 2
        self.physicsBody!.allowsRotation = false
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}