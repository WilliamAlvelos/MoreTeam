//
//  ButtonNode.swift
//  More
//
//  Created by Felipe Costa Nascimento on 6/5/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit

protocol ButtonNodeDelegate{
    func touchedButtonWithName(buttonName:String)
}


class ButtonNode: SKSpriteNode {
    
    var delegate:ButtonNodeDelegate?
    
    var startImage:SKTexture!
    var touchImage:SKTexture!
    
    
    init(startImageName:String, touchImageName:String, buttonName:String){
        super.init(texture: SKTexture(imageNamed: startImageName), color: nil, size: CGSizeMake(190, 125))
        
        startImage = SKTexture(imageNamed: startImageName)
        touchImage = SKTexture(imageNamed: touchImageName)
        self.userInteractionEnabled = true
        self.zPosition = 1
        self.name = buttonName
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.texture = touchImage
    }
    
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.texture = startImage
        delegate?.touchedButtonWithName(self.name!)
    }
}
