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


class Fabrica: SKScene, SKPhysicsContactDelegate, NSFetchedResultsControllerDelegate{
    
    var novoEsteira:Int = 0
    var novoEsteira1:Int = 0
    var novoEsteira2:Int = 0
    
    var frequencia:CGFloat = 0.0;
    
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    let myLabel = SKLabelNode(fontNamed:"Heveltica")
    
    var trabalhador:Trabalhadores? = nil
    
    var trabalhadores = 0;
    
    var yVar : CGFloat!
    
    var frc:NSFetchedResultsController = NSFetchedResultsController()
    
    var valorEsteira1 = 0
    
    var valorEsteira2 = 0
    
    var valorEsteira3 = 0
    
    var ultimoFuncionario:[SKNode] = []
    
    var demitirFuncionarios:[SKNode] = []
    
    var funcionarioDemitidos:[SKNode] = []
    
    var flagEsteira1 = 1
    
    var flagEsteira2 = 1
    
    var flagEsteira3 = 1
    
    
    func retornaDados() ->[Trabalhadores]{
        
        
        let fetchedLists: [Trabalhadores]? = frc.fetchedObjects as? [Trabalhadores]
        
        return fetchedLists!
    }
    
    
    func getFetchedResultsController()-> NSFetchedResultsController{
        
        var context: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        
        frc = NSFetchedResultsController(fetchRequest: trabalhadoresFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        return frc
    }
    
    func trabalhadoresFetchRequest() -> NSFetchRequest{
        let fetchRequest = NSFetchRequest(entityName: "Trabalhadores")
        let sortDescriptor = NSSortDescriptor(key: "quantidade", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return fetchRequest
    }
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        
        frc = getFetchedResultsController()
        frc.delegate = self
        frc.performFetch(nil)
        
        trabalhadores = -1;
        
        let fundoFabrica = SKSpriteNode(imageNamed: "chao")
        fundoFabrica.xScale = 1.5
        fundoFabrica.yScale = 1.5
        fundoFabrica.position = CGPointMake(frame.size.width/2 ,frame.size.height/2)
        
        
        self.addChild(fundoFabrica);
        

        myLabel.text = NSString(format: "%d", trabalhadores+1) as String
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:50, y: CGRectGetMidY(self.frame));
        
        let play = SKSpriteNode(imageNamed: "Play")
        play.xScale = 0.3
        play.yScale = 0.3
        play.position = CGPointMake(frame.size.width - 50 ,frame.size.height - 100)
        play.name = "mais"
        
        let menos = SKSpriteNode(imageNamed: "menos")
        menos.xScale = 0.2
        menos.yScale = 0.2
        menos.position = CGPointMake(frame.size.width - 50 ,frame.size.height - 200)
        menos.name = "menos"

        
        let esteira = SKSpriteNode(imageNamed: "balcaoNode")
        esteira.xScale = 2.0
        esteira.yScale = 2.0
        esteira.position = CGPointMake(frame.size.width/2 - 300 , 150)
        esteira.name = "esteira"
        
        
        let esteira2 = SKSpriteNode(imageNamed: "balcaoNode")
        esteira2.xScale = 2.0
        esteira2.yScale = 2.0
        esteira2.position = CGPointMake(frame.size.width/2 , 150)
        esteira2.name = "esteira2"
        
        
        let esteira3 = SKSpriteNode(imageNamed: "balcaoNode")
        esteira3.xScale = 2.0
        esteira3.yScale = 2.0
        esteira3.position = CGPointMake(frame.size.width/2 + 300 , 150)
        esteira3.name = "esteira3"
        
        self.addChild(esteira3)
        self.addChild(esteira2)
        self.addChild(esteira)
        self.addChild(play)
        self.addChild(myLabel)
        self.addChild(menos)
        
        
    }
    
    
    func caixaProducao(){
        
        if(trabalhadores < 0){
            let produto = SKSpriteNode(imageNamed: "produto_preto.jpg")
            
            produto.xScale = 0.05
            produto.yScale = 0.05
            
            yVar = 0
            
            produto.position = CGPoint(x:frame.size.width/2 - 300 , y: 0)
            
            self.addChild(produto)
            
            valorEsteira1 += novoEsteira
            novoEsteira = 0
            
            let acaoAndar = SKAction.moveTo(CGPoint(x:frame.size.width/2 - 300, y: self.frame.size.height + 100), duration: NSTimeInterval(3.0))
            
            let acaoApagarNode = SKAction.removeFromParent()
            
            produto.runAction(SKAction.sequence([acaoAndar]), completion: { () -> Void in
                self.yVar = self.yVar + 60
                
            })
            produto.runAction(SKAction.waitForDuration(1.2 - (Double(self.valorEsteira1)/8)), completion: { () -> Void in
                self.runAction(SKAction.runBlock(self.caixaProducao))
                
            })
            
            
            produto.removeAllChildren()
        }
        else{
            let produto = SKSpriteNode(imageNamed: "produto.jpg")
            
            produto.xScale = 0.05
            produto.yScale = 0.05
            
            yVar = 0
            
            produto.position = CGPoint(x:frame.size.width/2 - 300 , y: 0)
            
            self.addChild(produto)
            
            valorEsteira1 += novoEsteira
            novoEsteira = 0
            
            if(valorEsteira1 > 8){
                valorEsteira1 = 8
            }
            
            
            let acaoAndar = SKAction.moveTo(CGPoint(x:frame.size.width/2 - 300, y: self.frame.size.height + 100), duration: NSTimeInterval(3.0))
            
            let acaoApagarNode = SKAction.removeFromParent()
            
            produto.runAction(SKAction.sequence([acaoAndar]), completion: { () -> Void in
                self.yVar = self.yVar + 60
                
            })
            produto.runAction(SKAction.waitForDuration(1.2 - (Double(self.valorEsteira1)/8)), completion: { () -> Void in
                self.runAction(SKAction.runBlock(self.caixaProducao))
                
            })
            
            
            produto.removeAllChildren()
        }
        

    
    }
    
    func caixaProducaoEsteira2(){
        
        if(trabalhadores < 8){
            let produto = SKSpriteNode(imageNamed: "produto_preto.jpg")
            
            produto.xScale = 0.05
            produto.yScale = 0.05
            
            yVar = 0
            
            produto.position = CGPoint(x:frame.size.width/2  , y: 0)
            
            self.addChild(produto)
            
            valorEsteira2 += novoEsteira1
            novoEsteira1 = 0
            
            
            
            let acaoAndar = SKAction.moveTo(CGPoint(x:frame.size.width/2, y: self.frame.size.height + 100), duration: NSTimeInterval(3.0))
            
            let acaoApagarNode = SKAction.removeFromParent()
            
            produto.runAction(SKAction.sequence([acaoAndar]), completion: { () -> Void in
                self.yVar = self.yVar + 60
                
            })
            produto.runAction(SKAction.waitForDuration(1.2 - (Double(self.valorEsteira2)/8)), completion: { () -> Void in
                self.runAction(SKAction.runBlock(self.caixaProducaoEsteira2))
            })
            
            
            produto.removeAllChildren()
        }
        else{
            let produto = SKSpriteNode(imageNamed: "produto.jpg")
            
            produto.xScale = 0.05
            produto.yScale = 0.05
            
            yVar = 0
            
            produto.position = CGPoint(x:frame.size.width/2  , y: 0)
            
            self.addChild(produto)
            
            valorEsteira2 += novoEsteira1
            novoEsteira1 = 0
            
            if(valorEsteira2 > 8){
                valorEsteira2 = 8
            }
            
            
            
            let acaoAndar = SKAction.moveTo(CGPoint(x:frame.size.width/2, y: self.frame.size.height + 100), duration: NSTimeInterval(3.0))
            
            let acaoApagarNode = SKAction.removeFromParent()
            
            produto.runAction(SKAction.sequence([acaoAndar]), completion: { () -> Void in
                self.yVar = self.yVar + 60
                
            })
            produto.runAction(SKAction.waitForDuration(1.2 - (Double(self.valorEsteira2)/8)), completion: { () -> Void in
                self.runAction(SKAction.runBlock(self.caixaProducaoEsteira2))
            })
            
            
            produto.removeAllChildren()
        }
        
      
        
    }
    
    
    func caixaProducaoEsteira3(){
        
        let produto = SKSpriteNode(imageNamed: "produto.jpg")
        if(trabalhadores < 16){
            let produto = SKSpriteNode(imageNamed: "produto_preto.jpg")
            
            produto.xScale = 0.05
            produto.yScale = 0.05
            
            yVar = 0
            
            produto.position = CGPoint(x:frame.size.width/2 + 300 , y: 0)
            
            self.addChild(produto)
            
            valorEsteira3 += novoEsteira2
            novoEsteira2 = 0
            
            let acaoAndar = SKAction.moveTo(CGPoint(x:frame.size.width/2 + 300, y: self.frame.size.height + 100), duration: NSTimeInterval(3.0))
            
            let acaoApagarNode = SKAction.removeFromParent()
            
            produto.runAction(SKAction.sequence([acaoAndar]), completion: { () -> Void in
                self.yVar = self.yVar + 60
                
            })
            produto.runAction(SKAction.waitForDuration(1.2 - (Double(self.valorEsteira3)/8)), completion: { () -> Void in
                self.runAction(SKAction.runBlock(self.caixaProducaoEsteira3))
            })
            
            
            produto.removeAllChildren()
            
        }
        else{
            let produto = SKSpriteNode(imageNamed: "produto.jpg")
            
            produto.xScale = 0.05
            produto.yScale = 0.05
            
            yVar = 0
            
            produto.position = CGPoint(x:frame.size.width/2 + 300 , y: 0)
            
            self.addChild(produto)
            
            valorEsteira3 += novoEsteira2
            novoEsteira2 = 0
            
            if(valorEsteira3 > 8){
                valorEsteira3 = 8
            }
            
            let acaoAndar = SKAction.moveTo(CGPoint(x:frame.size.width/2 + 300, y: self.frame.size.height + 100), duration: NSTimeInterval(3.0))
            
            let acaoApagarNode = SKAction.removeFromParent()
            
            produto.runAction(SKAction.sequence([acaoAndar]), completion: { () -> Void in
                self.yVar = self.yVar + 60
                
            })
            produto.runAction(SKAction.waitForDuration(1.2 - (Double(self.valorEsteira3)/8)), completion: { () -> Void in
                self.runAction(SKAction.runBlock(self.caixaProducaoEsteira3))
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
            
            NSLog("%d", valorEsteira3)
            
            if (node.name == "mais") {
                
                for demitir in demitirFuncionarios{
                    demitir.removeFromParent()
                }
                
                if(funcionarioDemitidos.count > 0){
                    
                    let funcionario = funcionarioDemitidos.removeLast()
                    
                    
                    self.addChild(funcionario);
                    
                    ultimoFuncionario.append(funcionario)
                    
                }
                
                else{
                    if(trabalhadores < 23){
                        if(trabalhadores == -1 && flagEsteira1 == 1){
                            runAction(SKAction.runBlock(caixaProducao))
                            flagEsteira1 = 0;
                        }
                        if(trabalhadores == 7 && flagEsteira2 == 1){
                            runAction(SKAction.runBlock(caixaProducaoEsteira2))
                            flagEsteira2 = 0
                        }
                        if(trabalhadores == 15 && flagEsteira3 == 1){
                            runAction(SKAction.runBlock(caixaProducaoEsteira3))
                            flagEsteira3 = 0
                        }
                        
                        
                        trabalhadores++;
                        
                        if(trabalhadores < 8){
                            novoEsteira++;
                        }
                        
                        else if(trabalhadores < 16){
                            novoEsteira1++;
                        }
                        
                        else{
                            novoEsteira2++
                        }
                        
                        myLabel.text = NSString(format: "%d", trabalhadores+1) as String
                        
                        salvarDados();
                        
                        let funcionario = SKSpriteNode(imageNamed: "funcionario")
                        funcionario.xScale = 0.1
                        funcionario.yScale = 0.1
                        funcionario.name = "funcionario"
                        

                        
                        if(trabalhadores <= 7){
                            var aux = trabalhadores;
                            var y:CGFloat = (CGFloat(aux)*100.0)+25.0
                        
                            funcionario.position = CGPointMake(frame.size.width/2 - 400, y)
                        }
                        else if(trabalhadores >= 8 && trabalhadores < 16){
                            var aux = trabalhadores - 8;
                            var y:CGFloat = (CGFloat(aux)*100.0)+25.0
                            funcionario.position = CGPointMake(frame.size.width/2 - 100, y)
                        }
                        
                        else{
                            //var aux = trabalhadores;
                            var y:CGFloat = (CGFloat(trabalhadores-16)*100.0)+25.0
                            funcionario.position = CGPointMake(frame.size.width/2 + 200, y)
                        }

                        self.addChild(funcionario);
                        
                        ultimoFuncionario.append(funcionario)
                        
                    }
                }
            }
            
            if(node.name == "menos"){
                
                if(trabalhadores >= 0){
                    trabalhadores--
                    
                    
                    if(trabalhadores < 8){
                        novoEsteira--
                    }
                        
                    else if(trabalhadores < 16){
                        novoEsteira1--
                    }
                        
                    else{
                        novoEsteira2--
                    }
                    
                    myLabel.text = NSString(format: "%d", trabalhadores+1) as String
                    
                    excluirFuncionario(node as! SKSpriteNode)
                }
                
            }
            
            if(node.name == "funcionario"){
                
                for demitir in demitirFuncionarios{
                    demitir.removeFromParent()
                }
                
                let demitir = SKSpriteNode(imageNamed: "demitir")
                demitir.xScale = 0.1
                demitir.yScale = 0.1
                demitir.zPosition = 1.0
                demitir.name = NSString(format: "%d", trabalhadores) as String
                demitir.position = CGPointMake(node.position.x - 60, node.position.y)

                
                self.addChild(demitir)
                
                
                demitirFuncionarios.append(demitir)
                
                ultimoFuncionario.append(node)
            }
            
            if(node.zPosition == 1.0){
                
                if(trabalhadores >= 0){
                
                    trabalhadores--
                    
                    if(trabalhadores < 8){
                        novoEsteira--;
                    }
                        
                    else if(trabalhadores < 16){
                        novoEsteira1--;
                    }
                        
                    else{
                        novoEsteira2--;
                    }
                    
                    myLabel.text = NSString(format: "%d", trabalhadores+1) as String
        
                    excluirFuncionario(node as! SKSpriteNode)
                }
            }
            
        }
    }

    
    func excluirFuncionario(funcionario:SKSpriteNode) {
        
        //let myString : String = funcionario.name!
        
        //let x : Int? = myString.toInt()
        
        funcionarioDemitidos.append(ultimoFuncionario.last!)
        
        ultimoFuncionario.removeLast().removeFromParent()
        

        
        
        if(funcionario.zPosition == 1.0){
            funcionario.removeFromParent()
        }
        
        for demitir in demitirFuncionarios{
            demitir.removeFromParent()
        }
        
    }
    
    
    func salvarDados(){
        let ent = NSEntityDescription.entityForName("Trabalhadores", inManagedObjectContext:context!)
        
        let trabalhador = Trabalhadores(entity: ent!, insertIntoManagedObjectContext: context)
        
        //trabalhador.quantidade = trabalhadores;
        
        context?.save(nil)
    }
    
    func editarDados(){
        
        
        trabalhador?.quantidade = NSString(format: "%d", trabalhadores) as String
        
        context?.save(nil)
        
    }
    

}
