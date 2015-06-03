//
//  GameScene.swift
//  Store
//
//  Created by Lucca Marmion on 21/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit

class LojaScene: AbstractScene, SKPhysicsContactDelegate {
    
    var actionWait = SKAction.waitForDuration(5)
    var actionWaitPorta = SKAction.waitForDuration(2)
    
    
    var actionMove = SKAction.moveByX(0, y: 120, duration: 1.2)
    var actionMoveUp = SKAction.moveByX(0, y: 150, duration: 1.5)
    var actionMoveSair = SKAction.moveByX(0, y: 100, duration: 1)
    
    var arrayDeFila : NSMutableArray = NSMutableArray()
    
    
    
    //Adicionar e Remover Funcionarios
    var addFuncionario : SKShapeNode?
    var removerFuncionario : SKShapeNode?
    
    var portaAbrir : SKSpriteNode!
    
    var contadorFila : Int = 0
    var posicaoFila : CGPoint!
    
    var totalClientes : NSInteger = 4
    
    var balcaoNode1 : SKSpriteNode!
    var balcaoNode2 : SKSpriteNode!
    var balcaoNode3 : SKSpriteNode!
    
    var abrirPortaArray = Array<SKTexture>()
    var fecharPortaArray = Array<SKTexture>()
    var balcaoArray = Array<SKTexture>()
    
    var animacaoPortaAbrir : SKAction!
    var animacaoPortaFechar : SKAction!
    var balcaoAnimacao : SKAction!
    
    var porta1 : SKSpriteNode!
    var porta2 : SKSpriteNode!
    var porta3 : SKSpriteNode!
    
    var singleton:Singleton!
    
    override func didMoveToView(view: SKView) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    
    func gerarFila(posicao : CGPoint, qtdClientesVar : NSInteger) -> FilaLoja {
        
        var fila = FilaLoja(size: CGSizeMake(50, nodePrincipal.size.height), varMarketing: 0, qtdClientes: qtdClientesVar, fila : contadorFila)
        fila.position = posicao
        nodePrincipal.addChild(fila)
        fila.iniciarFila()
        
        return fila
    }
    
    
    func gerarPorta1() {
        
    }
    
    
    override init(size: CGSize) {
        super.init(size: size)
        
        balcaoArray.append(SKTexture(imageNamed: "cashier-02"))
        balcaoArray.append(SKTexture(imageNamed: "cashier-03"))
        balcaoArray.append(SKTexture(imageNamed: "cashier-04"))
        
        balcaoAnimacao = SKAction.animateWithTextures(balcaoArray, timePerFrame: 1)
        
        for i in 16 ... 20
        {
            abrirPortaArray.append(SKTexture(imageNamed: "door-C-\(i)"))
        }
        
        for i in 20 ... 26
        {
            fecharPortaArray.append(SKTexture(imageNamed: "door-C-\(i)"))
        }
        
        animacaoPortaAbrir = SKAction.animateWithTextures(abrirPortaArray, timePerFrame: 0.1)
        animacaoPortaFechar = SKAction.animateWithTextures(fecharPortaArray, timePerFrame: 0.1)
        
        nodePrincipal.texture = SKTexture(imageNamed: "Store-57")
        
        showBackButton()
        singleton = Singleton.sharedInstance
        singleton.delegate = self
        
        posicaoFila = CGPointMake(-100, 0)
        
        
        
        //Basalcao 1
        balcaoNode1 = SKSpriteNode(imageNamed: "cashier-01")
        balcaoNode1!.position = CGPoint(x: -250, y: 100)
        balcaoNode1!.zPosition = 1
        nodePrincipal.addChild(balcaoNode1)
        
        balcaoNode2 = SKSpriteNode(imageNamed: "cashier-01")
        balcaoNode2!.position = CGPoint(x: -50, y: 100)
        balcaoNode2!.zPosition = 1
        nodePrincipal.addChild(balcaoNode2)
        
        balcaoNode3 = SKSpriteNode(imageNamed: "cashier-01")
        balcaoNode3!.position = CGPoint(x: 150, y: 100)
        balcaoNode3!.zPosition = 1
        nodePrincipal.addChild(balcaoNode3)
        
        //244 235 198
        
        //F4EBC6
        
        
        
        //Add Porta
        porta1 = SKSpriteNode(imageNamed: "door-C-15.png")
        porta1!.position = CGPoint(x: -200, y: 265)
        porta1!.zPosition = 1
        nodePrincipal.addChild(porta1)
        
        porta2 = SKSpriteNode(imageNamed: "door-C-15.png")
        porta2!.position = CGPoint(x: 10, y: 265)
        porta2!.zPosition = 1
        nodePrincipal.addChild(porta2)
        
        porta3 = SKSpriteNode(imageNamed: "door-C-15.png")
        porta3!.position = CGPoint(x: 205, y: 265)
        porta3!.zPosition = 1
        nodePrincipal.addChild(porta3)
        
        
        
        
        ///--- Primeiro Balcao --------
        arrayDeFila.addObject(gerarFila(posicaoFila,qtdClientesVar: totalClientes))
        singleton.nVendedores++
        nodePrincipal.color = UIColor.whiteColor()
        
        //Fisica Mundo
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVectorMake(0.0, 0.0);
        
        //Add Funcionario
        addFuncionario = SKShapeNode(circleOfRadius: CGFloat(30))
        addFuncionario!.name = "addFuncionario"
        addFuncionario?.fillColor = UIColor.blackColor()
        addFuncionario!.position = CGPoint(x: 0, y: 0)
        nodeLatBotoes.addChild(addFuncionario!)
        
        //Remover Funcionario
        removerFuncionario = SKShapeNode(circleOfRadius: CGFloat(30))
        removerFuncionario!.name = "removerFuncionario"
        removerFuncionario?.fillColor = UIColor.blueColor()
        removerFuncionario?.position = CGPoint(x: 0, y: -100)
        nodeLatBotoes.addChild(removerFuncionario!)
        
    }
    
    
    func didEndContact(contact: SKPhysicsContact) {
        var bodyA = contact.bodyA.node!
        var bodyB = contact.bodyB.node!
        
        
        if(bodyA.name == "cliente" && bodyB.name == "cliente"){
            bodyA.runAction(actionMove, withKey: "move")
            bodyB.runAction(actionMove, withKey: "move")
            
            
        }else if(bodyA.name == "clienteBalcao" && bodyB.name == "cliente"){
            bodyB.runAction(actionMove, withKey: "move")
            
            
        }else if(bodyB.name == "clienteBalcao" && bodyA.name == "cliente"){
            bodyA.runAction(actionMove, withKey: "move")
        }
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        var bodyA = contact.bodyA.node!
        var bodyB = contact.bodyB.node!
        
        if(bodyA.name == "quadrado" && bodyB.name == "cliente"){
            
            var teste = bodyB as! ClienteNode
            var a = teste.fila
            
            bodyB.removeAllActions()
            bodyB.name = "clienteBalcao"
            
            bodyB.runAction(actionWait, completion: { () -> Void in
                bodyB.physicsBody?.dynamic = false
                
                bodyB.runAction(self.actionMoveSair, completion: { () -> Void in
                    //
                    
                    if(a == 0)
                    {
                        self.porta1.runAction(SKAction.sequence([self.animacaoPortaAbrir, self.actionWaitPorta, self.animacaoPortaFechar]))
                    } else if(a == 1) {
                        self.porta2.runAction(SKAction.sequence([self.animacaoPortaAbrir, self.actionWaitPorta, self.animacaoPortaFechar]))
                    } else if(a == 2) {
                        self.porta3.runAction(SKAction.sequence([self.animacaoPortaAbrir, self.actionWaitPorta, self.animacaoPortaFechar]))
                    }
                    
                    
                    
                    bodyB.runAction(self.actionMoveUp, completion: { () -> Void in
                        bodyB.removeAllActions()
                        bodyB.removeFromParent()
                        
                    })
                    
                })
                
                
            })
            
            
        }else if(bodyB.name == "quadrado" && bodyA.name == "cliente"){
            
            var bodyA = contact.bodyA.node!
            var bodyB = contact.bodyB.node!
            
            if(bodyB.name == "quadrado" && bodyA.name == "cliente"){
                
                var teste = bodyA as! ClienteNode
                var a = teste.fila
                
                println(a)
                
                bodyA.removeAllActions()
                bodyA.name = "clienteBalcao"
                
                bodyA.runAction(actionWait, completion: { () -> Void in
                    bodyA.physicsBody?.dynamic = false
                    
                    bodyA.runAction(self.actionMoveSair, completion: { () -> Void in
                        //
                        
                        if(a == 0)
                        {
                            self.porta1.runAction(SKAction.sequence([self.animacaoPortaAbrir, self.actionWaitPorta, self.animacaoPortaFechar]))
                        } else if(a == 1) {
                            self.porta2.runAction(SKAction.sequence([self.animacaoPortaAbrir, self.actionWaitPorta, self.animacaoPortaFechar]))
                        } else if(a == 2) {
                            self.porta3.runAction(SKAction.sequence([self.animacaoPortaAbrir, self.actionWaitPorta, self.animacaoPortaFechar]))
                        }
                        
                        bodyA.runAction(self.actionMoveUp, completion: { () -> Void in
                            
                            bodyA.removeAllActions()
                            bodyA.removeFromParent()
                            
                        })
                        
                    })
                    
                    
                })
                
                
            }
            else if(bodyA.name == "clienteBalcao" && bodyB.name == "cliente"){
                bodyB.removeAllActions()
                
                
            }else if(bodyB.name == "clienteBalcao" && bodyA.name == "cliente"){
                bodyA.removeAllActions()
                
            }else if((bodyB.actionForKey("move")) == nil && bodyB.name != "clienteBalcao"){
                bodyB.removeAllActions()
            } else if((bodyA.actionForKey("move")) == nil && bodyA.name != "clienteBalcao"){
                bodyA.removeAllActions()
            }
            
        }
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(self)
            let touchedNode = nodeAtPoint(location)
            let nodeName: String? = touchedNode.name
            
            if(nodeName == "voltar") {
                
                for node in arrayDeFila {
                    var pause = node as! FilaLoja
                    pause.timer.invalidate()
                    
                }
                
                myDelegate?.backToWorld()
                
                
            }
            
            if nodeName == "addFuncionario" {
                if contadorFila < 2  {
                    println("addFuncionario")
                    posicaoFila.x = posicaoFila.x + 200
                    contadorFila++
                    arrayDeFila.addObject(gerarFila(posicaoFila, qtdClientesVar:  totalClientes))
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

