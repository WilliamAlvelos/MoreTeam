//
//  PopUpNode.swift
//  More
//
//  Created by Felipe Costa Nascimento on 6/2/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit

class PopUpNode: SKSpriteNode {
    
    var nodeX1y1:SKSpriteNode!
    var nodeX1y2:SKSpriteNode!
    var nodeX1y3:SKSpriteNode!
    
    var nodeX2y1:SKSpriteNode!
    var nodeX2y2:SKSpriteNode!
    var nodeX2y3:SKSpriteNode!
    
    
    var nodeX3y1:SKSpriteNode!
    var nodeX3y2:SKSpriteNode!
    var nodeX3y3:SKSpriteNode!
    
    let sizeBotao = CGSizeMake(50, 50)
    
    var nodePrincipal:SKSpriteNode!
    var lblTitulo:SKLabelNode!
    
    
    init(size:CGSize){
        super.init(texture: nil, color: SKColor(red: 0, green: 0, blue: 0, alpha: 0.5), size: size)
        
        self.alpha = 0
        
        
        nodePrincipal = SKSpriteNode(color: UIColor.whiteColor(), size: CGSizeMake(self.size.width / 2, self.size.height / 2))
        self.addChild(nodePrincipal)
        
        lblTitulo = SKLabelNode(fontNamed: "Helvetica")
        lblTitulo.text = "Título"
        lblTitulo.fontColor = UIColor.blackColor()
        lblTitulo.position = CGPointMake(0, nodePrincipal.size.height / 2 - 40)
        nodePrincipal.addChild(lblTitulo)
        
        
        var distanciaEntreNodes:CGFloat = 10
        
        //ADICIONA NODES DA PRIMEIRA FILEIRA
        nodeX1y2 = gerarNodeInPosition(CGPointMake(-nodePrincipal.size.width / 2 + 60, 0))
        nodePrincipal.addChild(nodeX1y2)
        
        nodeX1y1 = gerarNodeInPosition(CGPointMake(nodeX1y2.position.x, nodeX1y2.position.y + sizeBotao.height + distanciaEntreNodes))
        nodePrincipal.addChild(nodeX1y1)
        
        nodeX1y3 = gerarNodeInPosition(CGPointMake(nodeX1y2.position.x, nodeX1y2.position.y - sizeBotao.height - distanciaEntreNodes))
        nodePrincipal.addChild(nodeX1y3)
        
        
        //ADICIONA NODES DA SEGUNDA FILEIRA
        nodeX2y2 = gerarNodeInPosition(CGPointZero)
        nodePrincipal.addChild(nodeX2y2)
        
        nodeX2y1 = gerarNodeInPosition(CGPointMake(nodeX2y2.position.x, nodeX2y2.position.y + sizeBotao.height + distanciaEntreNodes))
        nodePrincipal.addChild(nodeX2y1)
        
        nodeX2y3 = gerarNodeInPosition(CGPointMake(nodeX2y2.position.x, nodeX2y2.position.y - sizeBotao.height - distanciaEntreNodes))
        nodePrincipal.addChild(nodeX2y3)
        
        
        //ADICIONA NODES DA TERCEIRA FILEIRA
        nodeX3y2 = gerarNodeInPosition(CGPointMake(nodePrincipal.size.width / 2 - 60, 0))
        nodePrincipal.addChild(nodeX3y2)
        
        nodeX3y1 = gerarNodeInPosition(CGPointMake(nodeX3y2.position.x, nodeX3y2.position.y + sizeBotao.height + distanciaEntreNodes))
        nodePrincipal.addChild(nodeX3y1)
        
        nodeX3y3 = gerarNodeInPosition(CGPointMake(nodeX3y2.position.x, nodeX3y2.position.y - sizeBotao.height - distanciaEntreNodes))
        nodePrincipal.addChild(nodeX3y3)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func gerarNodeInPosition(position:CGPoint) -> SKSpriteNode{
        var node = SKSpriteNode(color: UIColor.blackColor(), size: sizeBotao)
        node.position = position
        
        return node
    }
    
    
    func showPopUp(){
        self.runAction(SKAction.fadeAlphaTo(1, duration: 0.3))
    }
}
