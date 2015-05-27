//
//  Loja.swift
//  More
//
//  Created by Felipe Costa Nascimento on 5/27/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit




class Loja : SKSpriteNode{
    
    var delegate:MundoDelegate!
    var lojaScene:AbstractScene!
    
    
    init(size:CGSize){
        super.init(texture: SKTexture(imageNamed: "loja.png"), color: nil, size: size)
        
        self.zPosition = 1
        self.name = "loja"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        delegate.showScene(lojaScene)
    }
    
}