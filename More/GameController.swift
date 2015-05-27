//
//  GameController.swift
//  More
//
//  Created by Felipe Costa Nascimento on 5/27/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit


class GameController:AbstractSceneDelegate{
    var gameView:SKView!
    
    var mundo:Mundo!
    
    
    
    init(view:SKView){
        gameView = view
        mundo = Mundo(size: gameView.frame.size)
        mundo.myDelegate = self
    }
    
    
    func backToWorld() {
        
    }
    
    
    func showScene(scene: AbstractScene) {
        gameView.presentScene(scene)
    }
    
    
    func startGame(){
        gameView.presentScene(mundo)
    }
    
}
