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
    
    var numeroNodes : NSInteger = 0
    
    var balcaoNode1 : SKSpriteNode!
    var balcaoNode2 : SKSpriteNode!
    var balcaoNode3 : SKSpriteNode!
    
    var quadrado1 : SKShapeNode!
    var quadrado2 : SKShapeNode!
    var quadrado3 : SKShapeNode!
    
    var porta1 : SKShapeNode!
    
    
    
    override func didMoveToView(view: SKView) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    
    
    func gerarFila(posicao : CGPoint) -> FilaLoja {
        
        var fila = FilaLoja(size: CGSizeMake(50, nodePrincipal.size.height), varMarketing: 0, qtdClientes: 14)
        fila.position = posicao
        nodePrincipal.addChild(fila)
        
        fila.iniciarFila()
        return fila
    }
    
    
    func gerarPorta1() {
        
    }
    
    
    override init(size: CGSize) {
        super.init(size: size)
        
        showBackButton()
        
        
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
        physicsWorld.gravity = CGVectorMake(0.0, 0.2);
        
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
        
        let acaoAndar = SKAction.moveByX(0, y: 600, duration: 6)
        let acaoApagar = SKAction.removeFromParent()
        
        var bodyA = contact.bodyA.node!
        var bodyB = contact.bodyB.node!
        
        if(bodyA.name == "quadrado" && bodyB.name == "clienteNode"){
            
            
            bodyB.runAction(SKAction.waitForDuration(3), completion: { () -> Void in
                bodyA.position.x = bodyA.position.x + 40
                self.physicsWorld.gravity = CGVectorMake(0.0, 0.0);
                bodyB.runAction(SKAction.moveByX(0, y: 100, duration: 1), completion: { () -> Void in
                    bodyA.position.x = 0
                    bodyB.runAction(SKAction.waitForDuration(0.0001), completion: { () ->    Void in
                        self.physicsWorld.gravity = CGVectorMake(0.0, 0.1);
                        self.numeroNodes++
                        println(self.numeroNodes)
                        bodyB.runAction(SKAction.sequence([acaoAndar, acaoApagar]))
                    })
                })
            })
            
            println("contado!")
        } else if bodyB.name == "quadrado" && bodyA.name == "clienteNode"
        {
            
            
            bodyA.runAction(SKAction.waitForDuration(3), completion: { () -> Void in
                bodyB.position.x = bodyA.position.x + 40
                self.physicsWorld.gravity = CGVectorMake(0.0, 0.0);
                bodyA.runAction(SKAction.moveByX(0, y: 100, duration: 1), completion: { () -> Void in
                    bodyB.position.x = 0
                    bodyA.runAction(SKAction.waitForDuration(0.0001), completion: { () ->    Void in
                        self.physicsWorld.gravity = CGVectorMake(0.0, 0.1);
                        self.numeroNodes++
                        println(self.numeroNodes)
                        bodyA.runAction(SKAction.sequence([acaoAndar, acaoApagar]))
                    })
                })
            })
            
            
        }
        
    }
    
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(self)
            let touchedNode = nodeAtPoint(location)
            let nodeName: String? = touchedNode.name
            
            if(nodeName == "voltar") {
                myDelegate?.backToWorld()
            }
            
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

