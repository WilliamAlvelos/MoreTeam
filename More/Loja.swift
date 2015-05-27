//
//  Loja.swift
//  test
//
//  Created by Felipe Costa Nascimento on 5/26/15.
//  Copyright (c) 2015 Felipe Costa Nascimento. All rights reserved.
//

import SpriteKit

class Loja: AbstractScene, SKPhysicsContactDelegate{
    
    
    let balcaoCategory:UInt32 = 0x1 << 0;
    let clienteCategory:UInt32 = 0x1 << 1;
    
    
    var vtClientes:NSMutableArray = NSMutableArray()
    var nodeBalcao:SKSpriteNode!
    
    
    
    override init(size: CGSize) {
        super.init(size: size)
        

        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        nodePrincipal.color = UIColor.whiteColor()
        nodeLateral.color = UIColor.lightGrayColor()
        
        nodeBalcao = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(200, 50))
        nodeBalcao.position = CGPointMake(0, nodePrincipal.size.height / 3)
        nodeBalcao.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(200, 70))
        nodeBalcao.physicsBody?.categoryBitMask = balcaoCategory
        nodeBalcao.physicsBody?.contactTestBitMask = clienteCategory
        nodeBalcao.physicsBody?.dynamic = false
        nodePrincipal.addChild(nodeBalcao)
        
        
        
        var  timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("addCliente"), userInfo: nil, repeats: true)
        
        
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func addCliente(){
        
        if(vtClientes.count > 5){
            return
        }
        
        var nodeCliente = SKSpriteNode(color: UIColor.orangeColor(), size: CGSizeMake(50, 50))
        var corpoCliente = nodeCliente.size
        corpoCliente.height += 10
        corpoCliente.width += 10
        nodeCliente.physicsBody = SKPhysicsBody(rectangleOfSize: corpoCliente, center: CGPointZero)
        nodeCliente.physicsBody?.categoryBitMask = clienteCategory
        nodeCliente.physicsBody?.contactTestBitMask = balcaoCategory | clienteCategory
        //nodeCliente.physicsBody?.dynamic = true
        nodeCliente.position = CGPointMake(0, -nodePrincipal.size.height / 2)
        nodePrincipal.addChild(nodeCliente)
        vtClientes.addObject(nodeCliente)
        
        nodeCliente.runAction(SKAction.moveToY(nodeBalcao.position.y, duration: 2))
    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        var bodyA = contact.bodyA
        var bodyB = contact.bodyB
        
        if(bodyA.categoryBitMask == balcaoCategory && bodyB.categoryBitMask == clienteCategory){
            var cliente = bodyB.node!
            
            cliente.removeAllActions()
            var actionWait = SKAction.waitForDuration(1.5)
            var actionMoveLeft = SKAction.moveByX(-70, y: 0, duration: 0.5)
            var actionMoveDown = SKAction.moveToY(-nodePrincipal.size.height, duration: 2)
            
            
            println("encostou no balcão")
            
            cliente.runAction(SKAction.sequence([actionWait, actionMoveLeft]), completion: { () -> Void in
                
                
                cliente.runAction(actionMoveDown, completion: { () -> Void in
                    cliente.removeAllActions()
                    cliente.removeFromParent()
                    
                })
                self.vtClientes.removeObject(cliente)
                
                
            })
            
        
        }else{
            
            
            
            var cliente = bodyB.node as! SKSpriteNode
            
            cliente.removeAllActions()
            
            
            
            
        }
    }
    
    
    func didEndContact(contact: SKPhysicsContact) {
        var bodyA = contact.bodyA
        var bodyB = contact.bodyB
        
        
        if(bodyA.categoryBitMask == clienteCategory && bodyB.categoryBitMask == clienteCategory){
            var cliente = bodyB.node!
            cliente.runAction(SKAction.moveToY(self.nodeBalcao.position.y, duration: 1))
        
        }
    }
    
    
}