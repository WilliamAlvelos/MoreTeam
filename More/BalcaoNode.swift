//
//  FilaLoja.swift
//  More
//
//  Created by Lucca Marmion on 27/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit

class BalcaoNode: SKSpriteNode {
    
    var balcaoAnimacao : SKAction!
    var balcao : SKSpriteNode!
    
    init()
    {
        super.init(texture: nil, color: nil, size: CGSize(width: 1, height: 1))
        
        balcao = SKSpriteNode(imageNamed: "cashier-01")
        balcao.zPosition = 2
        self.addChild(balcao)
        
        iniciarAction()
    }
    
    
    private func iniciarAction()
    {
        var balcaoArray = Array<SKTexture>()
        
        balcaoArray.append(SKTexture(imageNamed: "cashier-02"))
        balcaoArray.append(SKTexture(imageNamed: "cashier-03"))
        balcaoArray.append(SKTexture(imageNamed: "cashier-04"))
        balcaoArray.append(SKTexture(imageNamed: "cashier-01"))
        
        balcaoAnimacao = SKAction.animateWithTextures(balcaoArray, timePerFrame: 0.2)
    }
    
    func iniciarAnimacao()
    {
        println("entrou na animacao")
        balcao.runAction(balcaoAnimacao)
        self.runAction(SKAction.playSoundFileNamed("cash.mp3", waitForCompletion: false))
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}