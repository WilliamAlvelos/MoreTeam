//
//  GameScene.swift
//  Store
//
//  Created by Lucca Marmion on 21/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit
import CoreData

class LojaScene: AbstractScene, SKPhysicsContactDelegate {
    
    
    //Arrays
    var arrayPortas : Array<PortaNode> = Array()
    var arrayBalcao : Array<BalcaoNode> = Array()
    var arrayDeFila : NSMutableArray = NSMutableArray()
    
    var actionMove = SKAction.moveByX(0, y: 120, duration: 1.2)
    var actionMoveUp = SKAction.moveByX(0, y: 400, duration: 4)
    var actionMoveSair = SKAction.moveByX(0, y: 100, duration: 1)
    
    var contadorFila : Int = 0
    var posicaoFila = CGPointMake(-100, 0)
    var totalClientes : NSInteger = 6
    
    //------------- Actions ----------------------
    var andarArray = Array<SKTexture>()
    var andarArray2 = Array<SKTexture>()
    
    var arrayPosicoes : Array<Int> = [-100, 100, 300]
    
    var actionWait = SKAction.waitForDuration(4)
    
    var andarAnimacao : SKAction!
    
    var andarAnimacao2 : SKAction!
    var andarAnimacaoGroup : SKAction!
    var andarAnimacaoGroup2 : SKAction!
    var sairAnimacaoGroup : SKAction!
    var andarUmPoucoAnimacaGroup: SKAction!
    //----------------------------------------
    
    var lojaData:NSManagedObject!
    
    var singleton:Singleton!
    
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    
    
    func gerarFila(posicao : Int, qtdClientesVar : NSInteger, fila: NSInteger) -> FilaLoja {
        
        var fila = FilaLoja(size: CGSizeMake(50, nodePrincipal.size.height), varMarketing: 0, qtdClientes: qtdClientesVar, fila : fila)
        fila.position = CGPoint(x: posicao, y: 0)
        nodePrincipal.addChild(fila)
        fila.iniciarFila()
        
        return fila
    }
    
    
    init(loja:NSManagedObject ,size: CGSize) {
        
        super.init(size: size)
        
        //World Physics
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVectorMake(0.0, 0.0)
        
        //Buttons
        showBackButton()
        addBotoesDespedirContratar()
        funcaoAnimacaoCliente()
        
        //Singleton
        singleton = Singleton.sharedInstance
        singleton.delegate = self
        
        //BackGround NodePrincipal
        nodePrincipal.texture = SKTexture(imageNamed: "Store-57")
        
        lojaData = loja
        var numFuncionarios = loja.valueForKey("qtdFuncionario") as! Int
        
        self.contadorFila = numFuncionarios
        
        for var i = 0; i < contadorFila; i++
        {
            arrayDeFila.addObject(gerarFila(arrayPosicoes[i],qtdClientesVar: totalClientes, fila: i))
            posicaoFila.x = posicaoFila.x + 200
        }
        
        //Add Balcao
        var balcaoPosition = -250
        
        for i in 0 ... 2
        {
            var balcao = BalcaoNode()
            balcao.position = CGPoint(x: balcaoPosition, y: 100)
            balcaoPosition += 200
            nodePrincipal.addChild(balcao)
            arrayBalcao.append(balcao)
            
        }
        
        //Add Porta
        var doorPosition = -200
        
        for i in 0 ... 2
        {
            var porta = PortaNode()
            porta.position = CGPoint(x: doorPosition, y: 265)
            doorPosition += 200
            nodePrincipal.addChild(porta)
            arrayPortas.append(porta)
        }
        
        
    }
    
    //---------------------------------------------------------------
    func funcaoAnimacaoCliente() {
        
        for i in 2 ... 22
        {
            andarArray.append(SKTexture(imageNamed: "consumer-\(i)"))
        }
        
        for i in 2 ... 8
        {
            andarArray2.append(SKTexture(imageNamed: "consumer-\(i)"))
        }
        
        andarAnimacao = SKAction.repeatAction(SKAction.animateWithTextures(andarArray, timePerFrame: 0.1), count: 3)
        andarAnimacao2 = SKAction.animateWithTextures(andarArray2, timePerFrame: 0.1)
        //
        andarAnimacaoGroup = SKAction.group([andarAnimacao, actionMoveUp])
        sairAnimacaoGroup = SKAction.group([andarAnimacao2, actionMoveSair])
        andarUmPoucoAnimacaGroup = SKAction.group([andarAnimacao2, actionMove])
    }
    //---------------------------------------------------------------
    
    override func touchedButtonWithName(buttonName: String) {
        
        switch(buttonName){
            
        case "addFuncionario":
            if contadorFila < 3  {
                arrayDeFila.addObject(gerarFila(arrayPosicoes[contadorFila], qtdClientesVar:  totalClientes, fila: contadorFila))
                singleton.nVendedores++
                contadorFila++
            }
            
            break
            
        case "removerFuncionario":
            if contadorFila > 0  {
                arrayDeFila.lastObject?.removeFromParent()
                arrayDeFila.removeObjectAtIndex(contadorFila - 1)
                contadorFila--
                singleton.nVendedores--
            }
            
            break
            
        default:
            break
        }
        
        modificarClientesPorFila()
    }
    
    //---------------------------------------------------------------
    
    func didEndContact(contact: SKPhysicsContact) {
        var bodyA = contact.bodyA.node!
        var bodyB = contact.bodyB.node!
        
        if(bodyA.name == "cliente" && bodyB.name == "cliente"){
            bodyA.runAction(andarUmPoucoAnimacaGroup, withKey: "move")
            bodyB.runAction(andarUmPoucoAnimacaGroup, withKey: "move")
        }
        else if(bodyA.name == "clienteBalcao" && bodyB.name == "cliente"){
            bodyB.runAction(andarUmPoucoAnimacaGroup, withKey: "move")
        }
        else if(bodyB.name == "clienteBalcao" && bodyA.name == "cliente"){
            bodyA.runAction(andarUmPoucoAnimacaGroup, withKey: "move")
        }
        
    }
    
    //---------------------------------------------------------------
    
    func didBeginContact(contact: SKPhysicsContact) {
        var bodyA = contact.bodyA.node!
        var bodyB = contact.bodyB.node!
        
        if(bodyA.name == "trabalhadorNode" && bodyB.name == "cliente") {
            contatoBalcaoComCliente(bodyA, bodyB: bodyB)
        }
        else if(bodyA.name == "cliente" && bodyB.name == "trabalhadorNode") {
            contatoBalcaoComCliente(bodyB, bodyB: bodyA)
        }
            
        else if(bodyA.name == "clienteBalcao" && bodyB.name == "cliente")
        {
            setarClienteTexture(bodyB)
            bodyB.removeAllActions()
        }
        else if(bodyB.name == "clienteBalcao" && bodyA.name == "cliente")
        {
            setarClienteTexture(bodyA)
            bodyA.removeAllActions()
        }
            
        else
        {
            if(bodyB.actionForKey("move") == nil)
            {
                setarClienteTexture(bodyB)
                bodyB.removeAllActions()
            }
            if(bodyA.actionForKey("move") == nil)
            {
                setarClienteTexture(bodyA)
                bodyA.removeAllActions()
                
            }
        }
        
    }
    
    //---------------------------------------------------------------
    
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
                lojaData.setValue(contadorFila, forKey: "qtdFuncionario")
                myDelegate?.backToWorld()
                lojaData = nil
            }
        }
    }
    
    //---------------------------------------------------------------
    
    func setarClienteTexture(cliente : SKNode)
    {
        var cliente = cliente as! ClienteNode
        cliente.texture = SKTexture(imageNamed: "consumer-1")
    }
    
    //---------------------------------------------------------------
    
    func addBotoesDespedirContratar() {
        
        var btContratarTrabalhador = ButtonNode(startImageName: "wireframe-07", touchImageName: "wireframe-12", buttonName: "addFuncionario")
        btContratarTrabalhador.position = CGPointMake(0, 200)
        btContratarTrabalhador.delegate = self
        nodeLatBotoes.addChild(btContratarTrabalhador)
        
        var btDespedirTrablhador = ButtonNode(startImageName: "employee01", touchImageName: "wireframe-11", buttonName: "removerFuncionario")
        btDespedirTrablhador.position = CGPointMake(0, 0)
        btDespedirTrablhador.delegate = self
        nodeLatBotoes.addChild(btDespedirTrablhador)
        
    }
    
    //---------------------------------------------------------------
    
    func modificarClientesPorFila() {
        
        for fila in arrayDeFila {
            var filaA = fila as! FilaLoja
            filaA.varQtdClientes = totalClientes / arrayDeFila.count
        }
        
    }
    
    //---------------------------------------------------------------
    
    func contatoBalcaoComCliente(bodyA : SKNode, bodyB : SKNode) {
        
        var cliente = bodyB as! ClienteNode
        var fila = cliente.fila
        
        var trabalhadorFila = bodyA as! TrabalhadorNode
        
        cliente.texture = SKTexture(imageNamed: "consumer-1")
                
        trabalhadorFila.iniciarAnimacao()
        
        bodyB.removeAllActions()
        bodyB.name = "clienteBalcao"
        
        bodyB.runAction(actionWait, completion: { () -> Void in
            bodyB.physicsBody?.dynamic = false
            
            self.arrayBalcao[fila].iniciarAnimacao()
            
            bodyB.runAction(self.sairAnimacaoGroup, completion: { () -> Void in
                
                self.arrayPortas[fila].abrirPorta()
                
                bodyB.runAction(self.andarAnimacaoGroup, completion: { () -> Void in
                    bodyB.removeAllActions()
                    bodyB.removeFromParent()
                    
                })
                
            })
            
            
        })
        
    }
    
}

