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
    
    var nodeGrafico: GraficoNode!
    var nodeTerra:MundoNode!
    
    var singleton:Singleton!
    
    var itemEscolhido:SKSpriteNode!
    
    override init(size: CGSize) {
        super.init(size: size)

        
        inicializarClasse()
        
        var btNovaFabrica = SKSpriteNode(imageNamed: "new-factory01")
        btNovaFabrica.size = CGSizeMake(nodeLatBotoes.size.width, 125)
        btNovaFabrica.position = CGPointMake(0, nodeLateral.size.height / 2 - btNovaFabrica.size.height / 2 - 47.5)
        btNovaFabrica.zPosition = 1
        btNovaFabrica.name = "nova fabrica"
        nodeLatBotoes.addChild(btNovaFabrica)
        
        var btNovaLoja = SKSpriteNode(imageNamed: "new-store01")
        btNovaLoja.size = CGSizeMake(nodeLatBotoes.size.width, 125)
        btNovaLoja.position = CGPointMake(0, btNovaFabrica.position.y - btNovaLoja.size.height - 25)
        btNovaLoja.zPosition = 1
        btNovaLoja.name = "nova loja"
        nodeLatBotoes.addChild(btNovaLoja)
        
        nodeGrafico = GraficoNode(size: CGSizeMake(nodeLatBotoes.size.width, 250), valorSocial: 30, valorAmbiental: 100, valorEconomico: 30)
        nodeGrafico.position = CGPointMake(0, btNovaLoja.position.y - nodeGrafico.size.height - 50)
        nodeLatBotoes.addChild(nodeGrafico)
        
        nodeTerra.startAnimacaoDeIntroducao(nodePrincipal.size.width / 2)
        
        showBackButton()
    }
    
    
    func geraValores(){
        nodeGrafico.setValoresGrafico(CGFloat(arc4random() % 100), valorAmbiental: CGFloat(arc4random() % 100), valorEconomico: CGFloat(arc4random() % 100))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func inicializarClasse(){
        //DEFINO AS CORES DE FUNDO DA TELA
        self.backgroundColor = UIColor.whiteColor()
        nodePrincipal.color = UIColor(red: 96/255, green: 216/255, blue: 244/255, alpha: 1)
        nodeInferior.color = nodePrincipal.color
        
        //ZERO O ALPHA DOS NODES PARA FAZER POSTERIORMENTE A ANIMAÇÃO DE FADE IN
        nodeLateral.alpha = 0
        nodeSuperior.alpha = 0
        nodeInferior.alpha = 0
        nodePrincipal.alpha = 0
        
        //INICIALIZA OS VETORES QUE TERÃO AS FÁBRICAS E LOJAS QUE FOREM ADICIONADAS NA TERRA
        vtFabricas = NSMutableArray()
        vtLojas = NSMutableArray()
        vtPosicoesLivres = NSMutableArray()
        
        //INICIALIZA O NODE QUE REPRESENTA A TERRA
        nodeTerra = MundoNode(size: CGSizeMake(631, 491))
        nodeTerra.position = CGPointMake(self.size.width / 2, self.size.height / 2)
        nodeTerra.delegate = self
        self.addChild(nodeTerra)
        
        
    }
    
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        singleton = Singleton.sharedInstance
        singleton.delegate = self
        
        setDinheiro(singleton.dinheiro)
        
        
        geraValores()
    }
    
    
    
    
    private func adicionarPosicaoLivre(position:CGPoint){
        var emptyPlace = EmptyPlace()
        emptyPlace.position = position
        nodeTerra.addChild(emptyPlace)
        vtPosicoesLivres.addObject(emptyPlace)
    }
    
    
    private func gerarFabrica() -> SKSpriteNode{
        var fabrica = FabricaNode(size: CGSizeMake(52, 95))
        fabrica.delegate = myDelegate
        fabrica.startSwingAnimation()
        return fabrica
        
//        var fabrica = ArvoreNode(size: CGSizeMake(67, 97))
//        fabrica.startSwingAnimation()
//        return fabrica
    }
    
    
    private func gerarLoja() -> SKSpriteNode{
        var loja = LojaNode(size: CGSizeMake(53, 66))
        loja.delegate = myDelegate
        loja.startSwingAnimation()
        return loja
    }
    
    
    func animacaoDeIntroducaoTerminou() {
        var actionFade = SKAction.fadeInWithDuration(1)
        
        //EXECUTA AS ACTIONS
        
        self.nodeTerra.removeAllActions()
        self.nodeLateral.runAction(actionFade)
        self.nodeSuperior.runAction(actionFade)
        self.nodeInferior.runAction(actionFade)
        self.nodePrincipal.runAction(actionFade)
        
        //self.setMensagem("Mensagem ao usuário")
        self.inicializarPosicoesLivres()
        //self.geraValores()
    
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
//                var pop = PopUpNode(size: self.size)
//                pop.zPosition = 3
//                pop.position = CGPointMake(self.size.width / 2, self.size.height / 2)
//                pop.showPopUp()
//                self.addChild(pop)
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
