//
//  TelaPrincipal.swift
//  test
//
//  Created by Felipe Costa Nascimento on 5/21/15.
//  Copyright (c) 2015 Felipe Costa Nascimento. All rights reserved.
//

import SpriteKit
import CoreData

protocol AbstractSceneDelegate{
    func backToWorld()
    func goToFabrica(fabrica:NSManagedObject)
    func goToLoja(loja:NSManagedObject)
}


class AbstractScene: SKScene, SingletonDelegate, ButtonNodeDelegate {
    
    var myDelegate:AbstractSceneDelegate?
    
    //VARIÁVEIS QUE CONTROLAM AS LABELS
    private var producao:Float!
    private var dinheiro:NSInteger!
    private var mensagem:String!
    
    //LABELS
    private var lblValor:SKLabelNode!
    private var lblProducao:SKLabelNode!
    private var lblMensagem:UILabel?
    
    //BOTOES
    var btVoltar:SKLabelNode!
    
    //NODES QUE SERVEM COMO BASE DE TODA A SCENE
    var nodeLateral:SKSpriteNode!
    var nodeSuperior:SKSpriteNode!
    var nodeInferior:SKSpriteNode!
    var nodePrincipal:SKSpriteNode!
    var nodeSupButton:SKSpriteNode!
    var nodeSupLabelValor:SKSpriteNode!
    var nodeSupLabelProducao:SKSpriteNode!
    var nodeLatBotoes:SKSpriteNode!
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(size: CGSize) {
        super.init(size: size)
        
        

        inicializarNodes()
        inicializarLabels()
    }
    
    
    private func inicializarNodes(){
        //ADICIONA A BARRA SUPERIOR DA CENA E SEUS SUB NODES
        inicializarNodeSuperior()
        
        //ADICIONA A BARRA LATERAL DA CENA E SEU SUB NODE
        inicializarNodeLateral()
        
        //ADICIONA A BARRA INFERIOR DA CENA
        nodeInferior = SKSpriteNode(color: UIColor(red: 40/255, green: 40/255, blue: 39/255, alpha: 1), size: CGSizeMake(size.width - nodeLateral.size.width, 70))
        nodeInferior.position = CGPointMake(nodeInferior.size.width / 2, (nodeInferior.size.height / 2))
        self.addChild(nodeInferior)
        
        //ADICIONA O PAINEL PRINCIPAL DA CENA
        nodePrincipal = SKSpriteNode(color: UIColor.whiteColor(), size: CGSizeMake(size.width - nodeLateral.size.width, size.height - nodeSuperior.size.height - nodeInferior.size.height))
        nodePrincipal.position = CGPointMake(nodePrincipal.size.width / 2, (nodePrincipal.size.height / 2) + nodeInferior.size.height)
        self.addChild(nodePrincipal)
        
        nodePrincipal.zPosition = -10.0
    }
    
    
    private func inicializarNodeSuperior(){
        var nodePosition = CGPoint()
        
        //INICIALIZA NODE SUPERIOR CONTAINER PRINCIPAL
        nodeSuperior = SKSpriteNode(color: UIColor(red: 199/255, green: 169/255, blue: 91/255, alpha: 1), size: CGSizeMake(size.width, 45))
        //DEFINE O POSITION DO NODE
        nodePosition.x = nodeSuperior.size.width / 2
        nodePosition.y = size.height - (nodeSuperior.size.height / 2)
        nodeSuperior.position = nodePosition
        self.addChild(nodeSuperior)
        
        //INICIALIZA O NODE CONTAINER DO BOTÃO DE VOLTAR
        nodeSupButton = SKSpriteNode(color: nil, size: CGSizeMake(55, nodeSuperior.size.height))
        //DEFINE O POSITION DO NODE
        nodePosition.x = (-nodeSuperior.size.width / 2) + (nodeSupButton.size.width / 2)
        nodePosition.y = 0
        nodeSupButton.position = nodePosition
        nodeSuperior.addChild(nodeSupButton)
        
        //INICIALIZA O NODE CONTAINER DA LABEL QUE EXIBE VALOR
        nodeSupLabelValor = SKSpriteNode(color: nil, size: CGSizeMake(300, nodeSuperior.size.height))
        //DEFINE O POSITION DO NODE
        nodePosition.x += nodeSupLabelValor.size.width / 2 + nodeSupButton.size.width / 2 + 15
        nodeSupLabelValor.position = nodePosition
        nodeSuperior.addChild(nodeSupLabelValor)
        
        //INICIALIZA O NODE CONTAINER DA LABEL QUE EXIBE PRODUÇÃO
        nodeSupLabelProducao = SKSpriteNode(color: nil, size: CGSizeMake(350, nodeSuperior.size.height))
        //DEFINE O POSITION DO NODE
        nodePosition.x += nodeSupLabelProducao.size.width / 2 + nodeSupLabelValor.size.width / 2 + 15
        nodeSupLabelProducao.position = nodePosition
        nodeSuperior.addChild(nodeSupLabelProducao)
    }
    
    
    private func inicializarNodeLateral(){
        //INICIALIZA NODE CONTAINER LATERAL PRINCIPAL
        nodeLateral = SKSpriteNode(color: UIColor(red: 40/255, green: 40/255, blue: 39/255, alpha: 1), size: CGSizeMake(274, size.height - nodeSuperior.size.height))
        nodeLateral.position = CGPointMake(size.width - (nodeLateral.size.width / 2), (size.height / 2) - (nodeSuperior.size.height / 2))
        self.addChild(nodeLateral)
        
        //INICIALIZA O NODE CONTAINER DOS BOTÕES LATERAIS
        nodeLatBotoes = SKSpriteNode(color: nil, size: CGSizeMake(190, nodeLateral.size.height))
        nodeLateral.addChild(nodeLatBotoes)
    }
    
    
    private func inicializarLabels(){
        
        //ADICIONA A LABEL QUE MOSTRA DETERMINADO VALOR
        lblValor = gerarLabel("R$ 000,00", pos: CGPointMake(0, 0))
        lblValor.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        nodeSupLabelValor.addChild(lblValor)
        
        //ADICIONA A LABEL QUE MOSTRA ALGO
        lblProducao = gerarLabel("0 product per second", pos: CGPointMake(0, 0))
        lblProducao.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        nodeSupLabelProducao.addChild(lblProducao)
    }
    
    
    private func gerarLabel(texto:String, pos:CGPoint) -> SKLabelNode{
        var label = SKLabelNode(fontNamed: "Saniretro")
        label.fontSize = 10 + (nodeSuperior.size.width * 0.015)
        label.text = texto
        label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
        label.position = pos
        
        return label
    }
    
    
    
    override func didMoveToView(view: SKView) {
        if(nodeInferior == nil){
            return
        }
        //ADICIONAR UMA UILABEL QUE EXIBIRÁ MENSAGENS PARA O USUÁRIO
        var newFrame:CGRect = nodeInferior.frame
        newFrame.size.width -= 20
        newFrame.origin.x += 10
        newFrame.origin.y = self.view!.frame.size.height - newFrame.size.height;
        
        lblMensagem = UILabel(frame: newFrame)
        lblMensagem?.numberOfLines = 0
        lblMensagem?.textAlignment = NSTextAlignment.Center
        lblMensagem?.textColor = UIColor.whiteColor()
        lblMensagem?.font = UIFont(name: "AvenirNextCondensed-Regular", size: 10 + (nodeInferior.size.width * 0.02))
        lblMensagem?.text = mensagem
        self.view?.addSubview(lblMensagem!)
    }
    
    

    func showBackButton(){
        nodeSupButton.color = UIColor(red: 194/255, green: 130/255, blue: 0, alpha: 1)
        nodeSupButton.name = "voltar"
        
        btVoltar = SKLabelNode(fontNamed: "Saniretro")
        btVoltar.position = CGPointMake(0, 0)
        btVoltar.text = "<"
        btVoltar.name = "voltar"
        btVoltar.fontSize = 50
        btVoltar.horizontalAlignmentMode = .Center
        btVoltar.verticalAlignmentMode = .Center
        
        nodeSupButton.addChild(btVoltar)
    }

    
    func touchedButtonWithName(buttonName: String) {
        //SOBREESCREVER NAS SUBCLASSES
    }
    
    
    func removerReferencias(){
        myDelegate = nil        
    }
    
    
    func esconderNodeInferior(){
        nodePrincipal.size.height += nodeInferior.size.height
        nodePrincipal.position.y = nodePrincipal.size.height / 2
        
        nodeInferior.removeFromParent()
        nodeInferior = nil
    }

    
    func setMensagem(novaMensagem:String){
        if (lblMensagem == nil) {
            mensagem = novaMensagem
            return
        }
        
        
        lblMensagem?.text = novaMensagem
    }
    
    
    
    func setVolProducao(novoVolProducao: Int) {
        lblProducao.text = "\(novoVolProducao) product per second"
    }
    
    
    func setDinheiro(novoDinheiro: NSInteger) {
        lblValor.text = "$ \(novoDinheiro)"
    }
}