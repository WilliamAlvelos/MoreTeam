//
//  GameScene.swift
//  Store
//
//  Created by Lucca Marmion on 21/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit

class LojaScene: SKScene, SKPhysicsContactDelegate {
    
    var balcaoNode : SKSpriteNode?
    var trabalhadorNode : SKSpriteNode?
    var filaNodeUm : SKShapeNode?
    var filaNodeDois : SKShapeNode?
    var clienteNode : SKSpriteNode?
    var sprites : NSMutableArray = NSMutableArray()
    var contadorNodes : Int = 0
    var andarNode : CGFloat = 900
    var foregroundNode = SKSpriteNode()
    var quantidadeNodes : Int = 0
    var contador : Int = 0
    var flagNodes : Int = 0
    
    //Acoes
    
    var actionWait = SKAction.waitForDuration(0.8)
    var actionMoveLeft = SKAction.moveByX(-70, y: 0, duration: 0.5)
    var actionMoveDown = SKAction.moveToY(-700, duration: 2)
    let acaoAndar = SKAction.moveByX(0, y: 900, duration: 9);
    //let acaoAndar : CGFloat = 900

    
    let CollisionNodeCliente     : UInt32 = 0x1 << 1
    let CollisionNodeBalcao : UInt32 = 0x1 << 2
    
    override func didMoveToView(view: SKView) {
        
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        
        super.init(size: size)
        
        addChild(foregroundNode)

        
        //Fisica Mundo
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVectorMake(0.0, 0.0);
    
        //Add Balcao 1
        balcaoNode = SKSpriteNode(imageNamed: "balcaoNode")
        balcaoNode!.position = CGPoint(x: size.width / 3.9, y: size.height / 1.8)
        var tamanho = CGSize(width: balcaoNode!.size.width, height: balcaoNode!.size.height + 30)
        balcaoNode!.physicsBody = SKPhysicsBody(rectangleOfSize: tamanho)
        balcaoNode!.physicsBody!.dynamic = false
        balcaoNode!.physicsBody!.categoryBitMask = CollisionNodeBalcao
        balcaoNode!.name = "balcaoNode"
        
        addChild(balcaoNode!)
        
        //Add Trabalhador 1
        trabalhadorNode = SKSpriteNode(imageNamed: "trabalhadorNode")
        trabalhadorNode!.position = CGPoint(x: size.width / 2.4, y: size.height / 1.8)
        addChild(trabalhadorNode!)
        
        
        var acaoAndar : CGFloat = 900
        
        runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock(addCliente),
                SKAction.waitForDuration(1.0)
                ])
            ))
    }
    
    func addCliente() {
        
        
//        let acaoEspera = SKAction.waitForDuration(2)
        
        //var clienteNode = SKSpriteNode(imageNamed: "clienteNode")
        var clienteNode = SKShapeNode(rectOfSize: CGSize(width: 20, height: 20))
//        clienteNode.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(30))
        clienteNode.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 30, height: 30))
        clienteNode.position = CGPoint(x: size.width / 4.0, y: size.height / 70)
        clienteNode.physicsBody?.dynamic = true
        clienteNode.physicsBody!.categoryBitMask = CollisionNodeCliente
        clienteNode.physicsBody!.contactTestBitMask =
        CollisionNodeCliente | CollisionNodeBalcao
        clienteNode.name = "clienteNode"
        clienteNode.removeAllActions()
        //clienteNode.runAction(SKAction.sequence([acaoAndar, acaoEspera]))
        
//        andarNode = andarNode - 60
        
        if(quantidadeNodes <= 20 && clienteNode.name == "clienteNode") {
        foregroundNode.addChild(clienteNode)
        quantidadeNodes++
        clienteNode.runAction(acaoAndar, withKey: "acaoAndarEntrando")
        }
        
       // clienteNode.runAction(SKAction.moveByX(0, y: acaoAndar, duration: 2), completion: { () -> Void in
        
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        var bodyA = contact.bodyA.node!
        var bodyB = contact.bodyB.node!
        
        
        if(bodyA.name == "clienteNode" && bodyB.name == "clienteNode"){
            //bodyB.removeAllActions()
            
            
            bodyB.runAction(SKAction.moveByX(0, y: 15, duration: 1), withKey: "nodeAndando")

            bodyA.runAction(SKAction.moveByX(0, y: 15, duration: 1), withKey: "nodeAndando")
            //bodyA.runAction(SKAction.moveToY(self.balcaoNode!.position.y + 60, duration: 1))
            //bodyB.runAction(SKAction.moveToY(self.balcaoNode!.position.y + 60, duration: 1))
        }
        else if(bodyA.name == "clienteNodeBalcao" && bodyB.name == "clienteNode")
        {
            bodyB.runAction(SKAction.moveToY(self.balcaoNode!.position.y + 15, duration: 3))
        }
        else if(bodyA.name == "clienteNode" && bodyB.name == "clienteNodeBalcao")
        {
            bodyA.runAction(SKAction.moveToY(self.balcaoNode!.position.y + 15, duration: 3))
            
        }
    }

    
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        
        var bodyA = contact.bodyA.node!
        var bodyB = contact.bodyB.node!
        
        if(bodyA.name == "balcaoNode" && bodyB.name == "clienteNode"){
            
            println(contador++)
            bodyB.removeAllActions()

            bodyB.name = "clienteNodeBalcao"
            println("encostou no balcão")

            bodyB.runAction(SKAction.sequence([actionWait, actionMoveLeft]), completion: { () -> Void in

            bodyB.runAction(self.actionMoveDown, completion: { () -> Void in
            bodyB.removeAllActions()
            bodyB.removeFromParent()
            self.quantidadeNodes--

    
                })
            })
            
            
        }
        
        else if(bodyA.name == "clienteNode" && bodyB.name == "clienteNode"){
            
            if bodyB.actionForKey("nodeAndando") == nil {
            bodyB.removeAllActions()
            }
            
            if bodyA.actionForKey("nodeAndando") == nil {
            bodyA.removeAllActions()
            }
        }
        else if(bodyA.name == "clienteNodeBalcao" && bodyB.name == "clienteNode") {
            
           
            bodyB.removeAllActions()

        }
        else if(bodyA.name == "clienteNode" && bodyB.name == "clienteNodeBalcao")
        {
            bodyA.removeAllActions()
        }
    
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        for node in self.foregroundNode.children {
            
            let andar = SKAction.moveByX(0, y: 15, duration: 1)
            
            if !(node .hasActions()) {
                node.runAction(andar)
            }
            
        }
        
    }
}
