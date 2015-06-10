//
//  FilaLoja.swift
//  More
//
//  Created by Lucca Marmion on 27/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit

class PortaNode: SKSpriteNode {
    
    var porta : SKSpriteNode!
    var animacaoPorta : SKAction!
    
    init()
    {
        super.init(texture: nil, color: nil, size: CGSize(width: 1, height: 1))
        
        porta = SKSpriteNode(imageNamed: "door-C-15")
        porta.zPosition = 1
        self.addChild(porta)
        
        criarActionPorta()
    }
    
    private func criarActionPorta ()
    {
        
        var abrirPortaArray = Array<SKTexture>()
        
        for i in 15 ... 20
        {
            abrirPortaArray.append(SKTexture(imageNamed: "door-C-\(i)"))
        }
        
        var animacaoPortaAbrir = SKAction.animateWithTextures(abrirPortaArray, timePerFrame: 0.1)
        var waitPorta = SKAction.waitForDuration(2)
        var animacaoPortaFechar = animacaoPortaAbrir.reversedAction()
        
        animacaoPorta = SKAction.sequence([animacaoPortaAbrir, waitPorta, animacaoPortaFechar])
    }
    
    func abrirPorta() {
        
        porta.runAction(animacaoPorta)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}