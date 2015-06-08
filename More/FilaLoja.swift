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
        
        //        addlinha()
        
        self.varFila = fila
        
        var fundo = SKSpriteNode(imageNamed: "retangulos-45")        //fundo.fillColor = UIColor.blackColor()
        fundo.position = CGPoint(x: -70, y: 335)
        fundo.zPosition = 5
        self.addChild(fundo)
        
        
        self.varQtdClientes = qtdClientes
        
        trabalhadorNode = SKSpriteNode(imageNamed: "worker_store-61")
        trabalhadorNode?.xScale = 0.5
        trabalhadorNode?.yScale = 0.5
        trabalhadorNode!.position = CGPoint(x: -160, y: size.height / 20)
        trabalhadorNode?.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 70, height: 5), center: CGPoint(x: 110, y: 40))
        trabalhadorNode!.name = "trabalhadorNode"
        trabalhadorNode!.zPosition = 2
        trabalhadorNode!.physicsBody?.pinned = true
        trabalhadorNode!.physicsBody?.dynamic = false
        trabalhadorNode!.physicsBody?.allowsRotation = false
        trabalhadorNode!.physicsBody!.categoryBitMask = CollisionNodeBalcao
        trabalhadorNode!.physicsBody?.contactTestBitMask = CollisionNodeCliente
        
        self.addChild(trabalhadorNode!)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    func gerarQuadrado() {
    //        quadrado1 = SKShapeNode(rectOfSize: CGSize(width: 20, height: 10))
    //        quadrado1!.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 40, height: 10))
    //        quadrado1.physicsBody!.categoryBitMask = CollisionNodeBalcao
    //        quadrado1!.position = CGPointMake(-50, 70)
    //        quadrado1!.physicsBody?.dynamic = true
    //        quadrado1!.name = "quadrado"
    //        quadrado1.physicsBody?.pinned = true
    //        quadrado1.physicsBody?.allowsRotation = false
    //        self.addChild(quadrado1!)
    //    }
    //
    func iniciarFila() {
        
        
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("addCliente"), userInfo: nil, repeats: true)
        
    }
    
    
    func addlinha() {
        
        linha1 = SKShapeNode(rectOfSize: CGSize(width: 1, height: size.height - 800))
        linha1!.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 1, height: size.height + 800))
        linha1.position = CGPointMake(-70.5, 0)
        linha1.physicsBody!.pinned = true
        linha1.physicsBody?.dynamic = true
        linha1.physicsBody?.allowsRotation = false
        self.addChild(linha1)
        
        linha2 = SKShapeNode(rectOfSize: CGSize(width: 1, height: size.height - 800))
        linha2!.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 1, height: size.height + 800))
        linha2.position = CGPointMake(-31.5, 0)
        linha2.physicsBody!.pinned = true
        linha2.physicsBody?.dynamic = true
        linha2.physicsBody?.allowsRotation = false
        self.addChild(linha2)
    }
    
    
    func addCliente() {
        
        
        
        var acaoAndar = SKAction.moveByX(0, y: 1800 + size.height, duration: 20)
        
        var clienteNode = ClienteNode(size: CGSize(width: 60, height: 117), varFila: varFila)
        
        clienteNode.position = CGPoint(x: -50, y: -size.height - 1500)
        
        var animacaoAndar = SKAction.repeatActionForever(SKAction.animateWithTextures(andarArray, timePerFrame: 0.05))
        
        var groupAnimacao = SKAction.group([acaoAndar, animacaoAndar])
        
        if(self.children.count - 4 < varQtdClientes) {
            
            if clienteNode.name != nil {
                self.addChild(clienteNode)
                clienteNode.runAction(groupAnimacao)
            }
        }
        
        
    }
    
}