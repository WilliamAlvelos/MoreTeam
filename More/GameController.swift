//
//  GameController.swift
//  More
//
//  Created by Felipe Costa Nascimento on 5/27/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit
import CoreData

class GameController:AbstractSceneDelegate{
    
    var gameView:SKView!
    var mundo:MundoScene!
    
    init(view:SKView){
        gameView = view
        mundo = MundoScene(size: gameView.frame.size)
        mundo.myDelegate = self
    }
    
    
    func backToWorld(){
        mundo.atualizarCena()
        gameView.presentScene(mundo)
    }
    
    
    func goToFabrica(fabrica:NSManagedObject){
        let fabricaScene = FabricaScene(fabrica: fabrica, size: gameView.frame.size)
        fabricaScene.myDelegate = self
        gameView.presentScene(fabricaScene)
    }
    
    
    func goToLoja(loja:NSManagedObject){
        let lojaScene = LojaScene(size: gameView.frame.size)
        lojaScene.myDelegate = self
        gameView.presentScene(lojaScene)
    }
    
    
    func startGame(){
        gameView.presentScene(mundo)
        mundo.myDelegate = self
    }
    
}
