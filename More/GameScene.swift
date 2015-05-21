//
//  GameScene.swift
//  More
//
//  Created by Lucca Marmion on 21/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    //var fundoFabrica = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */

    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)

        }
    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
