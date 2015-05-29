//
//  GraficoNode.swift
//  More
//
//  Created by Felipe Costa Nascimento on 5/29/15.
//  Copyright (c) 2015 MoreTeam. All rights reserved.
//

import SpriteKit

class GraficoNode: SKSpriteNode {
    
    var social:CGFloat!
    var ambiental:CGFloat!
    var economico:CGFloat!
    
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
    
    
    private func inicializarNodes(){
        nodeSocial = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(60.0, (social/100) * self.size.height))
        nodeAmbiental = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(60.0, (ambiental/100) * self.size.height))
        nodeEconomico = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(60.0, (economico/100) * self.size.height))
    }
}
