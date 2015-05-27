//
//  EmptyPlace.swift
//  test
//
//  Created by Felipe Costa Nascimento on 5/24/15.
//  Copyright (c) 2015 Felipe Costa Nascimento. All rights reserved.
//

import SpriteKit

class EmptyPlace: SKSpriteNode {
  
    init(size:CGSize){
        super.init(texture: nil, color: UIColor.clearColor(), size: size)
        
        self.zPosition = 1
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    
    func showEmptyPlace(){
        if(children.count == 0){
            self.color = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
            self.name = "empty place"
        }
    }
    
    
    func hiddenEmptyPlace(){
        self.name = nil
        self.color = UIColor.clearColor()
    }
    

}
