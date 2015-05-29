//
//  GraficoNode.swift
//  More
//
//  Created by Felipe Costa Nascimento on 5/29/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit

class GraficoNode: SKSpriteNode {
    
    var social:Float!
    var ambiental:Float!
    var economico:Float!
    
    var nodeSocial:SKSpriteNode!
    var nodeAmbiental:SKSpriteNode!
    var nodeEconomico:SKSpriteNode!
    
    init(size:CGSize){
        super.init(texture: nil, color: UIColor.greenColor(), size: size)
        self.zPosition = 1
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
