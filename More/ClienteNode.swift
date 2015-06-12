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
    
    var andarAnimacao : SKAction!
    var andarAnimacao2 : SKAction!
    var andarAnimacaoGroup : SKAction!
    var sairAnimacaoGroup : SKAction!
    var andarUmPoucoAnimacaGroup : SKAction!
    var actionWait = SKAction.waitForDuration(4)

    
    var actionMove = SKAction.moveByX(0, y: 120, duration: 1.2)
    var actionMoveUp = SKAction.moveByX(0, y: 400, duration: 4)
    var actionMoveSair = SKAction.moveByX(0, y: 100, duration: 1)

    
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
        
        iniciarAnimacoes()
    }
    
    private func iniciarAnimacoes() {
        
        var andarArray = Array<SKTexture>()
        var andarArray2 = Array<SKTexture>()
        
        for i in 2 ... 22
        {
            andarArray.append(SKTexture(imageNamed: "consumer-\(i)"))
        }
        
        for i in 2 ... 8
        {
            andarArray2.append(SKTexture(imageNamed: "consumer-\(i)"))
        }
        
        andarAnimacao = SKAction.repeatAction(SKAction.animateWithTextures(andarArray, timePerFrame: 0.1), count: 3)
        andarAnimacao2 = SKAction.animateWithTextures(andarArray2, timePerFrame: 0.1)
        //
        andarAnimacaoGroup = SKAction.group([andarAnimacao, actionMoveUp])
        sairAnimacaoGroup = SKAction.group([andarAnimacao2, actionMoveSair])
        andarUmPoucoAnimacaGroup = SKAction.group([andarAnimacao2, actionMove])
    }
    
    func andarUmPouco() {
        self.runAction(andarUmPoucoAnimacaGroup, withKey: "move")
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}