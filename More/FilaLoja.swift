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
    
    let CollisionNodeCliente     : UInt32 = 0x1 << 1
    let CollisionNodeBalcao : UInt32 = 0x1 << 2
    let CollisionQuadrado : UInt32 = 0x1 << 3

    
    let acaoAndar = SKAction.moveByX(0, y: 700, duration: 9)
    var varQtdClientes : Int!
    
    init(size : CGSize, varMarketing : Int, qtdClientes : Int)
    {
        super.init(texture: nil, color: nil, size: size)
        
        
        addQuadrado()
        
        
        self.varQtdClientes = qtdClientes
        
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
    
    
    func iniciarFila() {
        
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("addCliente"), userInfo: nil, repeats: true)
        
    }
    
    func addQuadrado() {
    
        quadrado1 = SKShapeNode(rectOfSize: CGSize(width: 20, height: 1))
        quadrado1!.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 20, height: 1))
        quadrado1!.physicsBody?.contactTestBitMask = 0
        
        quadrado1!.position = CGPointMake(0, 30)
        quadrado1!.physicsBody?.dynamic = true
        quadrado1!.name = "quadrado"
        quadrado1.physicsBody?.pinned = true
        //quadrado1!.fillColor = UIColor.blueColor()
        //quadrado1.physicsBody?.collisionBitMask = 0
        quadrado1!.physicsBody!.categoryBitMask = CollisionQuadrado
        quadrado1!.physicsBody!.contactTestBitMask = CollisionNodeCliente
        self.addChild(quadrado1!)
        

        
        
    }
    
    func addCliente() {
        
        
        var clienteNode = SKShapeNode(rectOfSize: CGSize(width: 20, height: 20))
        clienteNode.fillColor = UIColor.blackColor()
        
        clienteNode.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 30, height: 30))
        //        clienteNode.
        clienteNode.position = CGPoint(x: 0, y: -600)
        clienteNode.physicsBody?.dynamic = true
        clienteNode.physicsBody!.categoryBitMask = CollisionNodeCliente
        clienteNode.physicsBody!.contactTestBitMask =
            CollisionNodeCliente

        
        clienteNode.name = "clienteNode"
        clienteNode.removeAllActions()

        
        if(self.children.count < varQtdClientes) {
            self.addChild(clienteNode)
            quantidadeNodes++
            clienteNode.runAction(acaoAndar, withKey: "acaoAndarEntrando")
            
            
        }
   
            
    }
    
}