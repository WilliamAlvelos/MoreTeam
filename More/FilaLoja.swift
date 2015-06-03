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
    
    var linha1 : SKShapeNode!
    var linha2 : SKShapeNode!
    
    var timer : NSTimer!
    
    let CollisionNodeCliente     : UInt32 = 0x1 << 1
    let CollisionNodeBalcao : UInt32 = 0x1 << 2
    let CollisionQuadrado : UInt32 = 0x1 << 3
    
    var varQtdClientes : Int!
    
    init(size : CGSize, varMarketing : Int, qtdClientes : Int)
    {
        super.init(texture: nil, color: nil, size: size)
        
        gerarQuadrado()
//        addlinha()
        
        var fundo = SKSpriteNode(imageNamed: "retangulos-45")        //fundo.fillColor = UIColor.blackColor()
        fundo.position = CGPoint(x: -70, y: 335)
        fundo.zPosition = 5
        self.addChild(fundo)
        
        
        self.varQtdClientes = qtdClientes
        
        trabalhadorNode = SKSpriteNode(imageNamed: "worker_store-61")
        trabalhadorNode?.xScale = 0.5
        trabalhadorNode?.yScale = 0.5
        trabalhadorNode!.position = CGPoint(x: -160, y: size.height / 20)
        trabalhadorNode!.name = "trabalhadorNode"
        trabalhadorNode?.zPosition = 1
        self.addChild(trabalhadorNode!)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func gerarQuadrado() {
        quadrado1 = SKShapeNode(rectOfSize: CGSize(width: 20, height: 10))
        quadrado1!.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 40, height: 10))
        quadrado1.physicsBody!.categoryBitMask = CollisionNodeBalcao
        quadrado1!.position = CGPointMake(-70, 70)
        quadrado1!.physicsBody?.dynamic = true
        quadrado1!.name = "quadrado"
        quadrado1.physicsBody?.pinned = true
        quadrado1.physicsBody?.allowsRotation = false
        self.addChild(quadrado1!)
    }
    
    func iniciarFila() {
        
        
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("addCliente"), userInfo: nil, repeats: true)
        
    }
    
    
    func addlinha() {
        
        linha1 = SKShapeNode(rectOfSize: CGSize(width: 1, height: size.height - 500))
        linha1!.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 1, height: size.height))
        linha1.position = CGPointMake(-90.5, 0)
        linha1.physicsBody!.pinned = true
        linha1.physicsBody?.dynamic = true
        linha1.physicsBody?.allowsRotation = false
        self.addChild(linha1)
        
        linha2 = SKShapeNode(rectOfSize: CGSize(width: 1, height: size.height - 500))
        linha2!.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 1, height: size.height))
        linha2.position = CGPointMake(-50.5, 0)
        linha2.physicsBody!.pinned = true
        linha2.physicsBody?.dynamic = true
        linha2.physicsBody?.allowsRotation = false
        self.addChild(linha2)
    }
    
    
    func addCliente() {
        
        //var arrayConsumidor = ["consumer-01", "consumer-23", "consumer-45"]
        
        //var numRandom = random() % 3
        
        var arrayAndar = ["consumer-02","consumer-03","consumer-04","consumer-05","consumer-06","consumer-07","consumer-08","consumer-09","consumer-10","consumer-11","consumer-12","consumer-13","consumer-14","consumer-15","consumer-16","consumer-17","consumer-18","consumer-19","consumer-20","consumer-21","consumer-22"]
        
        var actionPassos = SKAction.animateWithTextures(arrayAndar, timePerFrame: 9)
        var acaoAndar = SKAction.moveByX(0, y: 1500, duration: 9)
        
        var action = SKAction.group([SKAction.repeatActionForever(actionPassos), acaoAndar])
        
        var clienteNode = SKSpriteNode(imageNamed: "consumer-01")
        clienteNode.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 30, height: 115))
        //        clienteNode.
        clienteNode.position = CGPoint(x: -50, y: -size.height - 400)
        clienteNode.physicsBody?.dynamic = true
        clienteNode.physicsBody!.categoryBitMask = CollisionNodeCliente
        clienteNode.physicsBody!.contactTestBitMask =
            CollisionNodeCliente | CollisionNodeBalcao
        clienteNode.name = "cliente"
        clienteNode.physicsBody?.allowsRotation = false
        
        
        if(self.children.count - 4 < varQtdClientes) {
            self.addChild(clienteNode)
            clienteNode.runAction(acaoAndar)
        }
        
        
    }
    
}