//
//  Mundo.swift
//  test
//
//  Created by Felipe Costa Nascimento on 5/23/15.
//  Copyright (c) 2015 Felipe Costa Nascimento. All rights reserved.
//

import SpriteKit


class Mundo : AbstractScene{
    
    var vtPosicoes:NSMutableArray!
    var vtFabricas:NSMutableArray!
    var vtLojas:NSMutableArray!
    
    var nodeTerra:SKSpriteNode!
    
    var itemEscolhido:SKSpriteNode!
    
    
    override init(size: CGSize) {
        super.init(size: size)
        
        
        
        inicializarClasse()
        inicializarTerraComAnimacao()
        
        var btNovaFabrica = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(nodeLatBotoes.size.width, 125))
        btNovaFabrica.position = CGPointMake(0, nodeLateral.size.height / 2 - btNovaFabrica.size.height / 2 - 47.5)
        btNovaFabrica.zPosition = 1
        btNovaFabrica.name = "nova fabrica"
        nodeLatBotoes.addChild(btNovaFabrica)
        
        var btNovaLoja = SKSpriteNode(color: UIColor.orangeColor(), size: CGSizeMake(nodeLatBotoes.size.width, 125))
        btNovaLoja.position = CGPointMake(0, btNovaFabrica.position.y - btNovaLoja.size.height - 25)
        btNovaLoja.zPosition = 1
        btNovaLoja.name = "nova loja"
        nodeLatBotoes.addChild(btNovaLoja)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func inicializarClasse(){
        //DEFINO AS CORES DE FUNDO DA TELA
        self.backgroundColor = UIColor.whiteColor()
        nodePrincipal.color = UIColor.whiteColor()
        nodeLateral.color = UIColor.lightGrayColor()
        
        //ZERO O ALPHA DOS NODES PARA FAZER POSTERIORMENTE A ANIMAÇÃO DE FADE IN
        nodeLateral.alpha = 0
        nodeSuperior.alpha = 0
        nodeInferior.alpha = 0
        
        //INICIALIZA OS VETORES QUE TERÃO AS FÁBRICAS E LOJAS QUE FOREM ADICIONADAS NA TERRA
        vtFabricas = NSMutableArray()
        vtLojas = NSMutableArray()
        vtPosicoes = NSMutableArray()
        
        //INICIALIZA O NODE QUE REPRESENTA A TERRA
        nodeTerra = SKSpriteNode(imageNamed: "terra.png")
        nodeTerra.position = CGPointMake(self.size.width / 2, self.size.height / 2)
        self.addChild(nodeTerra)
        
        var singleton = Singleton.sharedInstance
        singleton.delegate = self
    }
    
    
    
    
    
    private func adicionarPosicaoLivre(position:CGPoint){
        var emptyPlace = EmptyPlace(size: CGSizeMake(nodeTerra.size.width * 0.3, nodeTerra.size.width * 0.3))
        emptyPlace.position = position
        nodeTerra.addChild(emptyPlace)
        vtPosicoes.addObject(emptyPlace)
    }
    
    
    private func gerarFabrica() -> SKSpriteNode{
        var fabrica = Fabrica(size: CGSizeMake(nodeTerra.size.width * 0.3, nodeTerra.size.width * 0.3))
        
        return fabrica
    }
    
    
    private func gerarLoja() -> SKSpriteNode{
        var loja = Loja(size: CGSizeMake(nodeTerra.size.width * 0.2, nodeTerra.size.width * 0.2))
        
        return loja
    }
    
    
    private func inicializarTerraComAnimacao(){
        
        //VERIFICA SE O TAMANHO DA TERRA É MAIOR QUE O NODE PRINCIPAL
        var tamanho = nodeTerra.size
        if(tamanho.height > nodePrincipal.size.height){
            tamanho.height -= tamanho.height - nodePrincipal.size.height + 20
            tamanho.width = tamanho.height
        }
        
        //CRIA AS ANIMAÇÕES DE MOVIMENTO DA TERRA, APARECIMENTO DOS NODES E REDIMENSIONAMENTO DA TERRA(CASO NECESSÁRIO)
        var actionMove = SKAction.moveToX(nodePrincipal.size.width / 2, duration: 0.8)
        actionMove.timingMode = SKActionTimingMode.EaseInEaseOut
        var actionResize = SKAction.resizeToWidth(tamanho.width, height: tamanho.height, duration: actionMove.duration)
        var actionFade = SKAction.fadeInWithDuration(1)
        
        //EXECUTA AS ACTIONS
        nodeTerra.runAction(SKAction.group([actionMove, actionResize]), completion: { () -> Void in
            self.nodeTerra.removeAllActions()
            self.nodeLateral.runAction(actionFade)
            self.nodeSuperior.runAction(actionFade)
            self.nodeInferior.runAction(actionFade)
            
            self.setMensagem("Mensagem ao usuário")
            self.inicializarPosicoesLivres()
        })
    }
    
    
    //INSERE POSIÇÕES NA TERRA ONDE PODERÁ SER INSERIDO NOVAS LOJAS OU FÁBRICAS
    private func inicializarPosicoesLivres(){
        adicionarPosicaoLivre(CGPointMake(0, nodeTerra.size.height / 2.3))
        adicionarPosicaoLivre(CGPointMake(-nodeTerra.size.width / 3, nodeTerra.size.height / 4.2))
        adicionarPosicaoLivre(CGPointMake(nodeTerra.size.width / 3.5, nodeTerra.size.height / 6))
    }
   
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(self)
            let touchedNode = nodeAtPoint(location)
            let nodeName: String? = touchedNode.name
            
            if nodeName == "fabrica" {
                setMensagem("Você clicou na Fábrica")
            
            }else if nodeName == "loja" {
                setMensagem("Você clicou na Loja")
                
            }else if nodeName == "nova fabrica" {
                itemEscolhido = gerarFabrica()
                mostrarPosicoesLivres()
                
            }else if nodeName == "nova loja"{
                itemEscolhido = gerarLoja()
                mostrarPosicoesLivres()
                
            }else if nodeName == "empty place"{
                touchedNode.addChild(itemEscolhido)
                itemEscolhido = nil
                
                for i in 0 ... vtPosicoes.count - 1{
                    var node = vtPosicoes[i] as! EmptyPlace
                    node.hiddenEmptyPlace()
                }
                
            }else{
                
            }
        
        }
        
    }
    
    
    private func mostrarPosicoesLivres(){
        for i in 0 ... vtPosicoes.count - 1{
            
            var node = vtPosicoes[i] as! EmptyPlace
            node.showEmptyPlace()
        }
    }
    
}
