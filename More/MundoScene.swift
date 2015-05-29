//
//  Mundo.swift
//  test
//
//  Created by Felipe Costa Nascimento on 5/23/15.
//  Copyright (c) 2015 Felipe Costa Nascimento. All rights reserved.
//

import SpriteKit


class MundoScene : AbstractScene, MundoDelegate{
    
    var vtPosicoesLivres:NSMutableArray!
    var vtFabricas:NSMutableArray!
    var vtLojas:NSMutableArray!
    
    
    var nodeTerra:MundoNode!
    
    var singleton:Singleton!
    
    var itemEscolhido:SKSpriteNode!
    
    
    override init(size: CGSize) {
        super.init(size: size)

        
        inicializarClasse()
        
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
        vtPosicoesLivres = NSMutableArray()
        
        //INICIALIZA O NODE QUE REPRESENTA A TERRA
        nodeTerra = MundoNode(size: CGSizeMake(295, 295))
        nodeTerra.position = CGPointMake(self.size.width / 2, self.size.height / 2)
        nodeTerra.delegate = self
        self.addChild(nodeTerra)
        
        
    }
    
    
    override func didMoveToView(view: SKView) {
        nodeTerra.startAnimacaoDeIntroducao(nodePrincipal.size.width / 2)
        singleton = Singleton.sharedInstance
        singleton.delegate = self
    }
    
    
    
    
    private func adicionarPosicaoLivre(position:CGPoint){
        var emptyPlace = EmptyPlace(size: CGSizeMake(nodeTerra.size.width * 0.3, nodeTerra.size.width * 0.3))
        emptyPlace.position = position
        nodeTerra.addChild(emptyPlace)
        vtPosicoesLivres.addObject(emptyPlace)
    }
    
    
    private func gerarFabrica() -> SKSpriteNode{
        var fabrica = FabricaNode(size: CGSizeMake(nodeTerra.size.width * 0.3, nodeTerra.size.width * 0.3))
        fabrica.delegate = myDelegate
        return fabrica
    }
    
    
    private func gerarLoja() -> SKSpriteNode{
        var loja = LojaNode(size: CGSizeMake(nodeTerra.size.width * 0.2, nodeTerra.size.width * 0.2))
        loja.delegate = myDelegate
        return loja
    }
    
    
    func animacaoDeIntroducaoTerminou() {
        var actionFade = SKAction.fadeInWithDuration(1)
        
        //EXECUTA AS ACTIONS
        
        self.nodeTerra.removeAllActions()
        self.nodeLateral.runAction(actionFade)
        self.nodeSuperior.runAction(actionFade)
        self.nodeInferior.runAction(actionFade)
        
        self.setMensagem("Mensagem ao usuário")
        self.inicializarPosicoesLivres()
    
    
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
            

            if nodeName == "nova fabrica" {
                itemEscolhido = gerarFabrica()
                vtFabricas.addObject(itemEscolhido)
                mostrarPosicoesLivres()
                
            }else if nodeName == "nova loja"{
                itemEscolhido = gerarLoja()
                vtLojas.addObject(itemEscolhido)
                mostrarPosicoesLivres()
                
            }else if nodeName == "empty place"{
                touchedNode.addChild(itemEscolhido)
                itemEscolhido = nil
                
                for i in 0 ... vtPosicoesLivres.count - 1{
                    var node = vtPosicoesLivres[i] as! EmptyPlace
                    node.hiddenEmptyPlace()
                }
                
            }else{
                removerReferencias()
            }
        
        }
        
    }
    
    
    private func mostrarPosicoesLivres(){
        for i in 0 ... vtPosicoesLivres.count - 1{
            
            var node = vtPosicoesLivres[i] as! EmptyPlace
            node.showEmptyPlace()
        }
    }
    
}
