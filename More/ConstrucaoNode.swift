//
//  ConstrucaoNode.swift
//  More
//
//  Created by Felipe Costa Nascimento on 6/4/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit
import CoreData


class AbstractConstruction : SKSpriteNode{
    
    var constructionData:NSManagedObject!
    
    var IMAGE_NAME:String!
    var delegate:AbstractSceneDelegate?
    var actionSwing:SKAction!
    
    
    init(imageNamed:String, size:CGSize){
        super.init(texture: SKTexture(imageNamed: imageNamed), color: nil, size: size)
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func startSwingAnimation(){
        self.runAction(actionSwing)
    }
    
    
    func atualizarSprite(){
        var qtdFuncionario = constructionData.valueForKey("qtdFuncionario") as! Int
        
        if(qtdFuncionario > 0){
            startSwingAnimation()
        
        }else{
            self.removeAllActions()
            self.texture = SKTexture(imageNamed: "\(IMAGE_NAME)01")
        }
    }
}
