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
    
    let CollisionNodeCliente     : UInt32 = 0x1 << 1
    let CollisionNodeBalcao : UInt32 = 0x1 << 2
    
    let acaoAndar = SKAction.moveByX(0, y: 900, duration: 9)
    var varQtdClientes : Int!
    
    init(size : CGSize, varMarketing : Int, qtdClientes : Int)
    {
        super.init(texture: nil, color: nil, size: size)
        
        
        
        self.varQtdClientes = qtdClientes
        
        balcaoNode = SKSpriteNode(imageNamed: "balcaoNode")
        balcaoNode!.position = CGPoint(x: 0, y: 100)
        var tamanho = CGSize(width: balcaoNode!.size.width, height: balcaoNode!.size.height + 30)
        balcaoNode!.physicsBody = SKPhysicsBody(rectangleOfSize: tamanho)
        balcaoNode!.physicsBody!.dynamic = false
        balcaoNode!.physicsBody!.categoryBitMask = CollisionNodeBalcao
        balcaoNode!.name = "balcaoNode"
        self.addChild(balcaoNode!)
        
        //trabalhadorNode = SKSpriteNode(imageNamed: "funcionario")
        trabalhadorNode = SKShapeNode(circleOfRadius: CGFloat(20))
        trabalhadorNode?.fillColor = UIColor.blueColor()
        trabalhadorNode!.position = CGPoint(x: 0, y: size.height / 4)
        trabalhadorNode!.name = "trabalhadorNode"
        self.addChild(trabalhadorNode!)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func iniciarFila() {
        
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("addCliente"), userInfo: nil, repeats: true)
        
    }
    
    func addCliente() {
        
        
        var clienteNode = SKShapeNode(rectOfSize: CGSize(width: 20, height: 20))
        clienteNode.fillColor = UIColor.blackColor()
        
        clienteNode.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 30, height: 30))
        //        clienteNode.
        clienteNode.position = CGPoint(x: 0, y: -self.size.height / 3 )
        clienteNode.physicsBody?.dynamic = true
        clienteNode.physicsBody!.categoryBitMask = CollisionNodeCliente
        clienteNode.physicsBody!.contactTestBitMask =
            CollisionNodeCliente | CollisionNodeBalcao
        clienteNode.name = "clienteNode"
        clienteNode.removeAllActions()
        
        if(self.children.count < varQtdClientes) {
            self.addChild(clienteNode)
            quantidadeNodes++
            clienteNode.runAction(acaoAndar, withKey: "acaoAndarEntrando")
        }
        
        
    }
    
}