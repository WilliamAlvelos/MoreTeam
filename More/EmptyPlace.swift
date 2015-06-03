//
//  EmptyPlace.swift
//  test
//
//  Created by Felipe Costa Nascimento on 5/24/15.
//  Copyright (c) 2015 Felipe Costa Nascimento. All rights reserved.
//

import SpriteKit

class EmptyPlace: SKSpriteNode {
    var nodeEmpty:SKSpriteNode!
    
    
    init(){
        super.init(texture: nil, color: nil, size: CGSizeMake(59, 28))
        
        nodeEmpty = SKSpriteNode(imageNamed: "m1.png")
        nodeEmpty.zPosition = 2
        self.addChild(nodeEmpty)
        self.zPosition = 1
        nodeEmpty.alpha = 0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    
    func showEmptyPlace(){
        if(children.count == 0){
            //self.color = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
            nodeEmpty.alpha = 1
            self.name = "empty place"
        }
    }
    
    
    func hiddenEmptyPlace(){
        self.name = nil
        nodeEmpty.alpha = 0
        //self.color = UIColor.clearColor()
    }
    

}
