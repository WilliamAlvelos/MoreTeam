//
//  GameScene.swift
//  Store
//
//  Created by Lucca Marmion on 21/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit

class LojaScene: AbstractScene, SKPhysicsContactDelegate {
    
    var actionWait = SKAction.waitForDuration(1)
    var actionMoveUp1 = SKAction.moveByX(0, y: 35, duration: 2)
    var actionMoveUp2 = SKAction.moveByX(0, y: 500, duration: 10)
//    var actionMoveDown = SKAction.moveToY(-700, duration: 2)
    var arrayDeFila : NSMutableArray = NSMutableArray()
    var addFuncionario : SKShapeNode?
    var removerFuncionario : SKShapeNode?
    var balcaoNodeArray : NSMutableArray = NSMutableArray()
    var posicaoFilaBalcao : CGPoint!
    var contadorFila : Int = 0
    var posicaoFila : CGPoint!
    var balcaoNode25 : SKSpriteNode!
    
    var balcaoNode1 : SKSpriteNode!
    var balcaoNode2 : SKSpriteNode!
    var balcaoNode3 : SKSpriteNode!
    
    var quadrado1 : SKShapeNode!
    var quadrado2 : SKShapeNode!
    var quadrado3 : SKShapeNode!
    

    
    override func didMoveToView(view: SKView) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    
    func andarCliente() {
        
        for position in arrayDeFila {
            for node in position.children {
                
                if node.name != "trabalhadorNode" && node.name != "quadrado" {
                    if !(node .hasActions())
                    {
                        node.runAction(SKAction.moveByX(0, y: 60, duration: 2))
                    }
                }
            }
            
        }
    }
    
    func gerarFila(posicao : CGPoint) -> FilaLoja {
        
        var fila = FilaLoja(size: CGSizeMake(50, nodePrincipal.size.height), varMarketing: 0, qtdClientes: 14)
        fila.position = posicao
        nodePrincipal.addChild(fila)
        
        fila.iniciarFila()
        return fila
    }
    
//    func gerarBalcao(balcaoNode24 : SKSpriteNode) {
//        
//        balcaoNode25 = balcaoNode24
//        
//        balcaoNode25 = SKSpriteNode(imageNamed: "balcaoNode")
//        balcaoNode25!.position = CGPoint(x: 0, y: 100)
//        balcaoNode25!.physicsBody!.dynamic = false
//        balcaoNode25!.name = "balcaoNode"
//        
//    }
    
    
    override init(size: CGSize) {
        super.init(size: size)
    
        var timerAndar = NSTimer.scheduledTimerWithTimeInterval(6, target: self, selector: Selector("andarCliente"), userInfo: nil, repeats: true)
        
        posicaoFila = CGPointMake(-100, 0)
        
        //Balcao 1
        balcaoNode1 = SKSpriteNode(imageNamed: "balcaoNode")
        balcaoNode1!.position = CGPoint(x: -200, y: 50)
        nodePrincipal.addChild(balcaoNode1)
        
        balcaoNode2 = SKSpriteNode(imageNamed: "balcaoNode")
        balcaoNode2!.position = CGPoint(x: 0, y: 50)
        nodePrincipal.addChild(balcaoNode2)
        
        balcaoNode3 = SKSpriteNode(imageNamed: "balcaoNode")
        balcaoNode3!.position = CGPoint(x: 200, y: 50)
        nodePrincipal.addChild(balcaoNode3)
    
        
               
        
        ///-----------
        arrayDeFila.addObject(gerarFila(posicaoFila))
        nodePrincipal.color = UIColor.whiteColor()
        
        //Fisica Mundo
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVectorMake(0.0, 0.0);
        
        addFuncionario = SKShapeNode(circleOfRadius: CGFloat(30))
        addFuncionario!.name = "addFuncionario"
        addFuncionario?.fillColor = UIColor.blackColor()
        addFuncionario!.position = CGPoint(x: 0, y: 0)
        nodeLatBotoes.addChild(addFuncionario!)
        
        removerFuncionario = SKShapeNode(circleOfRadius: CGFloat(30))
        removerFuncionario!.name = "removerFuncionario"
        removerFuncionario?.fillColor = UIColor.blueColor()
        removerFuncionario?.position = CGPoint(x: 0, y: -100)
        nodeLatBotoes.addChild(removerFuncionario!)
        
    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        
        var bodyA = contact.bodyA.node!
        var bodyB = contact.bodyB.node!
        

        
        if(bodyA.name == "quadrado" && bodyB.name == "clienteNode"){
            
            bodyB.removeAllActions()
            
            bodyB.physicsBody?.dynamic = false
            bodyA.physicsBody?.dynamic = false
            
            bodyB.name = "clienteNodeBalcao"
            println("encostou no balcão")
            
            bodyB.runAction(SKAction.sequence([actionWait, actionMoveUp1]), completion: { () -> Void in
                
                bodyA.physicsBody?.dynamic = true
                
                    bodyB.runAction(self.actionMoveUp2, completion: { () -> Void in
                        bodyB.removeAllActions()
                        bodyB.removeFromParent()
                        
                    })
                
            })
            
            
        }
            
        else if(bodyA.name == "clienteNode" && bodyB.name == "clienteNode"){
            println("colidiu clinte com cliente")
            bodyB.removeAllActions()
            bodyA.removeAllActions()
        }
        else if(bodyA.name == "clienteNodeBalcao" && bodyB.name == "clienteNode") {
            
            println("colidiu clinte com cliente balcão")
            bodyB.removeAllActions()
            
        }
        else if(bodyA.name == "clienteNode" && bodyB.name == "clienteNodeBalcao")
        {
            println("colidiu clinte balcao com cliente")
            bodyA.removeAllActions()
        }
        
    }
    

    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(self)
            let touchedNode = nodeAtPoint(location)
            let nodeName: String? = touchedNode.name
            
            if nodeName == "addFuncionario" {
                if contadorFila < 3  {
                    println("addFuncionario")
                    posicaoFila.x = posicaoFila.x + 200
                    arrayDeFila.addObject(gerarFila(posicaoFila))
                    contadorFila++
                }
                
            }else if nodeName == "removerFuncionario" {
                if contadorFila > 0  {
                    println("removerFuncionario")
                    posicaoFila.x = posicaoFila.x - 200
                    //                arrayDeFila.lastObject?.removeFromParent()
                    println(arrayDeFila.count)
                    arrayDeFila.lastObject?.removeFromParent()
                    arrayDeFila.removeObjectAtIndex(contadorFila)
                    contadorFila--
                }
                
                
            }
            
            
        }
        
    }
    

    
    override func update(currentTime: CFTimeInterval) {
        
//        for position in arrayDeFila {
//            for node in position.children {
//                
//                if node.name != "trabalhadorNode" && node.name != "quadrado" {
//                    if !(node .hasActions())
//                    {
//                        node.runAction(SKAction.moveByX(0, y: 20, duration: 0.5))
//                    }
//                }
//            }
        //}
    }
    
    
}

