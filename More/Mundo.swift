//
//  Mundo.swift
//  More
//
//  Created by Felipe Costa Nascimento on 5/29/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit


class Mundo: SKSpriteNode {
    
    
    
    init(size:CGSize){
        super.init(texture: SKTexture(imageNamed: "terra"), color: nil, size: size)
        
        self.zPosition = 1
        self.userInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func startAnimacaoDeIntroducao(posX:CGFloat){
        
        //CRIA AS ANIMAÇÕES DE MOVIMENTO DA TERRA, APARECIMENTO DOS NODES E REDIMENSIONAMENTO DA TERRA(CASO NECESSÁRIO)
        var actionMove = SKAction.moveToX(posX, duration: 0.8)
        actionMove.timingMode = SKActionTimingMode.EaseInEaseOut
        
        //EXECUTA AS ACTIONS
        self.runAction(actionMove, completion: { () -> Void in
            
        })
    }
}
