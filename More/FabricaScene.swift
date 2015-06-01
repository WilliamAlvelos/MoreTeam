//
//  Fabrica.swift
//  More
//
//  Created by William Alvelos on 21/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//


import UIKit
import SpriteKit
import CoreData


class FabricaScene: AbstractScene, SKPhysicsContactDelegate{
    
    var novoEsteira:Int = 0
    var novoEsteira1:Int = 0
    var novoEsteira2:Int = 0
    
    var frequencia:CGFloat = 0.0;
    
    
    let myLabel = SKLabelNode(fontNamed:"Heveltica")
    
    var trabalhador:Trabalhadores? = nil
    
    var trabalhadores = 0;
    
    var trabalhadoresLabel = 0;
    
    var yVar : CGFloat!
    
    var valorEsteira1 = 0
    
    var valorEsteira2 = 0
    
    var ultimoFuncionario:[SKNode] = []
    
    var demitirFuncionarios:[SKNode] = []
    
    var trabalhadoresEsteira1:UInt32 = 0
    
    var trabalhadoresEsteira2:UInt32 = 0
    
    var flagEsteira1 = 1
    
    var flagEsteira2 = 1
    
    
    var singleton = Singleton.sharedInstance
    
    

    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        showBackButton()
        
        singleton.delegate = self
        
        
        
        setDinheiro(singleton.dinheiro)
        
        trabalhadores = -1;
        
        trabalhadoresLabel = 0;
        
        let fundoFabrica = SKSpriteNode(imageNamed: "chao")
        fundoFabrica.xScale = 1.5
        fundoFabrica.yScale = 1.5
        fundoFabrica.zPosition = -1.0
        fundoFabrica.position = CGPointMake( 0,0)
        
        nodePrincipal.addChild(fundoFabrica);
        

        myLabel.text = NSString(format: "%d", trabalhadoresLabel) as String
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:0, y:300);
        
        let play = SKSpriteNode(imageNamed: "Play")
        play.xScale = 0.3
        play.yScale = 0.3
        play.position = CGPointMake(0,+100)
        play.name = "mais"
        
        let menos = SKSpriteNode(imageNamed: "menos")
        menos.xScale = 0.2
        menos.yScale = 0.2
        menos.position = CGPointMake(0 ,0)
        menos.name = "menos"

        let esteira = SKSpriteNode(imageNamed: "esteiraNode")
        esteira.xScale = 2.0
        esteira.yScale = 2.0
        esteira.position = CGPointMake(nodePrincipal.size.width/6 - 300 , 150)
        esteira.name = "esteira"
        esteira.zPosition = 0.5
        
        let esteira2 = SKSpriteNode(imageNamed: "esteiraNode")
        esteira2.xScale = 2.0
        esteira2.yScale = 2.0
        esteira2.position = CGPointMake(nodePrincipal.size.width/6 + 75, 150)
        esteira2.name = "esteira2"
        esteira2.zPosition = 0.5
        
        nodePrincipal.addChild(esteira2)
        nodePrincipal.addChild(esteira)
        nodeLatBotoes.addChild(play)
        nodeLateral.addChild(myLabel)
        nodeLatBotoes.addChild(menos)
    }
    
    
    func caixaProducao(){
        

        if(valorEsteira1 <= 0){
            let produto = SKSpriteNode(imageNamed: "produto_preto.jpg")
            
            produto.xScale = 0.05
            produto.yScale = 0.05
            
            yVar = 0
            
            produto.position = CGPoint(x:nodePrincipal.size.width/6 - 300 , y: -nodePrincipal.size.height/2)
            produto.zPosition = 3.0
            
            nodePrincipal.addChild(produto)
            
            valorEsteira1 += novoEsteira
            novoEsteira = 0
            
            let acaoAndar = SKAction.moveTo(CGPoint(x:nodePrincipal.size.width/6 - 300, y: nodePrincipal.size.height + 100), duration: NSTimeInterval(3.0))
            
            let acaoApagarNode = SKAction.removeFromParent()
            
            produto.runAction(SKAction.sequence([acaoAndar]), completion: { () -> Void in
                self.yVar = self.yVar + 60
                
            })
            produto.runAction(SKAction.waitForDuration(1.2 - (Double(self.valorEsteira1)/16)), completion: { () -> Void in
                self.runAction(SKAction.runBlock(self.caixaProducao))

                
            })
            
            
            produto.removeAllChildren()
        }
        else{
            let produto = SKSpriteNode(imageNamed: "produto.jpg")
            
            produto.xScale = 0.05
            produto.yScale = 0.05
            
            yVar = 0
            
            produto.position = CGPoint(x:nodePrincipal.size.width/6 - 300 , y:-nodePrincipal.size.height/2)
            produto.zPosition = 3.0
            
            nodePrincipal.addChild(produto)
            
            valorEsteira1 += novoEsteira
            novoEsteira = 0
            
            if(valorEsteira1 > 16){
                valorEsteira1 = 16
            }
            
            
            let acaoAndar = SKAction.moveTo(CGPoint(x:nodePrincipal.size.width/6 - 300, y: nodePrincipal.size.height + 100), duration: NSTimeInterval(3.0))
            
            let acaoApagarNode = SKAction.removeFromParent()
            
            produto.runAction(SKAction.sequence([acaoAndar]), completion: { () -> Void in
                self.yVar = self.yVar + 60
                
            })
            produto.runAction(SKAction.waitForDuration(1.2 - (Double(self.valorEsteira1)/16)), completion: { () -> Void in
                self.runAction(SKAction.runBlock(self.caixaProducao))
            })
            
            
            produto.removeAllChildren()
        }
    
    }
    
    func caixaProducaoEsteira2(){
        
        
        if(valorEsteira2 <= 0){
            let produto = SKSpriteNode(imageNamed: "produto_preto.jpg")
            
            produto.xScale = 0.05
            produto.yScale = 0.05
            
            yVar = 0
            
            produto.position = CGPoint(x:nodePrincipal.size.width/6+75 , y:-nodePrincipal.size.height/2)
            produto.zPosition = 3.0
            
            nodePrincipal.addChild(produto)
            
            valorEsteira2 += novoEsteira1
            novoEsteira1 = 0
            
            
            let acaoAndar = SKAction.moveTo(CGPoint(x:nodePrincipal.size.width/6+75, y: nodePrincipal.size.height + 100), duration: NSTimeInterval(3.0))
            
            let acaoApagarNode = SKAction.removeFromParent()
            
            produto.runAction(SKAction.sequence([acaoAndar]), completion: { () -> Void in
                self.yVar = self.yVar + 60
                
            })
            produto.runAction(SKAction.waitForDuration(1.2 - (Double(self.valorEsteira2)/16)), completion: { () -> Void in
                self.runAction(SKAction.runBlock(self.caixaProducaoEsteira2))
            })
            
            
            produto.removeAllChildren()
        }
        else{
            let produto = SKSpriteNode(imageNamed: "produto.jpg")
            
            produto.xScale = 0.05
            produto.yScale = 0.05
            
            yVar = 0
            
            produto.position = CGPoint(x:nodePrincipal.size.width/6+75, y:-nodePrincipal.size.height/2)
            produto.zPosition = 3.0
            
            nodePrincipal.addChild(produto)
            
            valorEsteira2 += novoEsteira1
            novoEsteira1 = 0
            
            if(valorEsteira2 > 16){
                valorEsteira2 = 16
            }
            
            
            
            let acaoAndar = SKAction.moveTo(CGPoint(x:nodePrincipal.size.width/6+75, y: self.nodePrincipal.size.height + 100), duration: NSTimeInterval(3.0))
            
            let acaoApagarNode = SKAction.removeFromParent()
            
            produto.runAction(SKAction.sequence([acaoAndar]), completion: { () -> Void in
                self.yVar = self.yVar + 60
                
            })
            produto.runAction(SKAction.waitForDuration(1.2 - (Double(self.valorEsteira2)/16)), completion: { () -> Void in
                self.runAction(SKAction.runBlock(self.caixaProducaoEsteira2))
            })
            
            
            produto.removeAllChildren()
        }
        
      
        
    }
    
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            var node = self.nodeAtPoint(location)
            
            
            NSLog("%d", valorEsteira1)
            
            NSLog("%d", valorEsteira2)
            
            if(node.name == "voltar"){
                myDelegate!.backToWorld()
            }
            
            
            if (node.name == "mais") {
                
                for demitir in demitirFuncionarios{
                    demitir.removeFromParent()
                }
                    
                if(singleton.dinheiro > NSInteger(singleton.precoFuncionario)){
                
                    singleton.addFuncionarios()
                    
                    if(trabalhadores == 1 || trabalhadores == 7 || trabalhadores == 13 || trabalhadores == 19){
                        trabalhadores++
                    }
                    
                    if(trabalhadores < 23){
                        if(trabalhadores == -1 && flagEsteira1 == 1){
                            runAction(SKAction.runBlock(caixaProducao))
                            flagEsteira1 = 0;
                        }
                        if(trabalhadores == 11 && flagEsteira2 == 1){
                            runAction(SKAction.runBlock(caixaProducaoEsteira2))
                            flagEsteira2 = 0
                        }
                        
                        trabalhadores++;
                        trabalhadoresLabel++;
                        let funcionario = SKSpriteNode(imageNamed: "funcionario")
                        funcionario.xScale = 0.1
                        funcionario.yScale = 0.1
                        funcionario.name = "funcionario"
                        
                        myLabel.text = NSString(format: "%d", trabalhadoresLabel) as String
                        
                        
                        if(trabalhadores <= 5){
                                var aux = trabalhadores;
                                var y:CGFloat = (CGFloat(aux)*100.0)+125.0
                                funcionario.position = CGPointMake(nodePrincipal.size.width/6 - 400, y-(nodePrincipal.size.width/2))
                        }
                        else if(trabalhadores >= 6 && trabalhadores < 12){
                            
                                var aux = trabalhadores - 6;
                                var y:CGFloat = (CGFloat(aux)*100.0)+125.0
                                funcionario.position = CGPointMake(nodePrincipal.size.width/6 - 200, y-(nodePrincipal.size.width/2))
                        }
                            
                        else if(trabalhadores >= 12 && trabalhadores < 18){
                                var aux = trabalhadores - 12;
                                var y:CGFloat = (CGFloat(aux)*100.0)+125.0
                                funcionario.position = CGPointMake(nodePrincipal.size.width/6 - 25, y-(nodePrincipal.size.width/2))
                        }

                        else{
                            var y:CGFloat = (CGFloat(trabalhadores-18)*100)+125.0
                            funcionario.position = CGPointMake(nodePrincipal.size.width/6 + 175, y-(nodePrincipal.size.width/2))
                    
                        }
                        
                        if(funcionario.position.x < nodePrincipal.size.height/2 - 300){
                            novoEsteira++;
                            
                            nodePrincipal.addChild(funcionario);
                            
                            ultimoFuncionario.append(funcionario)
                        }
                            
                        else{
                            novoEsteira1++;
                            
                            nodePrincipal.addChild(funcionario);
                            
                            ultimoFuncionario.append(funcionario)
                        }

                        
                    }
                    
                }
            }
            
            if(node.name == "menos"){
                
                
                if(trabalhadores == 1 || trabalhadores == 7 || trabalhadores == 13 || trabalhadores == 19){
                    trabalhadores--
                }
                
                
                if(trabalhadores > 0){
                    trabalhadores--
                    trabalhadoresLabel--
                    
                    myLabel.text = NSString(format: "%d", trabalhadoresLabel) as String
                    
                    excluirFuncionario(node as! SKSpriteNode)
                    
                    singleton.demitirFuncionario()
                }
                
            }
            
            if(node.name == "funcionario"){
                
                setMensagem("funcionario")
                
            }
            
        }
    }

    
    func excluirFuncionario(funcionario:SKSpriteNode) {
            
            if(ultimoFuncionario.last!.position.x < nodePrincipal.size.height/2 - 300){
                novoEsteira--;
            }
                
            else{
                novoEsteira1--;
            }
        
        ultimoFuncionario.removeLast().removeFromParent()
        
    }
    
    

    

}
