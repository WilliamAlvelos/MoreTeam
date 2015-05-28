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
        gameView.presentScene(mundo)
    }
    
    
    func goToFabrica(fabrica:SKSpriteNode){
        let fabrica = FabricaScene(size: gameView.frame.size)
        gameView.presentScene(fabrica)
    }
    
    
    func goToLoja(loja:SKSpriteNode){
        let loja = LojaScene(size: gameView.frame.size)
        gameView.presentScene(loja)
    }
    
    
    func startGame(){
        gameView.presentScene(mundo)
        mundo.myDelegate = self
    }
    
}
