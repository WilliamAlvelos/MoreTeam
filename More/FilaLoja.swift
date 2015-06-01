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
    //    var trabalhadorNode : SKSpriteNode?
    var trabalhadorNode : SKShapeNode?
    var contadorNodes : Int = 0
    var andarNode : CGFloat = 900
    var foregroundNode = SKSpriteNode()
    var quantidadeNodes : Int = 0;
    var randTimer : NSTimeInterval!
    var quadrado1 : SKShapeNode!
    
    var linha1 : SKShapeNode!
    var linha2 : SKShapeNode!
    
    let CollisionNodeCliente     : UInt32 = 0x1 << 1
    let CollisionNodeBalcao : UInt32 = 0x1 << 2
    let CollisionQuadrado : UInt32 = 0x1 << 3
    
    
//    let acaoAndar = SKAction.moveByX(0, y: 700, duration: 1)
    let acaoAndar = SKAction.moveTo(CGPoint(x: 0, y: 30), duration: 3)
    
    var varQtdClientes : Int!
    
    init(size : CGSize, varMarketing : Int, qtdClientes : Int)
    {
        super.init(texture: nil, color: nil, size: size)
        
        gerarQuadrado()
        addlinha()
        
        self.varQtdClientes = qtdClientes
        
        println(self.varQtdClientes)
        
        //trabalhadorNode = SKSpriteNode(imageNamed: "funcionario")
        trabalhadorNode = SKShapeNode(circleOfRadius: CGFloat(20))
        trabalhadorNode?.fillColor = UIColor.blueColor()
        trabalhadorNode!.position = CGPoint(x: -110, y: size.height / 20)
        trabalhadorNode!.name = "trabalhadorNode"
        self.addChild(trabalhadorNode!)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func gerarQuadrado() {
        quadrado1 = SKShapeNode(rectOfSize: CGSize(width: 20, height: 1))
        quadrado1!.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 20, height: 1))
        quadrado1!.physicsBody?.contactTestBitMask = 0
        
        quadrado1!.position = CGPointMake(0, 30)
        quadrado1!.physicsBody?.dynamic = false
        quadrado1!.name = "quadrado"
        quadrado1.physicsBody?.pinned = true
        quadrado1!.physicsBody!.mass = 0
        quadrado1!.physicsBody?.restitution = 0
        self.addChild(quadrado1!)
    }
    
    func iniciarFila() {
        
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("addCliente"), userInfo: nil, repeats: true)
        
    }
    
    
    func addlinha() {
        linha1 = SKShapeNode(rectOfSize: CGSize(width: 1, height: size.height))
        linha1!.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 1, height: size.height))
        linha1.position = CGPointMake(-17.5, 0)
        linha1.physicsBody!.pinned = true
        linha1.physicsBody!.mass = 300000
        linha1.physicsBody?.dynamic = true
        self.addChild(linha1)
        
        linha2 = SKShapeNode(rectOfSize: CGSize(width: 1, height: size.height))
        linha2!.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 1, height: size.height))
        linha2.position = CGPointMake(17.5, 0)
        linha2.physicsBody!.pinned = true
        linha2.physicsBody!.mass = 300000
        linha2.physicsBody?.dynamic = true
        self.addChild(linha2)
    }
    
    
    func addCliente() {
        
        
        var clienteNode = SKShapeNode(rectOfSize: CGSize(width: 20, height: 20))
        clienteNode.fillColor = UIColor.blackColor()
        
        clienteNode.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 30, height: 30))
        //        clienteNode.
        clienteNode.position = CGPoint(x: 0, y: -size.height)
        clienteNode.physicsBody?.dynamic = true
        clienteNode.physicsBody?.restitution = 0
        clienteNode.physicsBody!.mass = 300
        clienteNode.physicsBody!.categoryBitMask = CollisionNodeCliente
        clienteNode.physicsBody!.contactTestBitMask =
        CollisionNodeCliente
        clienteNode.physicsBody?.allowsRotation = false
        
        
        clienteNode.name = "clienteNode"
        clienteNode.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 100))
        
        if(self.children.count - 4 < varQtdClientes) {
            self.addChild(clienteNode)
            quantidadeNodes++
            
        }
        
        
    }
    
}