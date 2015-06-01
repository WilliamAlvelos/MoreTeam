//
//  GameScene.swift
//  Store
//
//  Created by Lucca Marmion on 21/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit

class LojaScene: AbstractScene, SKPhysicsContactDelegate {
    
    var actionWait = SKAction.waitForDuration(2)
    var arrayDeFila : NSMutableArray = NSMutableArray()
    var addFuncionario : SKShapeNode?
    var removerFuncionario : SKShapeNode?
    var balcaoNodeArray : NSMutableArray = NSMutableArray()
    var posicaoFilaBalcao : CGPoint!
    var contadorFila : Int = 0
    var posicaoFila : CGPoint!
    var balcaoNode25 : SKSpriteNode!
    
    var totalClientes : NSInteger = 14
    
    var numeroNodes : NSInteger = 0
    
    var balcaoNode1 : SKSpriteNode!
    var balcaoNode2 : SKSpriteNode!
    var balcaoNode3 : SKSpriteNode!
    
    var quadrado1 : SKShapeNode!
    var quadrado2 : SKShapeNode!
    var quadrado3 : SKShapeNode!
    
    var porta1 : SKShapeNode!

    var singleton:Singleton!
    
    override func didMoveToView(view: SKView) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    
    func gerarFila(posicao : CGPoint, qtdClientesVar : NSInteger) -> FilaLoja {
        
        var fila = FilaLoja(size: CGSizeMake(50, nodePrincipal.size.height), varMarketing: 0, qtdClientes: qtdClientesVar)
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
        singleton = Singleton.sharedInstance
        singleton.delegate = self
        
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
        
        
        
        
        ///--- Primeiro Balcao --------
        arrayDeFila.addObject(gerarFila(posicaoFila,qtdClientesVar: totalClientes))
        singleton.nVendedores++
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
        
        let acaoAndar = SKAction.moveByX(0, y: 300, duration: 6)
        let acaoApagar = SKAction.removeFromParent()
        
        var bodyA = contact.bodyA.node!
        var bodyB = contact.bodyB.node!
        
        if(bodyA.name == "quadrado" && bodyB.name == "clienteNode"){
            
            
            bodyB.runAction(SKAction.waitForDuration(3), completion: { () -> Void in
                bodyA.position.x = bodyA.position.x + 40
                self.physicsWorld.gravity = CGVectorMake(0.0, 0.0);
                bodyB.runAction(SKAction.moveByX(0, y: 40, duration: 0.4), completion: { () -> Void in
                    bodyA.position.x = 0
                    bodyB.runAction(SKAction.waitForDuration(0.1), completion: { () ->    Void in
                        self.physicsWorld.gravity = CGVectorMake(0.0, 0.2);
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
                bodyA.runAction(SKAction.moveByX(0, y: 40, duration: 0.4), completion: { () -> Void in
                    bodyB.position.x = 0
                    bodyA.runAction(SKAction.waitForDuration(0.1), completion: { () ->    Void in
                        self.physicsWorld.gravity = CGVectorMake(0.0, 0.2);
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
                if contadorFila < 2  {
                    println("addFuncionario")
                    posicaoFila.x = posicaoFila.x + 200
                    arrayDeFila.addObject(gerarFila(posicaoFila, qtdClientesVar:  totalClientes))
                    contadorFila++
                    singleton.nVendedores++
                    
                    for fila in arrayDeFila {
                        
                        var filaA = fila as! FilaLoja
                        filaA.varQtdClientes = totalClientes / arrayDeFila.count
                    }
                    
                }
                
            }else if nodeName == "removerFuncionario" {
                if contadorFila > 0  {
                    println("removerFuncionario")
                    posicaoFila.x = posicaoFila.x - 200
                    println(arrayDeFila.count)
                    arrayDeFila.lastObject?.removeFromParent()
                    arrayDeFila.removeObjectAtIndex(contadorFila)
                    contadorFila--
                    singleton.nVendedores--
                }
                
                for fila in arrayDeFila {
                    
                    var filaA = fila as! FilaLoja
                    filaA.varQtdClientes = totalClientes / arrayDeFila.count
                }
                
            }
            
            
        }
        
    }
    
    
    
    override func update(currentTime: CFTimeInterval) {
        
    }
    
    
}

