//
//  TelaPrincipal.swift
//  More
//
//  Created by William Alvelos on 21/05/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import Foundation
import SpriteKit

class TelaPrincipal: SKScene, SKPhysicsContactDelegate{
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Heveltica")
        myLabel.text = "Play!";
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        let play = SKSpriteNode(imageNamed: "Play")
        play.xScale = 0.5
        play.yScale = 0.5
        play.position = CGPointMake(frame.size.width/2 ,frame.size.height/2)
        play.name = "play"
        
        
        
        
        self.addChild(play)
        self.addChild(myLabel)
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            var node = self.nodeAtPoint(location)
            
            if (node.name == "play") {
                node.removeFromParent()
                
                
                
            }
            
            //            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            //
            //            sprite.xScale = 0.5
            //            sprite.yScale = 0.5
            //            sprite.position = location
            //
            //            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            //
            //            sprite.runAction(SKAction.repeatActionForever(action))
            //
            //            self.addChild(sprite)
        }
    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
