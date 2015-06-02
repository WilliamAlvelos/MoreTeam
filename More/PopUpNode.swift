//
//  PopUpNode.swift
//  More
//
//  Created by Felipe Costa Nascimento on 6/2/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit

class PopUpNode: SKSpriteNode {
    
    var nodePrincipal:SKSpriteNode!
    var lblTitulo:SKLabelNode!
    
    
    init(size:CGSize){
        super.init(texture: nil, color: SKColor(red: 0, green: 0, blue: 0, alpha: 0.5), size: size)
        
        self.alpha = 0
        
        
        nodePrincipal = SKSpriteNode(color: UIColor.whiteColor(), size: CGSizeMake(self.size.width / 1.5, self.size.height / 2))
        self.addChild(nodePrincipal)
        
        lblTitulo = SKLabelNode(fontNamed: "Helvetica")
        lblTitulo.text = "Título"
        lblTitulo.fontColor = UIColor.blackColor()
        lblTitulo.position = CGPointMake(0, nodePrincipal.size.height / 2 - 40)
        nodePrincipal.addChild(lblTitulo)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func showPopUp(){
        self.runAction(SKAction.fadeAlphaTo(1, duration: 0.5))
    }
}
