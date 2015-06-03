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


class FabricaScene: AbstractScene, SKPhysicsContactDelegate, EsteiraNodeDelegate{
    
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
    
    var esteira: SKNode!
    
    var ultimoFuncionario:[SKNode] = []
    
    var demitirFuncionarios:[SKNode] = []
    
    var trabalhadoresEsteira1:UInt32 = 0
    
    var trabalhadoresEsteira2:UInt32 = 0
    
    var flagEsteira1 = 1
    
    var flagEsteira2 = 1
    
    var esteira2:EsteiraNode = EsteiraNode()
    
    var esteira1:EsteiraNode = EsteiraNode()
    
    var singleton = Singleton.sharedInstance
    
    
    init(y:Int, size: CGSize){
        
        super.init(size: size)
        
        nodePrincipal.color = UIColor.lightGrayColor()
        
        esteira1.delegate = self
        
        esteira2.delegate = self
        
        esteira1.position.x = nodePrincipal.size.width/6 + 75
        
        esteira2.position.x = nodePrincipal.size.width/6 - 300
        
        nodePrincipal.addChild(esteira1)
        
        nodePrincipal.addChild(esteira2)
        
        esteira1.velocidade = 1.5
        
        esteira2.velocidade = 1.5
        
        esteira1.moveEsteira()
        
        esteira2.moveEsteira()
        
        trabalhadoresLabel = y + 1
        
        trabalhadores = y
        
        
        
        myLabel.text = NSString(format: "%d", trabalhadoresLabel) as String
        
        var x = y
        
        var i = -1;
        
        while(i < x){
        
            i++;
            if(i == 2 || i == 8 || i == 14 || i == 20){
                i++
            }
            
            if(i < 23){
                if(i == 0 && flagEsteira1 == 1){
                    runAction(SKAction.runBlock(caixaProducao))
                    flagEsteira1 = 0;
                }
                if(i == 12 && flagEsteira2 == 1){
                    runAction(SKAction.runBlock(caixaProducaoEsteira2))
                    flagEsteira2 = 0
                }
                
                
                var workerTexture1 = SKTexture(imageNamed: "worker-61")
                workerTexture1.filteringMode = SKTextureFilteringMode.Nearest
                var workerTexture2 = SKTexture(imageNamed: "worker-62")
                workerTexture2.filteringMode = SKTextureFilteringMode.Nearest
                var workerTexture3 = SKTexture(imageNamed: "worker-63")
                workerTexture3.filteringMode = SKTextureFilteringMode.Nearest
                var workerTexture4 = SKTexture(imageNamed: "worker-64")
                workerTexture4.filteringMode = SKTextureFilteringMode.Nearest
                var workerTexture5 = SKTexture(imageNamed: "worker-65")
                workerTexture5.filteringMode = SKTextureFilteringMode.Nearest
                var workerTexture6 = SKTexture(imageNamed: "worker-66")
                workerTexture6.filteringMode = SKTextureFilteringMode.Nearest
                var workerTexture7 = SKTexture(imageNamed: "worker-67")
                workerTexture7.filteringMode = SKTextureFilteringMode.Nearest
                var workerTexture8 = SKTexture(imageNamed: "worker-68")
                workerTexture8.filteringMode = SKTextureFilteringMode.Nearest
                var workerTexture9 = SKTexture(imageNamed: "worker-69")
                workerTexture9.filteringMode = SKTextureFilteringMode.Nearest
                var workerTexture10 = SKTexture(imageNamed: "worker-70")
                workerTexture10.filteringMode = SKTextureFilteringMode.Nearest
                
                var workerTexture11 = SKTexture(imageNamed: "worker-71")
                workerTexture11.filteringMode = SKTextureFilteringMode.Nearest
                var workerTexture12 = SKTexture(imageNamed: "worker-72")
                workerTexture12.filteringMode = SKTextureFilteringMode.Nearest
                var workerTexture13 = SKTexture(imageNamed: "worker-73")
                workerTexture13.filteringMode = SKTextureFilteringMode.Nearest
                var workerTexture14 = SKTexture(imageNamed: "worker-74")
                workerTexture14.filteringMode = SKTextureFilteringMode.Nearest
                var workerTexture15 = SKTexture(imageNamed: "worker-75")
                workerTexture15.filteringMode = SKTextureFilteringMode.Nearest
                var workerTexture16 = SKTexture(imageNamed: "worker-76")
                workerTexture16.filteringMode = SKTextureFilteringMode.Nearest
                var workerTexture17 = SKTexture(imageNamed: "worker-77")
                workerTexture17.filteringMode = SKTextureFilteringMode.Nearest
                var workerTexture18 = SKTexture(imageNamed: "worker-78")
                workerTexture18.filteringMode = SKTextureFilteringMode.Nearest
                var workerTexture19 = SKTexture(imageNamed: "worker-79")
                workerTexture19.filteringMode = SKTextureFilteringMode.Nearest
                var workerTexture20 = SKTexture(imageNamed: "worker-80")
                workerTexture20.filteringMode = SKTextureFilteringMode.Nearest
                
                
                var workerTexture21 = SKTexture(imageNamed: "worker-81")
                workerTexture21.filteringMode = SKTextureFilteringMode.Nearest
                var workerTexture22 = SKTexture(imageNamed: "worker-82")
                workerTexture22.filteringMode = SKTextureFilteringMode.Nearest
                var workerTexture23 = SKTexture(imageNamed: "worker-83")
                workerTexture23.filteringMode = SKTextureFilteringMode.Nearest
                var workerTexture24 = SKTexture(imageNamed: "worker-84")
                workerTexture24.filteringMode = SKTextureFilteringMode.Nearest
                var workerTexture25 = SKTexture(imageNamed: "worker-85")
                workerTexture25.filteringMode = SKTextureFilteringMode.Nearest
                var workerTexture26 = SKTexture(imageNamed: "worker-86")
                workerTexture26.filteringMode = SKTextureFilteringMode.Nearest
                var workerTexture27 = SKTexture(imageNamed: "worker-87")
                workerTexture27.filteringMode = SKTextureFilteringMode.Nearest
                var workerTexture28 = SKTexture(imageNamed: "worker-88")
                workerTexture28.filteringMode = SKTextureFilteringMode.Nearest
                var workerTexture29 = SKTexture(imageNamed: "worker-89")
                workerTexture29.filteringMode = SKTextureFilteringMode.Nearest
                var workerTexture30 = SKTexture(imageNamed: "worker-90")
                workerTexture30.filteringMode = SKTextureFilteringMode.Nearest
                
                
                var anim = SKAction.animateWithTextures([workerTexture1, workerTexture2, workerTexture3, workerTexture4, workerTexture5, workerTexture6, workerTexture7, workerTexture8, workerTexture9, workerTexture10, workerTexture11, workerTexture12, workerTexture13, workerTexture14, workerTexture15, workerTexture16, workerTexture17, workerTexture18, workerTexture19, workerTexture20, workerTexture21, workerTexture22, workerTexture23, workerTexture24, workerTexture25, workerTexture26, workerTexture27, workerTexture28, workerTexture29, workerTexture30], timePerFrame: 0.02)
                var animacao = SKAction.repeatActionForever(anim)
                
                let funcionario = SKSpriteNode(texture: workerTexture1)
                funcionario.setScale(2.0)
                funcionario.runAction(animacao)
                funcionario.xScale = 0.5
                funcionario.yScale = 0.5
                funcionario.zPosition = 2.0
                funcionario.physicsBody?.allowsRotation = false
                funcionario.name = "funcionario"

                
                
                if(i <= 5){
                    var aux = i;
                    var y:CGFloat = (CGFloat(aux)*100.0)+125.0
                    funcionario.position = CGPointMake(nodePrincipal.size.width/6 - 375, y-(nodePrincipal.size.width/2))
                }
                else if(i >= 6 && i < 12){
                    
                    funcionario.xScale = -0.5
                    var aux = i - 6;
                    var y:CGFloat = (CGFloat(aux)*100.0)+125.0
                    funcionario.position = CGPointMake(nodePrincipal.size.width/6 - 225, y-(nodePrincipal.size.width/2))
                }
                    
                else if(i >= 12 && i < 18){
                    var aux = i - 12;
                    var y:CGFloat = (CGFloat(aux)*100.0)+125.0
                    funcionario.position = CGPointMake(nodePrincipal.size.width/6, y-(nodePrincipal.size.width/2))
                }
                    
                else{
                    funcionario.xScale = -0.5
                    var y:CGFloat = (CGFloat(i-18)*100)+125.0
                    funcionario.position = CGPointMake(nodePrincipal.size.width/6 + 150, y-(nodePrincipal.size.width/2))
                    
                }
                
                if(funcionario.position.x < nodePrincipal.size.height/2 - 300){
                    novoEsteira++;
                    
                    nodePrincipal.addChild(funcionario);
                    
                }
                    
                else{
                    novoEsteira1++;
                    
                    nodePrincipal.addChild(funcionario);
                }
                
                
                ultimoFuncionario.append(funcionario)

            }
        }

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func didMoveToView(view: SKView) {
        
        
        

        showBackButton()
        
        singleton.delegate = self
        
        setDinheiro(singleton.dinheiro)
        
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
        
        
        var maquina1 = SKTexture(imageNamed: "machine-02")
        maquina1.filteringMode = SKTextureFilteringMode.Nearest
        var maquina2 = SKTexture(imageNamed: "machine-03")
        maquina2.filteringMode = SKTextureFilteringMode.Nearest
        var maquina3 = SKTexture(imageNamed: "machine-04")
        maquina3.filteringMode = SKTextureFilteringMode.Nearest
        var maquina4 = SKTexture(imageNamed: "machine-05")
        maquina4.filteringMode = SKTextureFilteringMode.Nearest
        var maquina5 = SKTexture(imageNamed: "machine-06")
        maquina5.filteringMode = SKTextureFilteringMode.Nearest
        var maquina6 = SKTexture(imageNamed: "machine-07")
        maquina6.filteringMode = SKTextureFilteringMode.Nearest
        var maquina7 = SKTexture(imageNamed: "machine-08")
        maquina7.filteringMode = SKTextureFilteringMode.Nearest
        var maquina8 = SKTexture(imageNamed: "machine-09")
        maquina8.filteringMode = SKTextureFilteringMode.Nearest
        var maquina9 = SKTexture(imageNamed: "machine-10")
        maquina9.filteringMode = SKTextureFilteringMode.Nearest
        var maquina10 = SKTexture(imageNamed: "machine-11")
        maquina10.filteringMode = SKTextureFilteringMode.Nearest
        var maquina11 = SKTexture(imageNamed: "machine-12")
        maquina11.filteringMode = SKTextureFilteringMode.Nearest
        var maquina12 = SKTexture(imageNamed: "machine-13")
        maquina12.filteringMode = SKTextureFilteringMode.Nearest
        var maquina13 = SKTexture(imageNamed: "machine-14")
        maquina13.filteringMode = SKTextureFilteringMode.Nearest
        var maquina14 = SKTexture(imageNamed: "machine-15")
        maquina14.filteringMode = SKTextureFilteringMode.Nearest
        var maquina15 = SKTexture(imageNamed: "machine-16")
        maquina15.filteringMode = SKTextureFilteringMode.Nearest
        var maquina16 = SKTexture(imageNamed: "machine-17")
        maquina16.filteringMode = SKTextureFilteringMode.Nearest

        
        
        var anim = SKAction.animateWithTextures([maquina1,maquina2,maquina3, maquina4, maquina5, maquina6, maquina7, maquina8, maquina9, maquina10, maquina11, maquina12, maquina13, maquina15, maquina16], timePerFrame: 0.1)
        var animacao = SKAction.repeatActionForever(anim)
        
        let maquina = SKSpriteNode(texture: maquina1)
        maquina.setScale(2.0)
        maquina.runAction(animacao)
        maquina.xScale = 1.0
        maquina.yScale = 0.8
        maquina.name = "maquina"
        maquina.zPosition = 10.0
        maquina.position = CGPointMake(-175, -45)
        
        
        let maquinaNode = SKSpriteNode(texture: maquina1)
        maquinaNode.setScale(2.0)
        maquinaNode.runAction(animacao)
        maquinaNode.xScale = 1.0
        maquinaNode.yScale = 0.8
        maquinaNode.name = "maquina2"
        maquinaNode.zPosition = 10.0
        maquinaNode.position = CGPointMake(esteira1.position.x, -45)
        
        nodeLatBotoes.addChild(play)
        nodePrincipal.addChild(maquinaNode)
        nodePrincipal.addChild(maquina)
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
            produto.zPosition = -3.0
            
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
            
            var x = arc4random()%4 + 1
            
            let produto = SKSpriteNode(imageNamed: "pack-0\(x)")
            
            produto.xScale = 1.0
            produto.yScale = 1.0
            
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
            produto.zPosition = -3.0
            
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
            var x = arc4random()%4 + 1
            
            let produto = SKSpriteNode(imageNamed: "pack-0\(x)")
            
            produto.xScale = 1.0
            produto.yScale = 1.0
            
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
                        
                    
                        var workerTexture1 = SKTexture(imageNamed: "worker-61")
                        workerTexture1.filteringMode = SKTextureFilteringMode.Nearest
                        var workerTexture2 = SKTexture(imageNamed: "worker-62")
                        workerTexture2.filteringMode = SKTextureFilteringMode.Nearest
                        var workerTexture3 = SKTexture(imageNamed: "worker-63")
                        workerTexture3.filteringMode = SKTextureFilteringMode.Nearest
                        var workerTexture4 = SKTexture(imageNamed: "worker-64")
                        workerTexture4.filteringMode = SKTextureFilteringMode.Nearest
                        var workerTexture5 = SKTexture(imageNamed: "worker-65")
                        workerTexture5.filteringMode = SKTextureFilteringMode.Nearest
                        var workerTexture6 = SKTexture(imageNamed: "worker-66")
                        workerTexture6.filteringMode = SKTextureFilteringMode.Nearest
                        var workerTexture7 = SKTexture(imageNamed: "worker-67")
                        workerTexture7.filteringMode = SKTextureFilteringMode.Nearest
                        var workerTexture8 = SKTexture(imageNamed: "worker-68")
                        workerTexture8.filteringMode = SKTextureFilteringMode.Nearest
                        var workerTexture9 = SKTexture(imageNamed: "worker-69")
                        workerTexture9.filteringMode = SKTextureFilteringMode.Nearest
                        var workerTexture10 = SKTexture(imageNamed: "worker-70")
                        workerTexture10.filteringMode = SKTextureFilteringMode.Nearest
                        
                        var workerTexture11 = SKTexture(imageNamed: "worker-71")
                        workerTexture11.filteringMode = SKTextureFilteringMode.Nearest
                        var workerTexture12 = SKTexture(imageNamed: "worker-72")
                        workerTexture12.filteringMode = SKTextureFilteringMode.Nearest
                        var workerTexture13 = SKTexture(imageNamed: "worker-73")
                        workerTexture13.filteringMode = SKTextureFilteringMode.Nearest
                        var workerTexture14 = SKTexture(imageNamed: "worker-74")
                        workerTexture14.filteringMode = SKTextureFilteringMode.Nearest
                        var workerTexture15 = SKTexture(imageNamed: "worker-75")
                        workerTexture15.filteringMode = SKTextureFilteringMode.Nearest
                        var workerTexture16 = SKTexture(imageNamed: "worker-76")
                        workerTexture16.filteringMode = SKTextureFilteringMode.Nearest
                        var workerTexture17 = SKTexture(imageNamed: "worker-77")
                        workerTexture17.filteringMode = SKTextureFilteringMode.Nearest
                        var workerTexture18 = SKTexture(imageNamed: "worker-78")
                        workerTexture18.filteringMode = SKTextureFilteringMode.Nearest
                        var workerTexture19 = SKTexture(imageNamed: "worker-79")
                        workerTexture19.filteringMode = SKTextureFilteringMode.Nearest
                        var workerTexture20 = SKTexture(imageNamed: "worker-80")
                        workerTexture20.filteringMode = SKTextureFilteringMode.Nearest

                        
                        var workerTexture21 = SKTexture(imageNamed: "worker-81")
                        workerTexture21.filteringMode = SKTextureFilteringMode.Nearest
                        var workerTexture22 = SKTexture(imageNamed: "worker-82")
                        workerTexture22.filteringMode = SKTextureFilteringMode.Nearest
                        var workerTexture23 = SKTexture(imageNamed: "worker-83")
                        workerTexture23.filteringMode = SKTextureFilteringMode.Nearest
                        var workerTexture24 = SKTexture(imageNamed: "worker-84")
                        workerTexture24.filteringMode = SKTextureFilteringMode.Nearest
                        var workerTexture25 = SKTexture(imageNamed: "worker-85")
                        workerTexture25.filteringMode = SKTextureFilteringMode.Nearest
                        var workerTexture26 = SKTexture(imageNamed: "worker-86")
                        workerTexture26.filteringMode = SKTextureFilteringMode.Nearest
                        var workerTexture27 = SKTexture(imageNamed: "worker-87")
                        workerTexture27.filteringMode = SKTextureFilteringMode.Nearest
                        var workerTexture28 = SKTexture(imageNamed: "worker-88")
                        workerTexture28.filteringMode = SKTextureFilteringMode.Nearest
                        var workerTexture29 = SKTexture(imageNamed: "worker-89")
                        workerTexture29.filteringMode = SKTextureFilteringMode.Nearest
                        var workerTexture30 = SKTexture(imageNamed: "worker-90")
                        workerTexture30.filteringMode = SKTextureFilteringMode.Nearest
                        
                        
                        var anim = SKAction.animateWithTextures([workerTexture1, workerTexture2, workerTexture3, workerTexture4, workerTexture5, workerTexture6, workerTexture7, workerTexture8, workerTexture9, workerTexture10, workerTexture11, workerTexture12, workerTexture13, workerTexture14, workerTexture15, workerTexture16, workerTexture17, workerTexture18, workerTexture19, workerTexture20, workerTexture21, workerTexture22, workerTexture23, workerTexture24, workerTexture25, workerTexture26, workerTexture27, workerTexture28, workerTexture29, workerTexture30], timePerFrame: 0.02)
                        var animacao = SKAction.repeatActionForever(anim)
                        
                        let funcionario = SKSpriteNode(texture: workerTexture1)
                        funcionario.setScale(2.0)
                        funcionario.runAction(animacao)
                        funcionario.zPosition = 2.0
                        funcionario.xScale = 0.5
                        funcionario.yScale = 0.5
                        funcionario.physicsBody?.allowsRotation = false
                        funcionario.name = "funcionario"
                    

                        
                        myLabel.text = NSString(format: "%d", trabalhadoresLabel) as String
                        
                        
                        if(trabalhadores <= 5){
                                var aux = trabalhadores;
                                var y:CGFloat = (CGFloat(aux)*100.0)+125.0
                                funcionario.position = CGPointMake(nodePrincipal.size.width/6 - 375, y-(nodePrincipal.size.width/2))
                        }
                        else if(trabalhadores >= 6 && trabalhadores < 12){
                            
                                funcionario.xScale = -0.5
                                var aux = trabalhadores - 6;
                                var y:CGFloat = (CGFloat(aux)*100.0)+125.0
                                funcionario.position = CGPointMake(nodePrincipal.size.width/6 - 225, y-(nodePrincipal.size.width/2))
                        }
                            
                        else if(trabalhadores >= 12 && trabalhadores < 18){
                                var aux = trabalhadores - 12;
                                var y:CGFloat = (CGFloat(aux)*100.0)+125.0
                                funcionario.position = CGPointMake(nodePrincipal.size.width/6 , y-(nodePrincipal.size.width/2))
                        }

                        else{
                            funcionario.xScale = -0.5
                            var y:CGFloat = (CGFloat(trabalhadores-18)*100)+125.0
                            funcionario.position = CGPointMake(nodePrincipal.size.width/6 + 150, y-(nodePrincipal.size.width/2))
                    
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
                
                
                if(trabalhadores == 3 || trabalhadores == 9 || trabalhadores == 15 || trabalhadores == 21){
                    trabalhadores--
                }
                
                if(trabalhadores >= 0){
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
    
    
    
    func actionFinish(esteira: EsteiraNode) {
        esteira.moveEsteira()
    }
    
}
    

    


