//
//  GameController.swift
//  More
//
//  Created by Felipe Costa Nascimento on 5/27/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit


protocol GameControllerDelegate{
    
}


class GameController {
    var gameView:SKView!
    
    var mundo:Mundo!
    var vtFabricas:NSMutableArray!
    var vtLojas:NSMutableArray!
    
    
    
    init(view:SKView){
        gameView = view
        mundo = Mundo(size: view.frame.size)
        vtFabricas = NSMutableArray()
        vtLojas = NSMutableArray()
        
    }
}
