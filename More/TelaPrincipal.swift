//
//  TelaPrincipal.swift
//  More
//
//  Created by William Alvelos on 21/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import Foundation
import SpriteKit

class TelaPrincipal: SKScene{
    
    var gameController:GameController!
    
    
    init(size: CGSize, view:SKView) {
        super.init(size: size)
        gameController = GameController(view: view)
        self.backgroundColor = UIColor.whiteColor()
        
        var nodeSplash = SKSpriteNode(imageNamed: "splash")
        nodeSplash.position = CGPointMake(self.size.width / 2, self.size.height / 2)
        self.addChild(nodeSplash)
        
        var nodeButton = SKSpriteNode(imageNamed: "splash-button")
        nodeButton.position = CGPointMake(self.size.width / 2, self.size.height / 2 - nodeButton.size.height)
        nodeButton.name = "start"
        self.addChild(nodeButton)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */

        
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            var node = self.nodeAtPoint(location)
            
            if (node.name == "start") {
                //node.removeFromParent()
                gameController.startGame()
                
            }
            
        }
    }
    
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
