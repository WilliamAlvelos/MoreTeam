//
//  ButtonSound.swift
//  More
//
//  Created by Felipe Costa Nascimento on 6/12/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit


protocol ButtonSoundDelegate{
    func touchedSound(soundOff:Bool)
}


class ButtonSound : SKSpriteNode{
    
    private var soundOff:Bool = false
    private var soundImage:SKSpriteNode!
    var delegate:ButtonSoundDelegate?
    
    init(size:CGSize){
        super.init(texture: nil, color: nil, size: size)
        
        self.userInteractionEnabled = true
        self.zPosition = 1
        
        soundImage = SKSpriteNode(imageNamed: "sound-52")
        soundImage.size = CGSizeMake(29, 35)
        soundImage.zPosition = 1
        self.addChild(soundImage)
   }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        soundOff = !soundOff
        changeTexture()
        delegate?.touchedSound(soundOff)
    }
    
    
    
    private func changeTexture(){
        if(soundOff){
            soundImage.texture = SKTexture(imageNamed: "sound-51")
            
            
        }else{
            soundImage.texture = SKTexture(imageNamed: "sound-52")
        }
    }
    
    
    func changeToSoundOff(soundState:Bool){
        soundOff = soundState
        
        changeTexture()
    }
}
