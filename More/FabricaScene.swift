//
//  Fabrica.swift
//  More
//
//  Created by William Alvelos on 21/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//


import SpriteKit
import CoreData



class FabricaScene: AbstractScene, EsteiraNodeDelegate{
    
    var novoEsteira:Int = 0
    var novoEsteira1:Int = 0
    var novoEsteira2:Int = 0
    
    var frequencia:CGFloat = 0.0;
    
    var trabalhadores = 0;

    var yVar : CGFloat!
    
    var valorEsteira1 = 0
    
    var valorEsteira2 = 0
    
    var ultimoFuncionario:[SKNode] = []
    
    var flagEsteira1 = 1
    
    var flagEsteira2 = 1
    
    var esteira2:EsteiraNode = EsteiraNode()
    
    var esteira1:EsteiraNode = EsteiraNode()
    
    var fabricaData:NSManagedObject!
    
    
    init(fabrica:NSManagedObject, size: CGSize){
        
        super.init(size: size)
        
        fabricaData = fabrica
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
        
        
        var y = fabrica.valueForKey("qtdFuncionario") as! Int
        println("quantidade funcionários: \(y)")
        if y < -1{
            y = -1
        }
        
        
        trabalhadores = y - 1
        
        var x = y - 1
        
        var i = -1
        
        while(i < x){
        
            i++;
            if(i == 2 || i == 8 || i == 14 || i == 20){
                i++
            }
            
            if(i < 24){
                if(i == 0 && flagEsteira1 == 1){
                    runAction(SKAction.runBlock(caixaProducao))
                    flagEsteira1 = 0;
                }
                if(i == 12 && flagEsteira2 == 1){
                    runAction(SKAction.runBlock(caixaProducaoEsteira2))
                    flagEsteira2 = 0
                }
                

                let funcionario = SKSpriteNode(imageNamed: "worker-61")
                funcionario.setScale(2.0)
                funcionario.runAction(gerarActionFuncionario())
                funcionario.xScale = 0.5
                funcionario.yScale = 0.5
                funcionario.zPosition = 2.0
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
                    novoEsteira++
                    valorEsteira1++
                    nodePrincipal.addChild(funcionario);
                    
                }
                    
                else{
                    novoEsteira1++
                    valorEsteira2++
                    nodePrincipal.addChild(funcionario);
                }
                
                
                ultimoFuncionario.append(funcionario)

            }
        }
      
        esteira1.trabalhadores = valorEsteira1
        
        esteira2.trabalhadores = valorEsteira2


    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func didMoveToView(view: SKView) {

        showBackButton()
        
        singleton.delegate = self
        
        btSound.changeToSoundOff(singleton.soundOff)
        
        setDinheiro(singleton.dinheiro)
        
        esconderNodeInferior()
        
        let fabrica = SKSpriteNode(imageNamed: "Factory")
        fabrica.position = CGPointMake(0,0)
        fabrica.zPosition = 0.00000001
        fabrica.yScale = 1.15
        fabrica.name = "fabrica"

        var arrayTextures = Array<SKTexture>()
        
        for i in 2 ... 17{
            var maquina = SKTexture(imageNamed: String(format: "machine-%02d", i))
            maquina.filteringMode = SKTextureFilteringMode.Nearest
            arrayTextures.append(maquina)
        }
        
        var animacao = SKAction.repeatActionForever(SKAction.animateWithTextures(arrayTextures, timePerFrame: 0.1))
        
        let maquina = gerarMaquinaNode("maquina1")
        maquina.runAction(animacao)
        maquina.position = CGPointMake(-175, -45)
        
        
        let maquinaNode = gerarMaquinaNode("maquina2")
        maquinaNode.runAction(animacao)
        maquinaNode.position = CGPointMake(esteira1.position.x, -45)

        
        var play = ButtonNode(startImageName: "wireframe-07", touchImageName: "wireframe-12", buttonName: "mais")
        play.position =  CGPointMake(0,+250)
        play.delegate = self
        play.size = CGSizeMake(190, 125)
        play.position = CGPointMake(0,+250)
        nodeLatBotoes.addChild(play)
        
        
        var menos = ButtonNode(startImageName: "wireframe-06", touchImageName: "wireframe-11", buttonName: "menos")
        menos.position =  CGPointMake(0,+250)
        menos.delegate = self
        menos.size = CGSizeMake(190, 125)
        menos.position = CGPointMake(0 ,70)
        nodeLatBotoes.addChild(menos)
        
        
        var materia = ButtonNode(startImageName: "wireframe-08", touchImageName: "wireframe-13", buttonName: "materia")
        materia.position =  CGPointMake(0,+250)
        materia.delegate = self
        materia.size = CGSizeMake(190, 125)
        materia.position = CGPointMake(0 , -110)
        
        
        nodeLatBotoes.addChild(materia)
        nodePrincipal.addChild(maquinaNode)
        nodePrincipal.addChild(maquina)
        nodePrincipal.addChild(fabrica)
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
    
    override func touchedButtonWithName(buttonName: String) {
        
        if(buttonName == "materia"){
            var pop = PopUpNode(size: self.size)
            pop.zPosition = 10.0
            pop.position = CGPointMake(self.size.width/2, self.size.height/2)
            pop.showPopUp()
            addChild(pop)
            
        }
        
        
        
        if (buttonName == "mais") {
            
            
            if(singleton.dinheiro > NSInteger(singleton.precoFuncionario) && trabalhadores <= 22){
                
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
                    
                    
                    let funcionario = SKSpriteNode(imageNamed: "worker-61")
                    funcionario.setScale(2.0)
                    funcionario.runAction(gerarActionFuncionario())
                    funcionario.zPosition = 2.0
                    funcionario.xScale = 0.5
                    funcionario.yScale = 0.5
                    funcionario.name = "funcionario"
                    
                    
                    
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
        
        if(buttonName == "menos"){
            
            
            if(trabalhadores == 3 || trabalhadores == 9 || trabalhadores == 15 || trabalhadores == 21){
                trabalhadores--
            }
            
            if(trabalhadores >= 0){
                trabalhadores--
                
                
                if(ultimoFuncionario.last!.position.x < nodePrincipal.size.height/2 - 300){
                    novoEsteira--;
                }
                    
                else{
                    novoEsteira1--;
                }
                
                ultimoFuncionario.removeLast().removeFromParent()
                
                singleton.demitirFuncionario()
            }
            
        }

    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            var node = self.nodeAtPoint(location)
            
//            
//            NSLog("%d", valorEsteira1)
//            
//            NSLog("%d", valorEsteira2)
            
            if(node.name == "voltar"){
                trabalhadores++
                fabricaData.setValue(trabalhadores, forKey: "qtdFuncionario")
                myDelegate!.backToWorld()
                
                println("quantidade atual funcionários: \(trabalhadores)")
            }
            
            
            if(node.name == "funcionario"){
                
                setMensagem("funcionario")
                
            }
            
        }
    }
    
    
    
    //FUNÇÃO QUE RETORNA UMA MÁQUINA NODE
    private func gerarMaquinaNode(nome:String) -> SKSpriteNode{
        let maquina = SKSpriteNode(imageNamed: "machine-02")
        maquina.setScale(2.0)
        maquina.xScale = 1.0
        maquina.yScale = 0.8
        maquina.name = nome
        maquina.zPosition = 10.0
        
        return maquina
    }
    
    
    //FUNÇÃO QUE RETORNA O ACTION DO FUNCIONÁRIO
    private func gerarActionFuncionario() -> SKAction{
        var arrayTextures = Array<SKTexture>()
        
        for i in 61 ... 90 {
            var workerTexture = SKTexture(imageNamed: "worker-\(i)")
            workerTexture.filteringMode = SKTextureFilteringMode.Nearest
            
            arrayTextures.append(workerTexture)
        }
        
        return SKAction.repeatActionForever(SKAction.animateWithTextures(arrayTextures, timePerFrame: 0.02))
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
