//
//  Mundo.swift
//  test
//
//  Created by Felipe Costa Nascimento on 5/23/15.
//  Copyright (c) 2015 Felipe Costa Nascimento. All rights reserved.
//

import SpriteKit


class MundoScene : AbstractScene, MundoDelegate{
    
    //NODES UTILIZADOS NA COMPOSIÇÃO DA CENA
    var nodeGrafico: GraficoNode!
    var nodeTerra:MundoNode!
    
    //SINGLETON QUE É USADO PARA CONSUMIR AS VARIÁVEIS GLOBAIS
    var singleton:Singleton!
    
    var itemEscolhido:SKSpriteNode!
    
    override init(size: CGSize) {
        super.init(size: size)
        
        inicializarClasse()
        nodeTerra.startAnimacaoDeIntroducao(nodePrincipal.size.width / 2)
        
    }
    
    
    func geraValores(){
        nodeGrafico.setValoresGrafico(Float(arc4random() % 100), valorAmbiental: Float(arc4random() % 100), valorEconomico: Float(arc4random() % 100))
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
        
        //INICIALIZA O NODE QUE REPRESENTA A TERRA
        nodeTerra = MundoNode(size: CGSizeMake(631, 491))
        nodeTerra.position = CGPointMake(self.size.width / 2, self.size.height / 2)
        nodeTerra.delegate = self
        self.addChild(nodeTerra)
        
        inicializarComponentes()
    }
    
    private func inicializarComponentes(){
        //CRIA O BOTÃO DE INSERIR NOVAS FÁBRICAS
        var btNovaFabrica = gerarBotao("new-factory01", name: "nova fabrica")
        btNovaFabrica.position = CGPointMake(0, nodeLateral.size.height / 2 - btNovaFabrica.size.height / 2 - 47.5)
        nodeLatBotoes.addChild(btNovaFabrica)
        
        //CRIA O BOTÃO DE INSERIR NOVAS LOJAS
        var btNovaLoja = gerarBotao("new-store01", name: "nova loja")
        btNovaLoja.position = CGPointMake(0, btNovaFabrica.position.y - btNovaLoja.size.height - 25)
        nodeLatBotoes.addChild(btNovaLoja)
        
        //CRIA O GRÁFICO QUE EXIBE AS 3 VARIÁVEIS GLOBAIS
        nodeGrafico = GraficoNode(size: CGSizeMake(nodeLatBotoes.size.width, 250), valorSocial: 30, valorAmbiental: 100, valorEconomico: 30)
        nodeGrafico.position = CGPointMake(0, btNovaLoja.position.y - nodeGrafico.size.height - 50)
        nodeLatBotoes.addChild(nodeGrafico)
    }
    
    
    private func gerarBotao(imagem:String, name:String) -> SKSpriteNode{
        var botao = SKSpriteNode(imageNamed: imagem)
        botao.size = CGSizeMake(nodeLatBotoes.size.width, 125)
        botao.zPosition = 1
        botao.name = name
        
        return botao
    }
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        singleton = Singleton.sharedInstance
        singleton.delegate = self
        
        setDinheiro(singleton.dinheiro)
        //nodeGrafico.setValoresGrafico(singleton.porcSocial, valorAmbiental: singleton.porcAmbiental, valorEconomico: singleton.porcEconomia)
        geraValores()
    }
    
    
    
    private func gerarFabrica() -> SKSpriteNode{
        var fabrica = FabricaNode(size: CGSizeMake(52, 95))
        fabrica.delegate = myDelegate
        return fabrica
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
    
    }

    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(self)
            let touchedNode = nodeAtPoint(location)
            let nodeName: String? = touchedNode.name
            

            if nodeName == "nova fabrica"{
                itemEscolhido = gerarFabrica()
                nodeTerra.showEmptyPlaces()
                
            }else if nodeName == "nova loja"{
                itemEscolhido = gerarLoja()
                nodeTerra.showEmptyPlaces()
                
            }else if nodeName == "empty place"{
                touchedNode.addChild(itemEscolhido)
                itemEscolhido = nil

                nodeTerra.hiddeEmptyPlaces()
                
            }else{
                nodeTerra.hiddeEmptyPlaces()
//                var pop = PopUpNode(size: self.size)
//                pop.zPosition = 3
//                pop.position = CGPointMake(self.size.width / 2, self.size.height / 2)
//                pop.showPopUp()
//                self.addChild(pop)
            }
        
        }
        
    }
    
    
    func atualizarCena(){
        nodeTerra.atualizarSprites()
    }
    
}
