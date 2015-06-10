//
//  FilaLoja.swift
//  More
//
//  Created by Lucca Marmion on 27/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit

class FilaLoja: SKSpriteNode {
    
    var balcaoNode : SKSpriteNode?
    var trabalhadorNode : SKSpriteNode?
    
    var quadrado1 : SKShapeNode!
    
    var varFila : Int!
    
    var linha1 : SKShapeNode!
    var linha2 : SKShapeNode!
    
    var timer : NSTimer!
    
    var andarArray = Array<SKTexture>()
    
    
    let CollisionNodeCliente     : UInt32 = 0x1 << 1
    let CollisionNodeBalcao : UInt32 = 0x1 << 2
    let CollisionQuadrado : UInt32 = 0x1 << 3
    
    var varQtdClientes : Int!
    
    init(size : CGSize, varMarketing : Int, qtdClientes : Int, fila : Int)
    {
        super.init(texture: nil, color: nil, size: size)
        
        for i in 2 ... 22
        {
            andarArray.append(SKTexture(imageNamed: "consumer-\(i)"))
        }
        
        self.varFila = fila
        
        var fundo = SKSpriteNode(imageNamed: "retangulos-45")
        fundo.position = CGPoint(x: -70, y: 335)
        fundo.zPosition = 5
        self.addChild(fundo)
        
        self.varQtdClientes = qtdClientes
        
        trabalhadorNode = TrabalhadorNode()
        trabalhadorNode!.position = CGPoint(x: -160, y: size.height / 20)
        
        self.addChild(trabalhadorNode!)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func iniciarFila() {
        
        
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("addCliente"), userInfo: nil, repeats: true)
        
    }

    
    func addCliente() {
        
        var acaoAndar = SKAction.moveByX(0, y: 1800 + size.height, duration: 10)
        
        var clienteNode = ClienteNode(size: CGSize(width: 60, height: 117), varFila: varFila)
        
        clienteNode.position = CGPoint(x: -50, y: -size.height - 1500)
        
        var animacaoAndar = SKAction.repeatActionForever(SKAction.animateWithTextures(andarArray, timePerFrame: 0.05))
        
        var groupAnimacao = SKAction.group([acaoAndar, animacaoAndar])
        
        if(self.children.count - 2 < varQtdClientes) {
                self.addChild(clienteNode)
                clienteNode.runAction(groupAnimacao)
        }
        
        
    }
    
}