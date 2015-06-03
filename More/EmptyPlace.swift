//
//  EmptyPlace.swift
//  test
//
//  Created by Felipe Costa Nascimento on 5/24/15.
//  Copyright (c) 2015 Felipe Costa Nascimento. All rights reserved.
//

import SpriteKit

class EmptyPlace: SKSpriteNode {
    
    
    init(){
        super.init(texture: nil, color: nil, size: CGSizeMake(59, 28))
        
        self.zPosition = 1
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    
    func showEmptyPlace(){
        if(children.count == 0){
            //self.color = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
            self.texture = SKTexture(imageNamed: "m1")
            self.name = "empty place"
        }
    }
    
    
    func hiddeEmptyPlace(){
        self.name = nil
        self.texture = nil
        //nodeEmpty.alpha = 0
        //self.color = UIColor.clearColor()
    }
    

}
