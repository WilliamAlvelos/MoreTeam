//
//  GraficoNode.swift
//  More
//
//  Created by Felipe Costa Nascimento on 5/29/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit

class GraficoNode: SKSpriteNode {
    
    private var social:Float!
    private var ambiental:Float!
    private var economico:Float!
    
    var nodeSocial:SKSpriteNode!
    var nodeAmbiental:SKSpriteNode!
    var nodeEconomico:SKSpriteNode!
    
    var lblSocial:SKLabelNode!
    var lblAmbiental:SKLabelNode!
    var lblEconomico:SKLabelNode!
    
    var timer:NSTimer!
    
    init(size:CGSize, valorSocial:Float, valorAmbiental:Float, valorEconomico:Float){
        super.init(texture: nil, color: nil, size: size)
        self.zPosition = 1
        
        social = valorSocial
        ambiental = valorAmbiental
        economico = valorEconomico
        
        inicializarNodes()
        inicializarLabels()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func inicializarNodes(){
        nodeSocial = SKSpriteNode(color: nil, size: CGSizeMake(60.0, (CGFloat(social)/100) * self.size.height))
        nodeSocial.position = CGPointMake(-self.size.width / 2 + nodeSocial.size.width / 2, -self.size.height / 2)
        nodeSocial.anchorPoint = CGPointMake(0.5, 0)
        self.addChild(nodeSocial)
        
        nodeAmbiental = SKSpriteNode(color: nil, size: CGSizeMake(60.0, (CGFloat(ambiental)/100) * self.size.height))
        nodeAmbiental.position = CGPointMake(nodeSocial.position.x + nodeAmbiental.size.width + 5, -self.size.height / 2)
        nodeAmbiental.anchorPoint = CGPointMake(0.5, 0)
        self.addChild(nodeAmbiental)
        
        nodeEconomico = SKSpriteNode(color: nil, size: CGSizeMake(60.0, (CGFloat(economico)/100) * self.size.height))
        nodeEconomico.position = CGPointMake(nodeAmbiental.position.x + nodeEconomico.size.width + 5, -self.size.height / 2)
        nodeEconomico.anchorPoint = CGPointMake(0.5, 0)
        self.addChild(nodeEconomico)
    }
    
    
    private func inicializarLabels(){
        lblSocial = SKLabelNode(fontNamed: "Saniretro")
        lblSocial.fontSize = 19
        lblSocial.text = "\(Int(social))%"
        lblSocial.position = CGPointMake(0, 5)
        nodeSocial.addChild(lblSocial)
        
        lblAmbiental = SKLabelNode(fontNamed: "Saniretro")
        lblAmbiental.fontSize = 19
        lblAmbiental.text = "\(Int(ambiental))%"
        lblAmbiental.position = CGPointMake(0, 5)
        nodeAmbiental.addChild(lblAmbiental)
        
        lblEconomico = SKLabelNode(fontNamed: "Saniretro")
        lblEconomico.fontSize = 19
        lblEconomico.text = "\(Int(economico))%"
        lblEconomico.position = CGPointMake(0, 5)
        nodeEconomico.addChild(lblEconomico)
    }
    
    
    func alterarValoresDoGrafico(){
        if(!nodeSocial.hasActions() && !nodeAmbiental.hasActions() && !nodeEconomico.hasActions()){
            timer.invalidate()
            timer = nil
            
            lblSocial.text = "\(Int(social))%"
            lblAmbiental.text = "\(Int(ambiental))%"
            lblEconomico.text = "\(Int(economico))%"
            return
        }
        
        var valorSocial = Int((self.nodeSocial.size.height*100) / self.size.height)
        var valorAmbiental = Int((self.nodeAmbiental.size.height*100) / self.size.height)
        var valorEconomico = Int((self.nodeEconomico.size.height*100) / self.size.height)
        
        changeBackgroundColor(valorSocial, valorMinimo: 20, node: nodeSocial)
        changeBackgroundColor(valorAmbiental, valorMinimo: 20, node: nodeAmbiental)
        changeBackgroundColor(valorEconomico, valorMinimo: 20, node: nodeEconomico)
        
        self.lblSocial.text = "\(valorSocial)%"
        self.lblAmbiental.text = "\(valorAmbiental)%"
        self.lblEconomico.text = "\(valorEconomico)%"
    }
    
    
    private func changeBackgroundColor(valorAtual:Int, valorMinimo:Int, node:SKSpriteNode){
        if(valorAtual < valorMinimo){
            node.color = UIColor.redColor()
            
        }else{
            node.color = UIColor(red: 127/255, green: 127/255, blue: 127/255, alpha: 1)
        }
    }
    
    
    func setValoresGrafico(valorSocial:Float, valorAmbiental:Float, valorEconomico:Float){
        var actionSocial = gerarAction(social, valorNovo: valorSocial)
        var actionAmbiental = gerarAction(ambiental, valorNovo: valorAmbiental)
        var actionEconomico = gerarAction(economico, valorNovo: valorEconomico)
        
        social = valorSocial
        ambiental = valorAmbiental
        economico = valorEconomico
        
        nodeSocial.runAction(actionSocial)
        nodeAmbiental.runAction(actionAmbiental)
        nodeEconomico.runAction(actionEconomico)
        
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: Selector("alterarValoresDoGrafico"), userInfo: nil, repeats: true)

    }
    
    
    private func gerarAction(valorAntigo:Float, valorNovo:Float) -> SKAction{
        if(valorAntigo < valorNovo){
            var distanciaDescida:CGFloat = -5
            if(valorAntigo < 5){
                distanciaDescida = 0
            }
            var actionDown = SKAction.resizeByWidth(0, height: distanciaDescida, duration: 0.3)
            actionDown.timingMode = SKActionTimingMode.EaseOut
            var actionUp = SKAction.resizeToHeight((CGFloat(valorNovo)/100) * self.size.height, duration: 0.5)
            actionUp.timingMode = SKActionTimingMode.EaseIn
            return SKAction.sequence([actionDown, actionUp])
            
        }else{
            return SKAction.resizeToHeight((CGFloat(valorNovo)/100) * self.size.height, duration: 0.5)
        }
    }
}
