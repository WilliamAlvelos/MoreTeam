//
//  Mundo.swift
//  test
//
//  Created by Felipe Costa Nascimento on 5/23/15.
//  Copyright (c) 2015 Felipe Costa Nascimento. All rights reserved.
//

import SpriteKit


class MundoScene : AbstractScene{
    
    //NODES UTILIZADOS NA COMPOSIÇÃO DA CENA
    var nodeGrafico: GraficoNode!
    var nodeTerra:MundoNode!
    
    var itemEscolhido:AbstractConstruction!
    
    override init(size: CGSize) {
        super.init(size: size)
        
        inicializarClasse()
        //nodeTerra.startAnimacaoDeIntroducao(nodePrincipal.size.width / 2)
        
    }
    
    
    func geraValores(){
        nodeGrafico.setValoresGrafico(Float(arc4random() % 100), valorAmbiental: Float(arc4random() % 100), valorEconomico: Float(arc4random() % 100))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func inicializarClasse(){
        //DEFINO AS CORES DE FUNDO DA TELA
        nodePrincipal.color = UIColor(red: 96/255, green: 216/255, blue: 244/255, alpha: 1)
        esconderNodeInferior()
        
        //INICIALIZA O NODE QUE REPRESENTA A TERRA
        nodeTerra = MundoNode(size: CGSizeMake(631, 491))
        //nodeTerra.position = CGPointMake(self.size.width / 2, self.size.height / 2)
        nodePrincipal.addChild(nodeTerra)
        
        inicializarComponentes()
    }
    
    private func inicializarComponentes(){
        //CRIA O BOTÃO DE INSERIR NOVAS FÁBRICAS
        var btNovaFabrica = ButtonNode(startImageName: "new-factory01", touchImageName: "new-factory02", buttonName: "newFactory")
        btNovaFabrica.position = CGPointMake(0, nodeLateral.size.height / 2 - btNovaFabrica.size.height / 2 - 47.5)
        btNovaFabrica.delegate = self
        nodeLatBotoes.addChild(btNovaFabrica)
        
        //CRIA O BOTÃO DE INSERIR NOVAS LOJAS
        var btNovaLoja = ButtonNode(startImageName: "new-store01", touchImageName: "new-store02", buttonName: "newStore")
        btNovaLoja.position = CGPointMake(0, btNovaFabrica.position.y - btNovaLoja.size.height - 25)
        btNovaLoja.delegate = self
        nodeLatBotoes.addChild(btNovaLoja)
        
        //CRIA O GRÁFICO QUE EXIBE AS 3 VARIÁVEIS GLOBAIS
        nodeGrafico = GraficoNode(size: CGSizeMake(nodeLatBotoes.size.width, 250), valorSocial: 0, valorAmbiental: 0, valorEconomico: 0)
        nodeGrafico.position = CGPointMake(0, btNovaLoja.position.y - nodeGrafico.size.height - 50)
        nodeLatBotoes.addChild(nodeGrafico)
    }
    
    
    override func touchedButtonWithName(buttonName: String) {
        
        switch(buttonName){
        case "newFactory":
            itemEscolhido = gerarFabrica()
            break
            
        case "newStore":
            itemEscolhido = gerarLoja()
            break
            
        default:
            break
        }
        
        nodeTerra.showEmptyPlaces()
        
        println(buttonName)
    }
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        singleton.delegate = self
        
        setDinheiro(singleton.dinheiro)
        //nodeGrafico.setValoresGrafico(singleton.porcSocial, valorAmbiental: singleton.porcAmbiental, valorEconomico: singleton.porcEconomia)
        
        geraValores()
    }
    
    
    
    private func gerarFabrica() -> AbstractConstruction{
        var fabrica = FabricaNode(size: CGSizeMake(52, 95))
        fabrica.delegate = myDelegate
        return fabrica
    }
    
    
    private func gerarLoja() -> AbstractConstruction{
        var loja = LojaNode(size: CGSizeMake(53, 66))
        loja.delegate = myDelegate
        return loja
    }

    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(self)
            let touchedNode = nodeAtPoint(location)
            let nodeName: String? = touchedNode.name
            

            if nodeName == "empty place"{
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
        //nodeTerra.atualizarSprites(singleton.porcAmbiental)
        nodeTerra.atualizarSprites(Float(arc4random() % 100))
    }
    
}
