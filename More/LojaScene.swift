//
//  GameScene.swift
//  Store
//
//  Created by Lucca Marmion on 21/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit

class LojaScene: AbstractScene, SKPhysicsContactDelegate {
    
    var actionWait = SKAction.waitForDuration(3)
    var actionMoveLeft = SKAction.moveByX(-40, y: 0, duration: 0.5)
    var actionMoveDown = SKAction.moveToY(-700, duration: 2)
    var arrayDeFila : NSMutableArray = NSMutableArray()
    var addFuncionario : SKShapeNode?
    var removerFuncionario : SKShapeNode?
    var contadorFila : Int = 0
    var posicaoFila : CGPoint!
    
    override func didMoveToView(view: SKView) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    func gerarFila(posicao : CGPoint) -> FilaLoja {
        
        var fila = FilaLoja(size: CGSizeMake(nodePrincipal.size.width / 4, nodePrincipal.size.height), varMarketing: 0, qtdClientes: 6)
        fila.position = posicao
        nodePrincipal.addChild(fila)
        
        fila.iniciarFila()
        return fila
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        posicaoFila = CGPointMake(-200, 0)
        
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
        
        if(bodyA.name == "balcaoNode" && bodyB.name == "clienteNode"){
            
            bodyB.removeAllActions()
            
            bodyB.name = "clienteNodeBalcao"
            println("encostou no balcão")
            
            bodyB.runAction(SKAction.sequence([actionWait, actionMoveLeft]), completion: { () -> Void in
                
                bodyB.runAction(self.actionMoveDown, completion: { () -> Void in
                    bodyB.removeAllActions()
                    bodyB.removeFromParent()
                    
                    
                })
            })
            
            
        }
            
        else if(bodyA.name == "clienteNode" && bodyB.name == "clienteNode"){
            
            bodyB.removeAllActions()
            bodyA.removeAllActions()
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
        super.touchesBegan(touches, withEvent: event)
        
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(self)
            let touchedNode = nodeAtPoint(location)
            let nodeName: String? = touchedNode.name
            
            if nodeName == "addFuncionario" {
                if contadorFila < 3  {
                    println("addFuncionario")
                    posicaoFila.x = posicaoFila.x + 150
                    arrayDeFila.addObject(gerarFila(posicaoFila))
                    contadorFila++
                }
                
            }else if nodeName == "removerFuncionario" {
                if contadorFila > 0  {
                    println("removerFuncionario")
                    posicaoFila.x = posicaoFila.x - 150
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
        
        for position in arrayDeFila {
            for node in position.children {
                
                if node.name != "trabalhadorNode" && node.name != "balcaoNode" {
                    if !(node .hasActions())
                    {
                        node.runAction(SKAction.moveByX(0, y: 10, duration: 0.5))
                    }
                }
            }
        }
    }
    
}

