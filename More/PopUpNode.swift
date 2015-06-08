//
//  PopUpNode.swift
//  More
//
//  Created by Felipe Costa Nascimento on 6/2/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit

class PopUpNode: SKSpriteNode {
    //CONSTANTE
    let sizeBotao = CGSizeMake(70, 100)
    
    //NODE QUE RECEBE TODOS OS OUTROS NODES ADICIONADOS
    var nodePrincipal:SKShapeNode!
    
    //LABELS
    var lblTitulo:SKLabelNode!
    private var lblLowCost:SKLabelNode!
    private var lblAverage:SKLabelNode!
    private var lblAboveAverage:SKLabelNode!
    
    //BOTÕES
    var btLowCost1K:SKSpriteNode!
    var btLowCost10K:SKSpriteNode!
    var btLowCost100K:SKSpriteNode!
    
    var btAverage1K:SKSpriteNode!
    var btAverage10K:SKSpriteNode!
    var btAverage100K:SKSpriteNode!
    
    var btAboveAverage1K:SKSpriteNode!
    var btAboveAverage10K:SKSpriteNode!
    var btAboveAverage100K:SKSpriteNode!
    
    
    
    
    
    
    
    init(size:CGSize){
        super.init(texture: nil, color: SKColor(red: 0, green: 0, blue: 0, alpha: 0.5), size: size)
        
        self.alpha = 0
        
        var principalSize = CGSizeMake(500, 650)
        nodePrincipal = SKShapeNode(path: CGPathCreateWithRoundedRect(CGRectMake(-principalSize.width/2, -principalSize.height/2, principalSize.width, principalSize.height), 20, 20, nil))
        nodePrincipal.fillColor = UIColor(red: 57/255, green: 114/255, blue: 201/255, alpha: 1)
        nodePrincipal.strokeColor = nodePrincipal.fillColor
//        nodePrincipal = SKSpriteNode(color: UIColor.whiteColor(), size: CGSizeMake(self.size.width / 2, self.size.height / 1.2))
//        nodePrincipal.color = UIColor(red: 57/255, green: 114/255, blue: 201/255, alpha: 1)
        self.addChild(nodePrincipal)

        
        var distanciaEntreNodes:CGFloat = 20
        
        //ADICIONA NODES DA PRIMEIRA FILEIRA
        btLowCost1K = gerarNodeInPosition(CGPointMake(-sizeBotao.width - distanciaEntreNodes, 120))
        nodePrincipal.addChild(btLowCost1K)
        
        btLowCost10K = gerarNodeInPosition(CGPointMake(0, btLowCost1K.position.y))
        nodePrincipal.addChild(btLowCost10K)
        
        btLowCost100K = gerarNodeInPosition(CGPointMake(sizeBotao.width + distanciaEntreNodes, btLowCost1K.position.y))
        nodePrincipal.addChild(btLowCost100K)
        
        
        //ADICIONA NODES DA SEGUNDA FILEIRA
        btAverage1K = gerarNodeInPosition(CGPointMake(btLowCost1K.position.x, btLowCost1K.position.y - sizeBotao.height - 70))
        nodePrincipal.addChild(btAverage1K)
        
        btAverage10K = gerarNodeInPosition(CGPointMake(0, btAverage1K.position.y))
        nodePrincipal.addChild(btAverage10K)
        
        btAverage100K = gerarNodeInPosition(CGPointMake(btLowCost100K.position.x, btAverage1K.position.y))
        nodePrincipal.addChild(btAverage100K)
        
        
        //ADICIONA NODES DA TERCEIRA FILEIRA
        btAboveAverage1K = gerarNodeInPosition(CGPointMake(btLowCost1K.position.x, btAverage1K.position.y - sizeBotao.height - 70))
        nodePrincipal.addChild(btAboveAverage1K)
        
        btAboveAverage10K = gerarNodeInPosition(CGPointMake(0, btAboveAverage1K.position.y))
        nodePrincipal.addChild(btAboveAverage10K)
        
        btAboveAverage100K = gerarNodeInPosition(CGPointMake(btAverage100K.position.x, btAboveAverage1K.position.y))
        nodePrincipal.addChild(btAboveAverage100K)
        
        inicializarLabels()
    }
    
    
    private func inicializarLabels(){
        lblTitulo = SKLabelNode(fontNamed: "Saniretro")
        lblTitulo.text = "HIRE EMPLOYEE"
        lblTitulo.fontSize = 70
        lblTitulo.fontColor = UIColor.whiteColor()
        lblTitulo.position = CGPointMake(0, nodePrincipal.frame.size.height / 2 - 90)
        nodePrincipal.addChild(lblTitulo)
        
        lblLowCost = SKLabelNode(fontNamed: "Saniretro")
        lblLowCost.text = "LOW-COST"
        lblLowCost.fontColor = UIColor.whiteColor()
        lblLowCost.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        lblLowCost.position = CGPointMake(btLowCost1K.position.x - sizeBotao.width / 2, lblTitulo.position.y - 50)
        nodePrincipal.addChild(lblLowCost)
        
        lblAverage = SKLabelNode(fontNamed: "Saniretro")
        lblAverage.text = "AVERAGE"
        lblAverage.fontColor = UIColor.whiteColor()
        lblAverage.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        lblAverage.position = CGPointMake(btLowCost1K.position.x - sizeBotao.width / 2, lblLowCost.position.y - 170)
        nodePrincipal.addChild(lblAverage)
        
        lblAboveAverage = SKLabelNode(fontNamed: "Saniretro")
        lblAboveAverage.text = "ABOVE AVERAGE"
        lblAboveAverage.fontColor = UIColor.whiteColor()
        lblAboveAverage.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        lblAboveAverage.position = CGPointMake(btLowCost1K.position.x - sizeBotao.width / 2, lblAverage.position.y - 170)
        nodePrincipal.addChild(lblAboveAverage)
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
